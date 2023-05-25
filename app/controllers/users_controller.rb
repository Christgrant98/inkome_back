class UsersController < ApplicationController
  before_action :authorize_request, except: :create  
  before_action :find_user, except: :create
  rescue_from ActiveRecord::RecordNotFound, with: :handle_user_not_found

  # POST /users
  def create
    
    @user = User.new(create_params)
  
    if @user.save
      render json: @user, status: :created
    else
      render json: { error: @user.errors.full_messages.first },  
             status: :unprocessable_entity
    end
  end

  # PUT /users/:id
  def update
    if @user.update(update_params)
      render json: {user: @user}, status: :ok
    else
      render json: { error: @user.errors.full_messages.first }, status: :unprocessable_entity
    end
  end

  private

  def find_user
    @user = User.find_by_id(params[:id])
    unless @user
      raise ActiveRecord::RecordNotFound
    end
  end

  def handle_user_not_found
    render json: { error: 'User not found' }, status: :not_found
  end

  def create_params
    params.require(:user).permit(
      :fullname, :phone, :age, :email, :password, :birthdate, :image,
    )
  end

  def update_params
    params.require(:user).permit(
      :fullname, :phone, :age, :email, :birthdate, :image,
    )
  end
end