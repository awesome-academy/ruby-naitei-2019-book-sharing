class SessionsController < ApplicationController
  def new; end

  def create
    if params[:session].present?
      user = User.find_by email: params[:session][:email].downcase
      if user&.authenticate params[:session][:password]
        check_remember user
        redirect_back_or root_path
      else
        flash[:danger] = t "invalid_combi"
        render :new
      end
    else
      login_facebook user
      redirect_to root_url
    end
  end

  def destroy
    destroy_user_session if user_signed_in?
    redirect_to root_url
  end

  private

  def check_remember user
    if params[:session][:remember_me] == "1"
      remember user
    else
      forget user
    end
  end

  def login_facebook user
    user = User.from_omniauth(request.env["omniauth.auth"])
    if user.persisted?
      sign_in user
    else
      flash[:warning] = t "fb_error"
    end
  end

  def failure
    redirect_to root_path
    flash[:warning] = t "failure_fb"
  end
end
