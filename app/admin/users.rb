# frozen_string_literal: true

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

ActiveAdmin.register User do
  permit_params :username, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :username
    column :role
    column :created_at
    column :updated_at
    actions
  end

  filter :username
  filter :role
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs do
      f.input :username
      f.input :role, as: :select, collection: %i[basic admin], required: true
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
