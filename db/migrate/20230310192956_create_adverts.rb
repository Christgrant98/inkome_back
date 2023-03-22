class CreateAdverts < ActiveRecord::Migration[7.0]
  def change
    create_table :adverts do |t|
      t.string :description
      t.string :name
      t.integer :age
      t.string :phone

      t.timestamps
    end
  end
end
