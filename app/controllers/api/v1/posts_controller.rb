class Api::V1::PostsController < ApplicationController
  before_action :authorize_request
  before_action :find_post, only: [:show, :update, :destroy]

  def index
    posts = Post.includes(:user)
                .order(created_at: :desc)

    posts = posts.where(status: params[:status]) if params[:status].present?

    if params[:search].present?
      posts = posts.where("title ILIKE ?", "%#{params[:search]}%")
    end

    pagy, records = pagy(posts, limit: 10)

    success_response(
      message: "Posts fetched successfully",
      data: {
        posts: records.map { |post| PostSerializer.new(post).as_json },
        pagination: pagy_metadata(pagy)
      }
    )
  end

  def show
    success_response(
      message: "Post fetched successfully",
      data: {
        post: PostSerializer.new(@post).as_json
      }
    )
  end

  def create
    post = current_user.posts.new(post_params)

    if post.save
      success_response(
        message: "Post created successfully",
        data: {
          post: PostSerializer.new(post).as_json
        },
        status: :created
      )
    else
      error_response(
        message: "Post creation failed",
        errors: post.errors.full_messages
      )
    end
  end

  def update
    unless owns_post?(@post)
      return error_response(
        message: "Forbidden access",
        status: :forbidden
      )
    end

    if @post.update(post_params)
      success_response(
        message: "Post updated successfully",
        data: {
          post: PostSerializer.new(@post).as_json
        }
      )
    else
      error_response(
        message: "Post update failed",
        errors: @post.errors.full_messages
      )
    end
  end

  def destroy
    unless owns_post?(@post)
      return error_response(
        message: "Forbidden access",
        status: :forbidden
      )
    end

    @post.destroy

    success_response(
      message: "Post deleted successfully"
    )
  end

  private

  def find_post
    @post = Post.find_by(id: params[:id])

    return if @post.present?

    error_response(
      message: "Post not found",
      status: :not_found
    )
  end

  def owns_post?(post)
    current_user.id == post.user_id || current_user.admin?
  end

  def post_params
    params.permit(:title, :content, :status)
  end
end