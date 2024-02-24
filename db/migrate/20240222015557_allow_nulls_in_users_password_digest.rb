class AllowNullsInUsersPasswordDigest < ActiveRecord::Migration[7.2]
  def change
    change_column_null :users, :password_digest, true
  end
end
