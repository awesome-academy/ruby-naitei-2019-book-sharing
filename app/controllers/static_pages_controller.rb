class StaticPagesController < ApplicationController
  before_action :get_feeds, only: :home
  def home
    @posts = Post.all.order_desc.page(params[:page]).per Settings.page_number
    @top_users = User.all.sort_by(&:count_getted_like).reverse.take(5)
  end

  private

  def get_feeds
    return unless user_signed_in?
    @item = current_user.feed.order_desc
    @feed_items = @item.page(params[:page]).per Settings.page_number
  end
end
