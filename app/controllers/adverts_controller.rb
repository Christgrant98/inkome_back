class AdvertsController < ApplicationController
  skip_before_action :authorize_request, only: :index

  def index
    adverts = Advert.all
    render json: adverts
  end

  def create
    advert = Advert.create(create_params)
    render json: advert, status: :created
  end

  private
  def create_params
    params.require(:advert).permit(
      :name,
      :age,
      :description,
      :phone,
    )
  end
end