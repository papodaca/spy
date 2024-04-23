class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  private

  def authenticate_admin_user!
    redirect_to("/") unless current_user&.admin?
  end

  def current_admin_user
    current_user if current_user&.admin?
  end
end
