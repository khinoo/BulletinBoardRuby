class RenameCreatedUserIdToCreateUserId < ActiveRecord::Migration[6.1]
  def change
  	rename_column :posts, :created_user_id, :create_user_id
  end
end
