class Api::V1::CommentsController < ApplicationController
  before_action :authorize_request
  before_action :set_post
  before_action :set_comment, only: [:destroy]

  def index
    comments = @post.comments.includes(:user)

    render json: {
      success: true,
      comments: comments.as_json(
        include: {
          user: {
            only: [:id, :name, :email]
          }
        }
      )
    }, status: :ok
  end

  def create
    comment = @post.comments.new(comment_params)
    comment.user = @current_user

    if comment.save
      render json: {
        success: true,
        message: "Comment created successfully",
        comment: comment
      }, status: :created
    else
      render json: {
        success: false,
        errors: comment.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def destroy
    if @comment.user_id != @current_user.id
      return render json: {
        success: false,
        message: "You are not authorized"
      }, status: :forbidden
    end

    @comment.destroy

    render json: {
      success: true,
      message: "Comment deleted successfully"
    }, status: :ok
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end