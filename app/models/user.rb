class User < ApplicationRecord
  has_secure_password
  has_one_time_password

  enum otp_module: { disabled: 0, enabled: 1 }, _prefix: true
  attr_accessor :otp_code_token
end
