class FollowersController < ApplicationController
  before_action :load_user, only: :new
  def new
    @title = t "followers"
    @users = @user.followers.page(params[:page])
    render "users/show_follow"
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash.now[:warrning] = t "user_not_found"
    redirect_to root_path
  end
end
