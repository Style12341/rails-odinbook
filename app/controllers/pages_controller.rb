class PagesController < ApplicationController
  def home
    @posts = current_user.feed
  end
end
