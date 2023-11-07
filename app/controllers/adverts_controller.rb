class AdvertsController < ApplicationController
  skip_before_action :authorize_request, only: :index
  before_action :set_current_user, only: :index

  def index
    page = params[:page] || 1
    per_page = params[:per_page] || 10
    filter = params[:filter] || ''
  
    adverts = Advert.where("LOWER(name) ILIKE ?", "%#{filter}%")
                    .or(Advert.where("LOWER(ad_tags) ILIKE ?", "%#{filter}%"))
                    .offset((page.to_i - 1) * per_page.to_i)
                    .limit(per_page)
  
    render(
      json: adverts,
      each_serializer: AdvertSerializer,
      serializer_options: { current_user: @current_user },
    )
  end

  def user_ads
    adverts = @current_user.adverts
    render json: adverts, each_serializer: AdvertSerializer
  end
  

  def favorites
    if @current_user
      page = params[:page] || 1
      per_page = params[:per_page] || 10

      fav_adverts = @current_user.advert_favorites
                                .includes(:advert)
                                .offset((page.to_i - 1) * per_page.to_i)
                                .limit(per_page)
                                .map(&:advert)

      render json: fav_adverts, each_serializer: AdvertSerializer,
             serializer_options: { current_user: @current_user }
    else
      render json: { error: 'Usuario no autenticado' }, status: :unauthorized
    end
  end

  def tags
    tags = Advert.all.pluck(:ad_tags).compact.flat_map { |tags_str| tags_str.split(",") }
    render json: tags
  end
  


  def create
    @advert = Advert.new(create_params)
    @advert.user_id = @current_user.id
    @advert.ad_tags = nil if params[:advert][:ad_tags].nil? # Agrega esta línea
  
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
      :user_id,
      :name,
      :age,
      :description,
      :phone,
      :ad_tags,  
      images: []
    )
  end
end
