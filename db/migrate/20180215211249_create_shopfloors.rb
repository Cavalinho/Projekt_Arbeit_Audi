class CreateShopfloors < ActiveRecord::Migration[5.0]
  def change
    create_table :shopfloors do |t|
      t.string :Vorhaben
      t.string :P_Status
      t.string :P_Statusdatum
      t.string :Tech_Unterlagen
      t.string :P_Relevanz
      t.string :Einsatzart
      t.string :BEMI
      t.string :PV
      t.string :Serie
      t.string :Fahrgestellnummer

      t.timestamps
    end
  end
end
