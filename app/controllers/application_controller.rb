class ApplicationController < ActionController::API
  include ApiError

  before_action :authorized
  before_action :check_user_enabled_two_factor, if: :logged_in?

  def encode_token payload
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  def auth_header
    # Authorization: 'Bearer <token>'
    request.headers['Authorization']
  end

  def decode_token
    if auth_header
      token = auth_header.split(' ')[1]
      begin
        JWT.decode(token, Rails.application.secrets.secret_key_base, true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def logged_in_user
    if decode_token
      user_id = decode_token[0]["user_id"]
      @user = User.find_by id: user_id
    end
  end

  def logged_in?
    !!logged_in_user
  end

  def authorized
    return render json: json_error_by_code(3), status: :unauthorized unless logged_in?
  end

  def current_user
    @user || nil
  end

  def check_user_enabled_two_factor
    return if current_user && current_user.otp_module_enabled?
    render json: json_error_by_code(2), status: :unauthorized
  end
end
