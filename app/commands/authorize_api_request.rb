class AuthorizeApiRequest
  prepend SimpleCommand

  def initialize(headers = {})
    @headers = headers
  end

  def call
    user
  end

  private

  attr_reader :headers

  def user
    p @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
    p 'found user'
    @user || (errors.add(:token, 'Invalid token') && nil)
  end

  def decoded_auth_token
    p @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
    p 'decoded'
  end

  def http_auth_header
    if headers['Authorization'].present?
      headers['Authorization'].split.last
    else
      errors.add(:token, 'Missing token')
    end
  end
end
