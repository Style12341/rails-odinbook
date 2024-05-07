class PagesController < ApplicationController
  include Pagy::Backend
  def home
    @pagy, @posts = pagy(current_user.feed.includes(:user), items: 5)
    render 'posts/scrollable_content' if params[:page]
  end
end
