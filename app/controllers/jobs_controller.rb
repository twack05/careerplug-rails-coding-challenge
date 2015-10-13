class JobsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]

  def index
    if params[:search]
      @jobs = Job.search(params[:search], current_user.id)
      @query = params[:search]
    else
      @jobs = Job.where(user_id: current_user.id)
    end
  end

  def new
    @job = Job.new(user_id: current_user.id)
  end

  def create
    @job = Job.new(permitted_params)
    respond_to do |format|
      if @job.save
        format.html { redirect_to root_path, notice: 'Your job has been posted.' }
      else
        format.html { render :new }
      end
    end
  end

  private

  def permitted_params
    params.require(:job).permit(:name, :description, :status, :employment_type, :user_id)
  end
end
