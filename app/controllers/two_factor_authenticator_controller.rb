class TwoFactorAuthenticatorController < ApplicationController
  before_action :authorized
  skip_before_action :check_user_enabled_two_factor

  def generate_qrcode
    if current_user.otp_module_disabled?
      qr_uri = current_user.provisioning_uri(current_user.username, issuer: Settings.issuer)
      qr = RQRCode::QRCode.new(qr_uri, size: 10, level: :h )
      svg_file = qr.as_svg(offset: 0, color: '000', shape_rendering: 'crispEdges',
        module_size: 6, standalone: true)
      render_json_uri svg_file
    end
  end

  def enable_tfa
    return json_error_by_code(5) if current_user.otp_module_enabled?

    if params[:otp_code_token] && !!current_user.authenticate_otp(params[:otp_code_token], drift: 60)
      current_user.otp_module_enabled!
      render_json_success
    else
      render_json_fail json_error_by_code(4)
    end
  end

  private

  def render_json_uri svg_file
    render json: {svg_file: svg_file}
  end

  def render_json_success
    render json: {message: "Enabled 2FA successfully!", status: 200}
  end

  def render_json_fail json_message
    render json: json_message
  end
end
