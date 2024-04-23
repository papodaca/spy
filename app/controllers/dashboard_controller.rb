class DashboardController < ApplicationController
  def index
    @first_location = current_user.locations.order(reported_at: :desc).limit(1).first
  end
end
