class JsonWebToken
  class << self
    def encode(payload, exp = 24.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, Rails.application.secrets.secret_key_base)
    end

    def decode(token)
      p Rails.application.secrets.secret_key_base
      p JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
      body = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
      HashWithIndifferentAccess.new body
      p body
    rescue StandardError
      p 'error'
      nil
    end
  end
end
