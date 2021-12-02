class V1::UserTokenController < Knock::AuthTokenController
  skip_before_action :verify_authenticity_token

  def entity_name
    'User'
  end
end
