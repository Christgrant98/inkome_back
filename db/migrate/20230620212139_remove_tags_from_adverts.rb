# db/migrate/xxxxxxxxxxxxxx_remove_tags_from_adverts.rb
class RemoveTagsFromAdverts < ActiveRecord::Migration[7.0]
  def change
    remove_column :adverts, :tags, :string
  end
end
