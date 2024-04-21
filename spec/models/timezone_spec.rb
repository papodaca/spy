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
require "rails_helper"

RSpec.describe Timezone, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
