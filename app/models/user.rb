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
  include AttrJson::Record

  devise :database_authenticatable, :rememberable, :validatable, :argon2,
         authentication_keys: [:username], case_insensitive_keys: [:username]

  attr_json :friends_ids, :string,
            array: true, default: [], store_key: :friends,
            container_attribute: :properties

  attr_json :tid, :string,
            container_attribute: :properties

  def self.ransackable_attributes(auth_object = nil) = %w[encrypted_password \
    properties username created_at role remember_created_at updated_at]

  def self.ransackable_associations(auth_object = nil) = %w[locations]

  has_many :locations

  def admin?
    role == "admin"
  end

  def friends
    User.where(id: friends_ids)
  end

  def friends=(others)
    friends_ids = others.map(&:id)
  end

  def add_friend(other)
    friends_ids << other.id
  end

  def to_card
    {
      "_type": "card",
      "name": "owntracks/#{username}/#{tid}"
    }
  end

  def latest_location
    locations.order(reported_at: :desc).limit(1).first
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
