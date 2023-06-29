class AddUserIdToAdverts < ActiveRecord::Migration[7.0]
  def change
    add_reference :adverts, :user, foreign_key: true
  end
end
