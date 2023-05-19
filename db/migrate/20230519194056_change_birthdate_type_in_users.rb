class ChangeBirthdateTypeInUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :birthdate, :string
  end
end
