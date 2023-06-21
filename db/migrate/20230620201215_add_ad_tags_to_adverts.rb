class AddAdTagsToAdverts < ActiveRecord::Migration[7.0]
  def change
    add_column :adverts, :ad_tags, :string
  end
end
