class AddUserRole < ActiveRecord::Migration[7.1]
  def change
    create_enum :user_role, %w[basic admin]

    add_column :users, :role, :enum, enum_type: :user_role, default: "basic", null: false
  end
end
