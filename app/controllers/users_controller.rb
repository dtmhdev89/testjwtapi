class UsersController < ApplicationController
  before_action :authorized, only: :auto_login
  skip_before_action :check_user_enabled_two_factor, only: [:create, :login]

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
    return render_json_failed 1 if @user.blank? || !@user.authenticate(params[:password])
    return return_access_token true if @user.otp_module_disabled?
    return render_json_failed unless @user.otp_module_enabled?
    return return_access_token if params[:otp_code_token] && is_valid_otp?
    render_json_failed 4
  end

  def auto_login
    render json: @user.as_json(only: :username)
  end

  private

  def user_params
    params.permit(:username, :password, :age)
  end

  def is_valid_otp?
    @user.authenticate_otp(params[:otp_code_token], drift: 60)
  end

  def return_access_token is_enable_tfa=false
    token = encode_token user_id: @user.id
    render_json_token token, is_enable_tfa
  end

  def render_json_token token, is_enable_tfa=false
    json_res = {user: @user.username, token: token}
    json_res.merge!(is_enable_tfa: true) if is_enable_tfa
    render json: json_res
  end

  def render_json_failed status_code=nil, status=:unauthorized
    render json: json_error_by_code(1), status: status unless status_code

    render json: json_error_by_code(status_code), status: status
  end
end
