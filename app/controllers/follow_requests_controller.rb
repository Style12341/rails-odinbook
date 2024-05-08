class FollowRequestsController < ApplicationController
  def create
    @user = User.find(params[:id])
    respond_to do |format|
      if current_user.send_follow(@user)
        format.html { redirect_to user_path(current_user) }
        format.turbo_stream { render 'follow_requests/request_button', locals: { user: @user } }
      else
        format.html { redirect_to user_path(current_user), alert: 'Something went wrong' }
        format.turbo_stream
      end
    end
  end

  def follow_requests
    @follow_requests = current_user.follow_requests
  end

  def accept
    @user = User.find(params[:id])
    respond_to do |format|
      if current_user.accept_follow(@user)
        format.html { redirect_to user_path(current_user) }
        format.turbo_stream { render 'follow_requests/accept_button', locals: { sender: @user } }
      else
        format.html { redirect_to user_path(current_user), alert: 'Something went wrong' }
        format.turbo_stream { render 'follow_requests/accept_button', locals: { sender: @user } }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    respond_to do |format|
      if current_user.reject_follow(@user)
        format.html { redirect_to user_path(current_user) }
        format.turbo_stream { render 'follow_requests/accept_button', locals: { sender: @user } }
      else
        format.html { redirect_to user_path(current_user), alert: 'Something went wrong' }
        format.turbo_stream { render 'follow_requests/accept_button', locals: { sender: @user } }
      end
    end
  end

  def cancel
    @user = User.find(params[:id])
    respond_to do |format|
      if current_user.cancel_follow_request(@user)
        format.html { redirect_to user_path(current_user) }
        format.turbo_stream { render 'follow_requests/request_button', locals: { user: @user } }
      else
        format.html { redirect_to user_path(current_user), alert: 'Something went wrong' }
        format.turbo_stream
      end
    end
  end
end
