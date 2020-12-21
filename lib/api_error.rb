module ApiError
  CODES = {
    something_wrong: 0,
    login_failed: 1,
    not_enabled_tfa: 2,
    not_login: 3,
    invalid_otp: 4,
    tfe_enabled: 5
  }

  private

  def json_error_by_code status_code
    {
      message: I18n.t("api.errors.#{CODES.key(status_code) || CODES.key(0)}"),
      status_code: status_code
    }
  end
end
