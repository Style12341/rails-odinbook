class FollowsController < ApplicationController
  include Pagy::Backend
  def follows
    @pagy, @follows = pagy(current_user.following, items: 5)
    # render 'users/scrollable_content' if params[:page]
  end

  def followers
    @pagy, @followers = pagy(current_user.accepted_follows, items: 5)
    # render 'users/scrollable_content' if params[:page]
  end

  def follow_requests
    @pagy, @follow_requests = pagy(current_user.pending_follows, items: 5)
    # render 'users/scrollable_content' if params[:page]
  end
  def destroy
    follow = Follow.find(params[:id])
    follow.destroy
    redirect_to request.referer
  end
end
