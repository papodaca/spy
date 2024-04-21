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
require "rails_helper"

RSpec.describe Location, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
