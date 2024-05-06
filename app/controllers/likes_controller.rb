class LikesController < ApplicationController
  def create
    @like = current_user.likes.new(like_params)
    respond_to do |format|
      if @like.save
        format.html { redirect_back(fallback_location: root_path) }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('like_button', partial: 'likes/button',
                                                                   locals: { like: @like, likeable: @like.likeable })
        end
      else
        format.html { redirect_back(fallback_location: root_path) }
      end
    end
  end

  def destroy
    @like = Like.find(params[:id])
    respond_to do |format|
      if @like.destroy
        format.html { redirect_back(fallback_location: root_path) }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('like_button', partial: 'likes/button',
                                                                   locals: { like: nil, likeable: @like.likeable })
        end
      else
        format.html { redirect_back(fallback_location: root_path) }
      end
    end
  end

  def toggle
    @like = current_user.likes.find_by(like_params)
    if @like
      @like.destroy
    else
      @like = current_user.likes.create(like_params)
    end
    head :ok, content_type: "text/html"
  end

  private

  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type)
  end
end
