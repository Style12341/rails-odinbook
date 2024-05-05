class LikesController < ApplicationController
  def create
    @like = current_user.likes.new(like_params)
    locals = { like: @like, likeable: @like.likeable }
    respond_to do |format|
      if @like.save
        format.html { redirect_back(fallback_location: root_path) }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('like_button', partial: 'likes/button', locals:)
        end
      else
        format.html { redirect_back(fallback_location: root_path) }
      end
    end
  end

  def destroy
    @like = Like.find(params[:id])
    locals = { like: nil, likeable: @like.likeable }
    respond_to do |format|
      if @like.destroy
        format.html { redirect_back(fallback_location: root_path) }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('like_button', partial: 'likes/button', locals:)
        end
      else
        format.html { redirect_back(fallback_location: root_path) }
      end
    end
  end

  private

  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type)
  end
end
