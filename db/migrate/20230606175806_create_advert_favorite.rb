class CreateAdvertFavorite < ActiveRecord::Migration[7.0]
  def change
    create_table :advert_favorites do |t|
      t.references :user, null: false, foreign_key: true
      t.references :advert, null: false, foreign_key: true

      t.timestamps
    end
  end
end
