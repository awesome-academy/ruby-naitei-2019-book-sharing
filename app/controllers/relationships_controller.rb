class RelationshipsController < ApplicationController
  def create
    @user = User.find_by id: params[:followed_id]
    current_user.follow @user
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end

  def destroy
    relationship = Relationship.find_by id: params[:id]

    if relationship
      @user = relationship.followed
      current_user.unfollow(@user)
    end
    respond_to do |format|
      format.html{redirect_to @user}

      if relationship.nil?
        format.js{flash.now[:danger] = t("user_not_found")}
      else
        format.js{flash.now[:message] = "#{t('unfollow')} #{@user.name}"}
      end
    end
  end
end
