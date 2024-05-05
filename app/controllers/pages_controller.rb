class PagesController < ApplicationController
  include Pagy::Backend
  def home
    @pagy, @posts = pagy(current_user.feed.includes(:user).includes(:comments), items: 5)
    render 'scrollable_content' if params[:page]
  end
end
