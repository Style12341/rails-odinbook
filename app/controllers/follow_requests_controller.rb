class FollowRequestsController < ApplicationController
  def create
    @user = User.find(params[:id])
    if current_user.send_follow(@user)
      redirect_to followers_user_path(current_user)
    else
      redirect_to followers_user_path(current_user), alert: 'Something went wrong'
    end
  end

  def follow_requests
    @follow_requests = current_user.follow_requests
  end

  def accept
    @user = User.find(params[:id])
    if current_user.accept_follow(@user)
      redirect_to user_path(current_user)
    else
      redirect_to user_path(current_user), alert: 'Something went wrong'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if current_user.reject_follow(@user)
      redirect_to user_path(current_user)
    else
      redirect_to user_path(current_user), alert: 'Something went wrong'
    end
  end

  def cancel
    @user = User.find(params[:id])
    if current_user.cancel_follow_request(@user)
      redirect_to followers_user_path(current_user)
    else
      redirect_to followers_user_path(current_user), alert: 'Something went wrong'
    end
  end
end
