class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.text :name
      t.text :email
      t.string :password_digest
      t.string :profile
      t.string :role
      t.string :phone
      t.string :address
      t.date :dob
      t.integer :create_user_id
      t.integer :updated_user_id
      t.integer :deleted_user_id
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
