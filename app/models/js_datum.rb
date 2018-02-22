class JsDatum < ApplicationRecord


	#Vorhaben nur einmalig in Datenbank wenn die Spalte Day gleich ist
	validates_uniqueness_of  :Vorhaben, scope: :Day
	#validates_uniqueness_of :Vorhaben, scope: :Day

	#class JsDatum für Daten aus KPI_Bericht, Datenbank wird nicht gelöscht


	#22.01.2018 in Spalte Day wird das aktuelle Datum reingeschrieben
	before_save :generate_timestamp

	def generate_timestamp
		self.Day = Time.zone.now.wday
	end


	#07.01.2018 Filter von Day Spalte in Product Controller
	#scope :Day, ->(status){where("Day=?", status)}
	scope :day, ->(status){where("Day=?", status)}
	#29.01.2018 Filtern von P_relevanz Spalte in Product Controller
	scope :p_relevanz, ->(status){where("P_Relevanz=?", status)}



	#22.01.2018 aus product.rb
	 MAPPING = {
	    "1. Fahrgestellnummer" => "Fahrgestellnummer",
	    "Serie (SOP)" => "Serie",
	    "Übergabe an die Montage" => "Uebergabe_in_die_Montage",
		"P-Relevanz" => "P_Relevanz"
	  }


	def self.import(file)

			#7.2.2018 JsDatum table löschen wenn Montag

		case Time.zone.now.wday

		when 1

				JsDatum.delete_all


				accessible_attributes =	[ "Vorhaben", "Fahrgestellnummer", "Serie", "Uebergabe_in_die_Montage","P_Relevanz"]

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

					products.attributes = row.to_hash.slice(*accessible_attributes )


					products.save!
		 			end

		when 2,3,4,5




					accessible_attributes =	[ "Vorhaben", "Fahrgestellnummer", "Serie", "Uebergabe_in_die_Montage","P_Relevanz"]

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

					products.attributes = row.to_hash.slice(*accessible_attributes )



					products.save!
		 			end
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

	#KPI_GraphFilter##########################################################################

	def self.uebergabe_kw_naechste_KPI_blaueLinie
	#kw/year nächste Woche
	kw =Time.zone.now + 1.week
			kw = kw.strftime("%W").to_s
			year= Time.zone.now.year.to_s
			year[2,3]
			@kwyear_nextweek =kw +"/"+ year[2,3]

	JsDatum.where(:Serie => "#{@kwyear_nextweek}")
	end


	def self.uebergabe_kw_naechsten2_KPI_blaueLinie2
	#kw/year nächste Woche
	kw =Time.zone.now + 2.week
			kw = kw.strftime("%W").to_s
			year= Time.zone.now.year.to_s
			year[2,3]
			@kwyear_week =kw +"/"+ year[2,3]

	JsDatum.where(:Serie => "#{@kwyear_week}")
	end


	def self.uebergabe_kw_thisweek_KPI_blaueLinie3
	#kw/year nächste Woche
	kw =Time.zone.now
			kw = kw.strftime("%W").to_s
			year= Time.zone.now.year.to_s
			year[2,3]
			@kwyear_thisweek =kw +"/"+ year[2,3]

	@N = 'N/A'

	JsDatum.where("Fahrgestellnummer IS NOT ? AND Serie IS ?", "#{@N}", "#{@kwyear_thisweek}")
	end



	#Abhängig vom Tag
	def self.uebergabe_kw_aktuell_KPI_gruenerBalken


	#kw/year diese Woche
	kw =Time.zone.now
			kw = kw.strftime("%W").to_s
			year= Time.zone.now.year.to_s
			year[2,3]
			@kwyear_thisweek =kw +"/"+ year[2,3]

	@Of = 'Offen'

	#grünerBalken Spalte Übergabe in die Montage diese Woche
	JsDatum.where(:Uebergabe_in_die_Montage => "#{@kwyear_thisweek}")

	end

	#roter Balken
	#Abhängig vom Tag
	def self.rueckmeldung_alt_KPI
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
	JsDatum.where("Fahrgestellnummer Like ? AND Uebergabe_in_die_Montage IS NOT ? AND Uebergabe_in_die_Montage IS NOT ? AND Uebergabe_in_die_Montage IS NOT ? AND Uebergabe_in_die_Montage IS NOT ?", "%#{@Of}%", nil, "#{@kwyear_thisweek}", "#{@kwyear_nextweek}", "#{@kwyear_lastweek}").or(JsDatum.where("Fahrgestellnummer IS ? AND Uebergabe_in_die_Montage IS NOT ? AND Uebergabe_in_die_Montage IS NOT ? AND Uebergabe_in_die_Montage IS NOT ? AND Uebergabe_in_die_Montage IS NOT ?", nil, nil, "#{@kwyear_thisweek}", "#{@kwyear_nextweek}", "#{@kwyear_lastweek}"))
	end

	# ChartBox gelb
	#Abhängig vom Tag
	def self.rueckmeldung_kw_aktuell_KPI
	#kw/year letzte Woche
	kw =Time.zone.now - 1.week
			kw = kw.strftime("%W").to_s
			year= Time.zone.now.year.to_s
			year[2,3]
			@kwyear_lastweek =kw +"/"+ year[2,3]

	@Of = 'Offen'
	#Suche nach Fahrgestellnummer "offen" und Übergabe in die Montage letzte Woche und nach Fahrgestellnummer leer und Übergabe in die Montage letzte Woche
	JsDatum.where("Fahrgestellnummer Like ? AND Uebergabe_in_die_Montage IS ?", "%#{@Of}%", "#{@kwyear_lastweek}").or(JsDatum.where("Fahrgestellnummer IS ? AND Uebergabe_in_die_Montage IS ?", nil,"#{@kwyear_lastweek}"))
	end


	#Abhängig vom Tag
	def self.einsatz_kw_aktuell_KPI

	kw =Time.zone.now
			kw = kw.strftime("%W").to_s
			year= Time.zone.now.year.to_s
			year[2,3]
			@kwyear_thisweek =kw +"/"+ year[2,3]

	@Of = 'Offen'
	#Suche nach Fahrgestellnummer nicht "offen" und Fahrgestellnummer nicht leer Übergabe und SOP diese Woche aus .uebergabe_kw_thisweek_KPI_blaueLinie3
	JsDatum.where("Fahrgestellnummer IS NOT ? AND Fahrgestellnummer NOT LIKE ? AND Serie IS ?" , nil,"%#{@Of}%", "#{@kwyear_thisweek}" )

	end




end
