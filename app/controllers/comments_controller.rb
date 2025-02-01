class CommentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @comments = Comment.top_level
  end

  def create
    @comment = current_user.comments.build(comment_params)

    if @comment.save
      redirect_to @comment.project, notice: "Comment was successfully created."
    else
      redirect_to @comment.project, alert: "Comment was not created."
    end
  end


  private
  def set_comment
    @comment = Comment.find(params.expect(:id))
  end

  def comment_params
    params.expect(comment: [ :content, :project_id, :parent_id, :user_id ])
  end

end
