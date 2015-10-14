class CommentsController < ApplicationController

  def create
    @comment = Comment.new(permitted_params)
      respond_to do |format|
        if @comment.save
          format.json { render :json => @comment }
        else
          format.html { redirect_to root_path, notice: 'There was an error saving your comment.' }
        end
      end
  end

  private

  def permitted_params
    params.require(:comment).permit(:author, :text, :job_id)
  end
end
