class AdvertFavoritesController < ApplicationController
  def create
    @advert = Advert.find(params[:advert_id])
    if !@advert.is_fav(@current_user)
      @favorite = @advert.advert_favorites.build(user: @current_user)
      if @favorite.save
        render status: :ok
      else
        render json: { error: { message: @favorite.errors.messages.first } }, status: :unprocessable_entity
      end
    else
      render status: :ok
    end
  end

  def destroy
    @favorite = AdvertFavorite.find_by(user_id: @current_user, advert_id: params[:advert_id])

    if @favorite&.destroy
      render status: :ok
    else
      render json: { error: { message: @favorite.errors.messages.first } }, status: :unprocessable_entity
    end
  end
end