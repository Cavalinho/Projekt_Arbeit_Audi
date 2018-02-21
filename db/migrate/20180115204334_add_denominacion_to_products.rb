class AddDenominacionToProducts < ActiveRecord::Migration[5.0]
  def change
   add_column :products , :Denominacion , :string  
  end
end
