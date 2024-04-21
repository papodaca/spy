# == Schema Information
#
# Table name: locations
#
#  id           :uuid             not null, primary key
#  acc          :float
#  alt          :float
#  gis_location :geography        point, 4326
#  lat          :float
#  lon          :float
#  properties   :json
#  recorded_at  :datetime
#  reported_at  :datetime
#  tid          :text
#  uid          :text
#  vac          :float
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  timezone_id  :uuid
#  user_id      :uuid             not null
#
# Indexes
#
#  index_locations_on_timezone_id  (timezone_id)
#  index_locations_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (timezone_id => timezones.id)
#  fk_rails_...  (user_id => users.id)
#
class Location < ApplicationRecord
  belongs_to :user
  belongs_to :timezone

  def self.ransackable_attributes(auth_object = nil)
    %w[acc alt created_at gis_location id id_value lat lon properties reported_at tid uid updated_at user_id vac]
  end
end
