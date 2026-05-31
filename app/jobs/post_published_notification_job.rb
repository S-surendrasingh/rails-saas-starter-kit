class PostPublishedNotificationJob < ApplicationJob
  queue_as :default

  def perform(post_id)
    post = Post.find_by(id: post_id)

    return unless post.present?

    Rails.logger.info "Notification sent for Post ##{post.id}"
  end
end
