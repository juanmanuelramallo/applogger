class ApplicationController < ActionController::Base
  include Pagy::Backend

  skip_before_action :verify_authenticity_token
  before_action :authenticate

  private

  def authenticate
    http_basic_authenticate_or_request_with(
      name: ENV.fetch('HTTP_BASIC_AUTH_NAME'),
      password: ENV.fetch('HTTP_BASIC_AUTH_PASSWORD')
    )
  end
end
