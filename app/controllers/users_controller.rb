class UsersController < ApplicationController
  before_action :authorize_request, except: :create  
  before_action :find_user, except: :create

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save  
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages },  
             status: :unprocessable_entity  
    end
  end

  # PUT /users/{email}
  def update
    unless @user.update(user_params)  
      render json: { errors: @user.errors.full_messages }, 
             status: :unprocessable_entity
    end
  end

  private

  def find_user
    @user = User.find_by_email!(params[:email]) 
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'User not found' }, status: :not_found
  end

  def user_params
    params.require(:user).permit(
      :fullname, :phone, :age, :email, :password,
    )
  end
end
