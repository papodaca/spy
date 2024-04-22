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
class User < ApplicationRecord
  devise :database_authenticatable, :rememberable, :validatable, :argon2,
         authentication_keys: [:username], case_insensitive_keys: [:username]

  def self.ransackable_attributes(auth_object = nil) = %w[encrypted_password \
    properties username created_at role remember_created_at updated_at]

  def self.ransackable_associations(auth_object = nil) = %w[locations]

  has_many :locations

  def admin?
    role == "admin"
  end

  # These methods are required for devise to not fuck up
  def email
    username
  end

  def email=(text)
    self.username = text
  end

  def will_save_change_to_email?
    false
  end
end
