  class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :vorhaben
      t.string :pstatus
      t.text :SET
      t.string :sachbearbeiter
      t.string :prelevanz

      t.timestamps
    end
  end
end
