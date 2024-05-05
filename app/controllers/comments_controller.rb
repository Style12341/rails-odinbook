class CommentsController < ApplicationController
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
    @comment.destroy
    redirect_to post_path(@comment.post)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
