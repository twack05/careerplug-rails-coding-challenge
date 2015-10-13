class JobsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  def index
    @jobs = Job.all
  end

  def new
    @job = Job.new
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
    params.require(:job).permit(:name, :description, :status, :employment_type)
  end
end
