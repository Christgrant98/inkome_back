class ChangeAdTagsToNullableInAdverts < ActiveRecord::Migration[7.0]
  def change
    change_column :adverts, :ad_tags, :string, null: true
  end
end
