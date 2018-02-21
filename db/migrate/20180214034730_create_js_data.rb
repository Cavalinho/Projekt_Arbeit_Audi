class CreateJsData < ActiveRecord::Migration[5.0]
  def change
    create_table :js_data do |t|
      t.string :Vorhaben 
      t.string :Serie 
      t.string :P_Relevanz 
      t.string :Uebergabe_in_die_Montage
      t.string :Fahrgestellnummer
      t.string :Day

      t.timestamps
    end
  end
end
