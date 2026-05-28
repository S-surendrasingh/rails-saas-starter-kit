class PostSerializer
  def initialize(post)
    @post = post
  end

  def as_json
    {
      id: @post.id,
      title: @post.title,
      content: @post.content,
      status: @post.status,
      created_at: @post.created_at,
      author: {
        id: @post.user.id,
        name: @post.user.name,
        email: @post.user.email
      }
    }
  end
end