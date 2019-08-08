class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase

    if user&.authenticate params[:session][:password]
      check_remember user
      redirect_back_or root_path
    else
      flash[:danger] = t "invalid_combi"
      render :new
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
end
