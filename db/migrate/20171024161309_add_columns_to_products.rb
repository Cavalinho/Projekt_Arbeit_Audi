#1.terminal rails g migration AddColumnNametoProducts
#2.terminal rails db:migrate

class AddColumnsToProducts < ActiveRecord::Migration[5.0]
  def change
  	add_column :products , :P_Statusdatum , :string
  	add_column :products , :Serie 		  , :string
  	add_column :products , :Uebergabe_in_die_Montage , :string
	add_column :products , :Fahrgestellnummer , :string  
  end
end
