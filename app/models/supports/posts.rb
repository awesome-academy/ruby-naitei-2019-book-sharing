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

  def load_books
    Book.all.order_asc.map{|p| [p.name, p.id]}
  end

  def find_book
    params = @post[:param]
    Book.find_by id: params[:book_id]
  end
end
