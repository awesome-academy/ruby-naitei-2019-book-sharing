class PostsController < ApplicationController
  before_action :load_post, only: :show
  before_action :load_support

  def index
    @posts = Post.all
  end

  def show; end

  private

  def load_post
    @post = Post.find_by id: params[:id]

    return if @post
    flash[:warrning] = t "post_not_found"
    redirect_to root_path
  end

  def load_support
    @support = Supports::Posts.new post: Post.all, param: params
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
