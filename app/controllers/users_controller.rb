class UsersController < ApplicationController
  # set user layout
  layout 'user'
  include Pagy::Backend
  def show
    @user = User.find(params[:id])
    @pagy, @posts = pagy(@user.posts.order(created_at: :desc), items: 5)
    render 'posts/scrollable_content' if params[:page]
  end
end
