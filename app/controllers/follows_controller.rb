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
    respond_to do |format|
      current_user.delete_follow(@user)
      if params[:type] == 'Unfollow'
        format.html { redirect_to user_path(current_user) }
        format.turbo_stream { render 'follows/unfollow_button', locals: { user: @user } }
      else
        format.html { redirect_to user_path(current_user), alert: 'Something went wrong' }
        format.turbo_stream { render 'follows/delete_follow_button', locals: { user: @user } }
      end
    end
  end
end
