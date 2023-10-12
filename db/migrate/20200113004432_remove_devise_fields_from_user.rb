class RemoveDeviseFieldsFromUser < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :encrypted_password
    remove_column :users, :sign_in_count
    remove_column :users, :current_sign_in_at
    remove_column :users, :last_sign_in_at
    remove_column :users, :current_sign_in_ip
    remove_column :users, :last_sign_in_ip
    remove_column :users, :unconfirmed_email
  end
end
