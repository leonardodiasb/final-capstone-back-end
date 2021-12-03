class JsonWebToken
  class << self
    def encode(payload, exp = 24.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, Rails.application.secrets.secret_key_base)
    end

    def decode(token)
      p Rails.application.secret_key_base
      p JWT.decode(token, Rails.application.secret_key_base)
      body = JWT.decode(token, Rails.application.secret_key_base)
      HashWithIndifferentAccess.new body
      p body
    rescue StandardError
      p 'error'
      nil
    end

    def secret_key_base
      if Rails.env.development? || Rails.env.test?
        secrets.secret_key_base ||= generate_development_secret
      else
        validate_secret_key_base(
          ENV["SECRET_KEY_BASE"] || credentials.secret_key_base || secrets.secret_key_base
        )
      end
    end
  end
end
