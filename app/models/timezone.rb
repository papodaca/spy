# == Schema Information
#
# Table name: timezones
#
#  id         :uuid             not null, primary key
#  name       :text
#  shape      :geometry         geometry, 0
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Timezone < ApplicationRecord
  def self.from_point(lat, long)
    find_by("st_intersects(timezones.shape, ST_Point(#{long}, #{lat}))")
  end

  def self.ransackable_attributes(auth_object = nil) = %w[created_at id id_value name shape updated_at]
end
