class PostsController < ApplicationController
  def index
    @posts = current_user.feed
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = current_user.posts.build(post_params)
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post }
        format.turbo_stream
      else
        flash[:post_error] = " Post can't be blank."
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    # Remove turbo tag with id post_show_#{post.id}
    render turbo_stream: turbo_stream.remove("post-show-#{post.id}")
  end

  def update
    post = Post.find(params[:id])
    if post.update(post_params)
      redirect_to post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def comment_section
    @post = Post.find(params[:post_id])
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
