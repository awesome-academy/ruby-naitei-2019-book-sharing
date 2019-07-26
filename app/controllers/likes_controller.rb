class LikesController < ApplicationController
  before_action :find_post, only: %i(create destroy)
  before_action :find_like, only: :destroy

  def create
    likes = @post.likes
    like = likes.create user_id: current_user.id
    render json: {likes_count: likes.size, like_id: like.id}
  end

  def destroy
    @like.destroy
    render json: {likes_count: @post.likes.size}
  end

  private

  def find_post
    @post = Post.find_by id: params[:post_id]

    return if @post
    flash[:warrning] = t "post_not_found"
    redirect_to root_path
  end

  def find_like
    @like = Like.find_by id: params[:id]

    return if @like
    flash[:warrning] = t "like_not_found"
    redirect_to root_path
  end
end
