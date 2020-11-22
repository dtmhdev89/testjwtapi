class UsersController < ApplicationController
  before_action :authorized, only: :auto_login

  def create
    @user = User.create user_params
    if @user.valid?
      token = encode_token user_id: @user.id
      render_json_token token
    else
      render json: {error: "Invalid username or password"}
    end
  end

  def login
    @user = User.find_by username: params[:username]

    if @user && @user.authenticate(params[:password])
      token = encode_token user_id: @user.id
      render_json_token token
    end
  end

  def auto_login
    render json: @user.as_json(only: :username)
  end

  private

  def user_params
    params.permit(:username, :password, :age)
  end

  def render_json_token token
    render json: {user: @user.username, token: token}
  end
end
