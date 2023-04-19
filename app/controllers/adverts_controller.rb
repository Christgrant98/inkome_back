class AdvertsController < ApplicationController
  skip_before_action :authorize_request, only: :index

  def index
    adverts = Advert.all
    render json: adverts, each_serializer: AdvertSerializer
  end

  def create
    @advert = Advert.new(create_params)
    @advert.add_images_from_base64(params[:advert][:images])

    if @advert.save
      render json: @advert, serializer: AdvertSerializer, status: :created
    else
      render json: { error: @advert.errors.full_messages.first },
             status: :unprocessable_entity
    end
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