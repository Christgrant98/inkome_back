class AddImageToAdverts < ActiveRecord::Migration[7.0]
  def change
    add_column :adverts, :image, :string  
  end
end


# agregar el string -> base 64 de la imagen en la tavbla de los Adverts
