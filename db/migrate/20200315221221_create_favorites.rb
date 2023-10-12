class CreateFavorites < ActiveRecord::Migration[6.0]
  def change
    create_table :favorites, id: :uuid do |t|

      t.references :user, type: :uuid, null: false, foreign_key: true
      t.references :show, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end
  end
end
