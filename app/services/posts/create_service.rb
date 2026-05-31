module Posts
  class CreateService
    def initialize(user:, params:)
      @user = user
      @params = params
    end

    def call
      post = @user.posts.new(@params)

      ActiveRecord::Base.transaction do
        post.save!

        enqueue_notification(post) if post.published?
      end

      post
    rescue ActiveRecord::RecordInvalid => e
      OpenStruct.new(
        success?: false,
        errors: e.record.errors.full_messages
      )
    end

    private

    def enqueue_notification(post)
      PostPublishedNotificationJob.perform_later(post.id)
    end
  end
end
