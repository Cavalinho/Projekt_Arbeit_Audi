#1.terminal rails g migration FixColumnName
#2.class FixColumnName < ActiveRecord::Migration writting code in def change
#3.terminal rails db:migrate
  
class ChangeColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :products, :vorhaben, :Vorhaben
  	rename_column :products, :pstatus, :P_Status
  	rename_column :products, :sachbearbeiter, :Sachbearbeiter
  	rename_column :products, :prelevanz, :P_Relevanz
  end
end
