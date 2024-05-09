class UsersController < ApplicationController
  # set user layout
  layout :resolve_layout
  include Pagy::Backend
  def index
    @pagy, @users = pagy(User.all, items: 5)
    render 'users/scrollable_content' if params[:page]
  end

  def show
    @user = User.find(params[:id])
    @pagy, @posts = pagy(@user.posts.order(created_at: :desc), items: 5)
    render 'posts/scrollable_content' if params[:page]
  end

  private

  def resolve_layout
    case action_name
    when 'index'
      'application'
    else
      'user'
    end
  end
end
