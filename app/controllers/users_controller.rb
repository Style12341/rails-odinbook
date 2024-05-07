class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @pagy, @posts = @user.posts
    @pagy, @posts = pagy(@user.posts, items: 5)
    render 'scrollable_content' if params[:page]
  end
end
