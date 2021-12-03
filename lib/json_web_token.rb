class JsonWebToken
  SECRET_KEY = Rails.application.secrets.secret_key_base.to_s

  class << self
    def encode(payload, exp = 24.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, SECRET_KEY)
    end

    def decode(token)
      body = JWT.encode(token, SECRET_KEY).first
      HashWithIndifferentAccess.new body
    rescue StandardError
      nil
    end
  end
end
