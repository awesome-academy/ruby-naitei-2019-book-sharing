class Supports::Posts
  attr_reader :post

  def initialize post
    @post = post
  end

  def comments
    params = @post[:param]
    post = Post.find_by id: params[:id]

    post.comments.order_desc.page(params[:page]).per Settings.page_number
  end

  def new_comment
    Comment.new
  end
end
