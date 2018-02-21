class Shopfloor < ApplicationRecord
 
#### model für Shopfloor


###### allgemein gültige Filter 


#erstellt 15.2.2018
scope :p_status, ->(status){where("P_Status=?", status)}


# Spalte Technische Unterlagen 

def self.techUnterlagenvorhanden
# feststellen aktueller KW 
kw =Time.zone.now 
		kw = kw.strftime("%W").to_s  
		year= Time.zone.now.year.to_s 
		year[2,3] 	
		@kwyear_thisweek =kw +"/"+ year[2,3]
# feststellen letzte KW 
kw =Time.zone.now - 1.week 
		kw = kw.strftime("%W").to_s  
		year= Time.zone.now.year.to_s 
		year[2,3] 	
		@kwyear_lastweek =kw +"/"+ year[2,3]
# feststellen Technische Unterlagen vorhanden und P_Statusdatum KW letzte Woche oder diese Woche ---> in Time 
Shopfloor.where("Tech_Unterlagen IS NOT ? OR Tech_Unterlagen IS NOT ? AND P_Statusdatum IS ? OR P_Statusdatum is ?",nil, "Nein", "{@kwyear_lastweek}", "{@kwyear_thisweek}")
end


def self.techUnterlagennichtvorhanden
# feststellen aktueller KW 
kw =Time.zone.now 
		kw = kw.strftime("%W").to_s  
		year= Time.zone.now.year.to_s 
		year[2,3] 	
		@kwyear_thisweek =kw +"/"+ year[2,3]
# feststellen letzte KW 
kw =Time.zone.now - 1.week 
		kw = kw.strftime("%W").to_s  
		year= Time.zone.now.year.to_s 
		year[2,3] 	
		@kwyear_lastweek =kw +"/"+ year[2,3]
# feststellen Technische Unterlagen nicht vorhanden und P_Statusdatum KW letzte Woche oder älter --> not in Time
Shopfloor.where("Tech_Unterlagen IS ? OR Tech_Unterlagen IS ? AND P_Statusdatum IS NOT ? AND P_Statusdatum is NOT ?",nil, "Nein", "{@kwyear_lastweek}", "{@kwyear_thisweek}")
end


# Spalte P_Relevanz

def self.prelevanzvorhanden
# feststellen aktueller KW 
kw =Time.zone.now 
		kw = kw.strftime("%W").to_s  
		year= Time.zone.now.year.to_s 
		year[2,3] 	
		@kwyear_thisweek =kw +"/"+ year[2,3]
# feststellen letzte KW 
kw =Time.zone.now - 1.week 
		kw = kw.strftime("%W").to_s  
		year= Time.zone.now.year.to_s 
		year[2,3] 	
		@kwyear_lastweek =kw +"/"+ year[2,3]
# feststellen P_Relevanz vorhand und KW letzte Woche oder diese Woche ---> in Time 
Shopfloor.where("P_Relevanz IS NOT ? OR P_Relevanz IS NOT ? AND P_Statusdatum IS ? OR P_Status is ?",nil, "Nein", "{@kwyear_lastweek}", "{@kwyear_thisweek}")

#feststellen P_Relevanz nicht vorhanden und KW letzte Woche oder älter --> not in Time  
Shopfloor.where("P_Relevanz IS ? OR P_Relevanz IS ? AND P_Statusdatum IS NOT ? OR P_Statusdatum is NOT ?",nil, "Nein", "{@kwyear_lastweek}", "{@kwyear_thisweek}") 
end 

def self.prelevanznichtvorhanden
# feststellen aktueller KW 
kw =Time.zone.now 
		kw = kw.strftime("%W").to_s  
		year= Time.zone.now.year.to_s 
		year[2,3] 	
		@kwyear_thisweek =kw +"/"+ year[2,3]
# feststellen letzte KW 
kw =Time.zone.now - 1.week 
		kw = kw.strftime("%W").to_s  
		year= Time.zone.now.year.to_s 
		year[2,3] 	
		@kwyear_lastweek =kw +"/"+ year[2,3]
#feststellen P_Relevanz nicht vorhanden und KW letzte Woche oder älter --> not in Time  
Shopfloor.where("P_Relevanz IS ? OR P_Relevanz IS ? AND P_Statusdatum IS NOT ? OR P_Statusdatum is NOT ?",nil, "Nein", "{@kwyear_lastweek}", "{@kwyear_thisweek}") 
end


 MAPPING = {
    
    "1. Fahrgestellnummer" => "Fahrgestellnummer",
    "P-Status" => "P_Status", 
    "P-Statusdatum"	=> "P_Statusdatum",
    "P-Relevanz" => "P_Relevanz",
    "Inhalt klar, Techn. Unterlagen vollst." =>	"Tech_Unterlagen",
    "Einsatzart M/PV-1" => "Einsatzart",
    "BEMI vorhanden" => "BEMI",
    "EBV/PV" => "PV",
    "Serie (SOP)" => "Serie",
    "1. Fahrgestellnummer" => "Fahrgestellnummer"
    
    		
  }


def self.import(file)




			accessible_attributes =	["Vorhaben", "Fahrgestellnummer", "P_Status", "P_Statusdatum","P_Relevanz", "Serie", "Tech_Unterlagen", "Einsatzart", "BEMI", "PV", "Einsatzart"]

			spreadsheet = open_spreadsheet(file)			
			#1 Zeile array ist stored in variable header 	
			header = spreadsheet.row(7)
 			#loop from 8 to last row
			(8..spreadsheet.last_row).each do |i|
		
			#grap the row values put them with the header in an array [] and transpose to a HASh# called row	
			row = Hash[[header, spreadsheet.row(i)].transpose] 
			#31.10.2017 line loops through each key of the csv row and if it has a mapping defined in the MAPPING constant it 'deletes' the key from the row hash, and assigns a new key with the same value but with our mapped key
			row.keys.each { |k| row[ MAPPING[k] ] = row.delete(k) if MAPPING[k] }
	
			#find the id else make new
			products = find_by_id(row["id"]) || new
		
			products.attributes = row.to_hash.slice(*accessible_attributes)	   
			

			products.save! 
		
			

			end 

	
	 


end 

	def self.open_spreadsheet(file)	
		case File.extname(file.original_filename)
		when ".csv" then Roo::Csv.new(file.path, packed: nil, file_warning: :ignore)
		when ".xls" then Roo::Excel.new(file.path, packed: nil, file_warning: :ignore)
		when ".xlsx" then Roo::Excelx.new(file.path, packed: nil, file_warning: :ignore)
		#else raise "Unknown file type: #{file.orginal_filename}
	end

 end

end
