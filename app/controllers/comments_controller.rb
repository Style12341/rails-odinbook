class CommentsController < ApplicationController
  include Pagy::Backend
  def index
    @post = Post.find(params[:post_id])
    @pagy_comments, @comments = pagy(@post.comments.includes(:user).order(created_at: :desc), items: 5, page_param: :page_comments)
    puts "params[:page_comments]: #{params[:page_comments]}"
    render 'next_page' if params[:page_comments]
  end
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.turbo_stream
        format.html { redirect_to post_path(@post) }
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(@comment, partial: 'comments/form', locals: { comment: @comment })
        end
        format.html { render 'posts/show' }
      end
    end
  end

  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build
  end

  def destroy
    @comment = Comment.find(params[:id])
    respond_to do |format|
      if @comment.destroy
        format.turbo_stream { render turbo_stream: turbo_stream.remove(@comment) }
        format.html { redirect_to post_path(@comment.post) }
      else
        format.turbo_stream
        format.html { redirect_to root}
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
