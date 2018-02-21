class Product < ActiveRecord::Base


######## model für Chartbox und Wochenbericht

Time.zone = 'America/Mexico_City'		

require 'Roo'


#23.10.2017
require 'database_cleaner'
#DatabaseCleaner.strategy = :truncation

scope :p_status, -> (status) {where("P_Status=?", status)}
scope :p_relevanz, ->(status){where("P_Relevanz=?", status)}
scope :no_p_relevanz, ->(status){where.not("P_Relevanz=?", status)}







#16/10/2017: (jetzige Kalenderwoche - 1.woche) + Jahr = 
#kw/year[2,3] = 12/42 wird in Spalte P_Statusdatum gesucht

def self.zeit_last_week
		kw =Time.zone.now - 1.week 
		kw = kw.strftime("%W").to_s  
		year= Time.zone.now.year.to_s 
		year[2,3] 
		@kwyear =kw +"/"+ year[2,3]
	end

def self.zeit_last_week_P_Statusd
		kw =Time.zone.now - 1.week 
		kw = kw.strftime("%W").to_s  
		year= Time.zone.now.year.to_s 
		year[2,3] 
		@kwyear =kw +"/"+ year[2,3]
		Product.where(:P_Statusdatum => "#{@kwyear}")
end

def self.zeit_last2_week
		kw =Time.zone.now - 2.week 
		kw = kw.strftime("%W").to_s  
		year= Time.zone.now.year.to_s 
		year[2,3] 
		@kwyear =kw +"/"+ year[2,3]
end

def self.zeit_last2_week_P_Statusd
		kw =Time.zone.now - 2.week 
		kw = kw.strftime("%W").to_s   
		year= Time.zone.now.year.to_s 
		year[2,3] 
		@kwyear =kw +"/"+ year[2,3]
		Product.where(:P_Statusdatum => "#{@kwyear}")
end

def self.zeit_last3_week
		kw =Time.zone.now - 3.week 	
		kw = kw.strftime("%W").to_s   
		year= Time.zone.now.year.to_s 
		year[2,3] 
		@kwyear =kw +"/"+ year[2,3]
end

def self.zeit_last3_week_P_Statusd
		kw =Time.zone.now - 3.week 	
		kw = kw.strftime("%W").to_s   
		year= Time.zone.now.year.to_s 
		year[2,3] 
		@kwyear =kw +"/"+ year[2,3]
		Product.where(:P_Statusdatum => "#{@kwyear}")
end

def self.zeit_last4_week
		kw =Time.zone.now - 4.week 	
		kw = kw.strftime("%W").to_s  
		year= Time.zone.now.year.to_s 
		year[2,3] 
		@kwyear =kw +"/"+ year[2,3]
end

def self.zeit_last4_week_P_Statusd
		kw =Time.zone.now - 4.week 	
		kw = kw.strftime("%W").to_s  
		year= Time.zone.now.year.to_s 
		year[2,3] 
		@kwyear =kw +"/"+ year[2,3]
		Product.where(:P_Statusdatum => "#{@kwyear}")
end

################

def self.uebergabe_letzte_kw	
		kw =Time.zone.now - 1.week 
		kw = kw.strftime("%W").to_s   
		year= Time.zone.now.year.to_s 
		year[2,3] 
		@kwyear =kw +"/"+ year[2,3]
		Product.where(:Uebergabe_in_die_Montage => "#{@kwyear}")
end

 def self.uebergabe_vorletzte_kw	
		kw =Time.zone.now - 2.week 
		kw = kw.strftime("%W").to_s  
		year= Time.zone.now.year.to_s 
		year[2,3] 
		@kwyear =kw +"/"+ year[2,3]
		Product.where(:Uebergabe_in_die_Montage => "#{@kwyear}")
end

def self.uebergabe_vorvorletzte_kw	
		kw =Time.zone.now - 3.week 
		kw = kw.strftime("%W").to_s 
		year= Time.zone.now.year.to_s 
		year[2,3] 
		@kwyear =kw +"/"+ year[2,3]
		Product.where(:Uebergabe_in_die_Montage => "#{@kwyear}")
end

def self.uebergabe_vorvorvorletzte_kw	
		kw =Time.zone.now - 4.week 
		kw = kw.strftime("%W").to_s   
		year= Time.zone.now.year.to_s 
		year[2,3] 
		@kwyear =kw +"/"+ year[2,3]
		Product.where(:Uebergabe_in_die_Montage => "#{@kwyear}")
end
	
#31.10.2017
 MAPPING = {
    "1. Fahrgestellnummer" => "Fahrgestellnummer",
    "P-Status" => "P_Status", 
    "Sachbearbeiter [PRO]" => "Sachbearbeiter",
    "P-Statusdatum"	=> "P_Statusdatum",
    "P-Relevanz" => "P_Relevanz",
    "Serie (SOP)" => "Serie",
    "Denominación (larga)" => "Denominacion",
    "Übergabe an die Montage" => "Uebergabe_in_die_Montage"
    		
  }
#controlls the import behavior from def import in products controller
#27/09/2017
def self.import(file)

#gem 'database_cleaner' 23.10 


#clean Product table 
Product.delete_all

accessible_attributes =	["Vorhaben", "Fahrgestellnummer", "P_Status", "SET", "Sachbearbeiter", "P_Statusdatum", "P_Relevanz", "Serie", "Uebergabe_in_die_Montage", "Denominacion" ]

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

	
#19.10.2017 P_Relevanz = (leere)
def self.leer 
Product.where("P_Relevanz is NULL")
end

def self.notrelevant
Product.where("P_Relevanz is not NULL")
end


#19.10.2017 P_Relevanz = In Klärung
def self.in_klärung
@In = 'In Klärung'
Product.where(:P_Relevanz => "#{@In}").or(Product.where("P_Relevanz is NULL"))
end

#in Klärung letzten wochen noch einfügen def.self.in_klärung_letzten_kw


def self.eingaenge 
#kw/year letzte Woche 
kw =Time.zone.now - 1.week 	
		kw = kw.strftime("%W").to_s 
		year= Time.zone.now.year.to_s 
		year[2,3] 
		@kwyear_lastweek=kw +"/"+ year[2,3]
Product.where("P_Statusdatum IS ?", "#{@kwyear_lastweek}")
end

def self.eingaenge2 
#kw/year letzte Woche 
kw =Time.zone.now - 2.week 	
		kw = kw.strftime("%W").to_s 
		year= Time.zone.now.year.to_s 
		year[2,3] 
		@kwyear_lastweek=kw +"/"+ year[2,3]
Product.where("P_Statusdatum IS ? ", "#{@kwyear_lastweek}")
end

def self.eingaenge3 
#kw/year letzte Woche 
kw =Time.zone.now - 3.week 	
		kw = kw.strftime("%W").to_s   
		year= Time.zone.now.year.to_s 
		year[2,3] 
		@kwyear_lastweek=kw +"/"+ year[2,3]
Product.where("P_Statusdatum IS ? ", "#{@kwyear_lastweek}")
end

def self.eingaenge4 
#kw/year letzte Woche 
kw =Time.zone.now - 4.week 	
		kw = kw.strftime("%W").to_s  
		year= Time.zone.now.year.to_s 
		year[2,3] 
		@kwyear_lastweek=kw +"/"+ year[2,3]
Product.where("P_Statusdatum IS ? ", "#{@kwyear_lastweek}")
end






def self.rueckmeldung_alt
#kw/year nächste Woche
kw =Time.zone.now + 1.week 
		kw = kw.strftime("%W").to_s 
		year= Time.zone.now.year.to_s 
		year[2,3] 
		@kwyear_nextweek =kw +"/"+ year[2,3]
#kw/year diese Woche 
kw =Time.zone.now  
		kw = kw.strftime("%W").to_s 
		year= Time.zone.now.year.to_s 
		year[2,3] 
		@kwyear_thisweek =kw +"/"+ year[2,3]
#kw/year letzte Woche 
kw =Time.zone.now - 1.week 
		kw = kw.strftime("%W").to_s  
		year= Time.zone.now.year.to_s 
		year[2,3] 
		@kwyear_lastweek =kw +"/"+ year[2,3]
@Of = 'Offen'
#Suche nach Fahrgestellnummer offen oder leer und Übergabe_in_die_Montage is nicht leer, diese Woche, letzte Woche, nächste Woche oder Fahrgestellnummer leer und Übergabe in die MOntage is nicht leer, diese woche, nächste woche oder letzte woche 
# SOP älter als diese woche, Übergabe in Montage vorhanden, Fahrgestellnummer offen oder leer
Product.where("Fahrgestellnummer Like ? AND Uebergabe_in_die_Montage IS NOT ? AND Uebergabe_in_die_Montage IS NOT ? AND Uebergabe_in_die_Montage IS NOT ? AND Uebergabe_in_die_Montage IS NOT ?", "%#{@Of}%", nil, "#{@kwyear_thisweek}", "#{@kwyear_nextweek}", "#{@kwyear_lastweek}").or(Product.where("Fahrgestellnummer IS ? AND Uebergabe_in_die_Montage IS NOT ? AND Uebergabe_in_die_Montage IS NOT ? AND Uebergabe_in_die_Montage IS NOT ? AND Uebergabe_in_die_Montage IS NOT ?", nil, nil, "#{@kwyear_thisweek}", "#{@kwyear_nextweek}", "#{@kwyear_lastweek}"))

end

def self.rueckmeldung_kw_aktuell							
#kw/year letzte Woche 
kw =Time.zone.now - 1.week 
		kw = kw.strftime("%W").to_s  
		year= Time.zone.now.year.to_s 
		year[2,3] 
		@kwyear_lastweek =kw +"/"+ year[2,3]

@Of = 'Offen'
#Suche nach Fahrgestellnummer "offen" und ÜBergabe in die Montage letzte Woche und nach Fahrgestellnummer leer und Übergabe in die Montage letzte Woche 
Product.where("Fahrgestellnummer Like ? AND Uebergabe_in_die_Montage IS ?", "%#{@Of}%", "#{@kwyear_lastweek}").or(Product.where("Fahrgestellnummer IS ? AND Uebergabe_in_die_Montage IS ?", nil,"#{@kwyear_lastweek}"))
end

def self.uebergabe_kw_aktuell
#kw/year nächste Woche
kw =Time.zone.now + 1.week 
		kw = kw.strftime("%W").to_s  
		year= Time.zone.now.year.to_s 
		year[2,3] 	
		@kwyear_nextweek =kw +"/"+ year[2,3]

#kw/year diese Woche 
kw =Time.zone.now  
		kw = kw.strftime("%W").to_s  
		year= Time.zone.now.year.to_s 
		year[2,3] 
		@kwyear_thisweek =kw +"/"+ year[2,3]

(Product.where(:Uebergabe_in_die_Montage => "#{@kwyear_thisweek}"))
end 

def self.uebergabe_kw_naechste
#kw/year nächste Woche
kw =Time.zone.now + 2.week 
		kw = kw.strftime("%W").to_s  
		year= Time.zone.now.year.to_s 
		year[2,3] 	
		@kwyear_2week =kw +"/"+ year[2,3]

Product.where(:Serie => "#{@kwyear_2week}")
end

end
