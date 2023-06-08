class AdvertsController < ApplicationController
  skip_before_action :authorize_request, only: :index
  before_action :set_current_user, only: :index

  def index
    adverts = Advert.all
    render(
      json: adverts,
      each_serializer: AdvertSerializer,
      serializer_options: { current_user: @current_user },
    )
  end

  def create
    @advert = Advert.new(create_params)

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
      images: [],
    )
  end
end