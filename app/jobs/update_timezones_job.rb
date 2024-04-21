class UpdateTimezonesJob < ApplicationJob
  queue_as :default

  def perform(*)
    UpdateTimezonesService.run
  end
end
