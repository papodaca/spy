# frozen_string_literal: true

ActiveAdmin.register User do
  permit_params :username, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :username
    column :created_at
    column :updated_at
    actions
  end

  filter :username
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs do
      f.input :username
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
