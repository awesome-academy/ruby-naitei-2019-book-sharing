class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(new create)
  before_action :load_user, except: %i(new create index)
  before_action :correct_user, only: %i(edit update)

  def index
    @users = User.page(params[:page]).per Settings.paginate_user
  end

  def show
    @posts = @user.posts.page(params[:page]).per Settings.paginate_post
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      flash[:info] = t "welcome"
      redirect_to root_url
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "Profile_updated"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def logged_in_user
    return if logged_in?
    store_location
    flash.now[:danger] = t ".please_login"
    redirect_to login_url
  end

  def correct_user
    return if current_user? @user
    flash[:danger] = t "Please_login"
    redirect_to root_url
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end

  def load_user
    @user = User.find_by id: params[:id]

    return if @user
    flash[:warrning] = t "user_not_found"
    redirect_to root_path
  end
end
