class PublicationController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[create]
  skip_before_action :verify_authenticity_token, only: %i[create]
  before_action :auth_user!, only: %i[create]

  def create
    ProcessPublicationJob.perform_later(
      user_id: @user.id,
      params: JSON.parse(request.body.read, symbolize_keys: true)
    )
    render json: {message: "ok"}, status: :ok
  end

  private

  def auth_user!
    @user = authenticate_with_http_basic do |username, password|
      user = User.find_by(username: username)
      user&.valid_password?(password) && user
    end
    render json: {message: "unauthorized"}, status: :unauthorized if @user.nil?
  end
end
