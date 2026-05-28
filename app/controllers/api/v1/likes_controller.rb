class Api::V1::LikesController < ApplicationController
  before_action :authorize_request
  before_action :find_post

  def create
    like = @post.likes.new(user: current_user)

    if like.save
      success_response(
        message: "Post liked successfully"
      )
    else
      error_response(
        message: "Like failed",
        errors: like.errors.full_messages
      )
    end
  end

  def destroy
    like = @post.likes.find_by(user: current_user)

    unless like
      return error_response(
        message: "Like not found",
        status: :not_found
      )
    end

    like.destroy

    success_response(
      message: "Post unliked successfully"
    )
  end

  private

  def find_post
    @post = Post.find_by(id: params[:post_id])

    return if @post.present?

    error_response(
      message: "Post not found",
      status: :not_found
    )
  end
end
