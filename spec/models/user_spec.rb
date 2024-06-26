# == Schema Information
#
# Table name: users
#
#  id                  :uuid             not null, primary key
#  encrypted_password  :string           default(""), not null
#  properties          :json
#  remember_created_at :datetime
#  role                :enum             default("basic"), not null
#  username            :string           default(""), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_users_on_username  (username) UNIQUE
#
require "rails_helper"

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
