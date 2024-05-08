class FollowsController < ApplicationController
  include Pagy::Backend
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers
    @pagy, @followers = pagy(@followers, items: 10)
  end

  def followees
    @user = User.find(params[:id])
    @followees = @user.followees
    @pagy, @followees = pagy(@followees, items: 10)
  end

  def destroy
    @user = User.find(params[:id])
    if current_user.delete_follow(@user) == 'follower'
      redirect_to followers_user_path(current_user)
    else
      redirect_to followees_user_path(current_user)
    end
  end
end
