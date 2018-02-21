module ApplicationHelper
	

		#grüner Balken 
	def kpi_column(daten)
		

		#Code Amine ##########

		#case daten['day']
		#when 1				
				
				#left = 64.5	
				#{}"<div class='kpi-column' style='bottom: 125px;left: #{left}px;height:#{daten['y'].to_i * 17.8 + 20}px' ></div>"
		########################		



		# @kpi_data[0] = Wochentag (Montag => 1), @kpi_data[1] = Montageübegaben diese Woche,
		case @kpi_data[0]
		
		when 1				
				
				left = 64.5	
				"<div class='kpi-column' style='bottom: 125px;left: #{left}px;height:#{@kpi_data[1] * 17.8 + 20}px' ></div>"
				

		when 2
				
				left = 126.5
				"<div class='kpi-column' style='bottom: 125px;left: #{left}px;height:#{@kpi_data[1] * 17.8 + 20}px' ></div>"
				 
				#Frage wichtig überschreibt obere Zeile!!!! beide Spalten werden nicht angezeigt  
				#Monday
				#"<div class='kpi-column' style='bottom: 125px; height:#{@kpi_data[2] * 17.8 + 20}px' ></div>"
		
		when 3		
				
				left = 189.5
				"<div class='kpi-column' style='bottom: 125px;left: #{left}px;height:#{@kpi_data[1] * 17.8 + 20}px' ></div>"
 	
				#Monday
				#"<div class='kpi-column' style='bottom: 125px;left: 64px;height:#{@kpi_data[2] * 17.8 + 20}px' ></div>"
			
				#Tuesday
				#"<div class='kpi-column' style='bottom: 125px;left: 125px;height:#{@kpi_datatday[0] * 17.8 + 20}px' ></div>"
		

		when 4
				
				left = 251.5
				"<div class='kpi-column' style='bottom: 125px;left: #{left}px;height:#{@kpi_data[1] * 17.8 + 20}px' ></div>"
				
				#Monday
				#"<div class='kpi-column' style='bottom: 125px;left: 64px;height:#{@kpi_data[2] * 17.8 + 20}px' ></div>"
			
				#Tuesday
				#"<div class='kpi-column' style='bottom: 125px;left: 125px;height:#{@kpi_datatday[0] * 17.8 + 20}px' ></div>"
				
				#Wednesday
				#"<div class='kpi-column' style='bottom: 125px;left: 189.5px;height:#{@kpi_datawday[0] * 17.8 + 20}px' ></div>"

		when 5
				
				left = 313.5
				"<div class='kpi-column' style='bottom: 125px;left: #{left}px;height:#{@kpi_data[1] * 17.8 + 20}px' ></div>"
			
				#Monday
				#"<div class='kpi-column' style='bottom: 125px;left: 64px;height:#{@kpi_data[2] * 17.8 + 20}px' ></div>"
			
				#Tuesday
				#"<div class='kpi-column' style='bottom: 125px;left: 125px;height:#{@kpi_datatday[0] * 17.8 + 20}px' ></div>"
				
				#Wednesday
				#"<div class='kpi-column' style='bottom: 125px;left: 189.5px;height:#{@kpi_datawday[0] * 17.8 + 20}px' ></div>"

				#Thursday
				#"<div class='kpi-column' style='bottom: 125px;left: 251.5px;height:#{@kpi_datathday[0] * 17.8 + 20}px' ></div>"


		end	
	end

		#Blauer Balken Einsatztermin
	def kpi_bbnet(daten)

				#Blauer Balken ET nächste Woche (hellblau)
				left = 64
				"<div class='kpi_bbnet'style='bottom:#{@kpi_Balken[0] * 18 + 141}px;left: #{left}px;height:5px' ></div>"	
    end

    def kpi_bbnet1(daten)

				#Blauer Balken ET übernächste Woche 
				left = 240
				"<div class='kpi_bbnet1'style='bottom:#{@kpi_Balken1[0] * 18 + 141}px;left: #{left}px;height:5px' ></div>"

    end

    ########################Einsatzrückmeldung
    def kpi_bbnet2(daten)

				#Blauer Balken ET diese Woche (dunkelblau)
				left = 523
				"<div class='kpi_bbnet2'style='bottom:#{@kpi_Balken2[0] * 18 + 141}px;left: #{left}px;height:5px' ></div>"

    end

    	#grüner Balken 
    def kpi_column1(daten)

    	case @BalkenGruen1[0]

    		when 1

				left = 533.5
				"<div class='kpi-column1' style='bottom: 125px;left: #{left}px;height:#{@BalkenGruen1[1] * 17.8 + 20}px' ></div>"
			
  		

			when 2

				left = 595.5
				"<div class='kpi-column1' style='bottom: 125px;left: #{left}px;height:#{@BalkenGruen1[1] * 17.8 + 20}px' ></div>"
			
				#Monday
				#"<div class='kpi-column1' style='bottom: 125px;left: 533.5px;height:#{@BalkenGruen1m[0] * 17.8 + 20}px' ></div>"

				

			when 3

				left = 658.5
				"<div class='kpi-column1' style='bottom: 125px;left: #{left}px;height:#{@BalkenGruen1[1] * 17.8 + 20}px' ></div>"
				 
				#Monday
				#"<div class='kpi-column1' style='bottom: 125px;left: 533.5px;height:#{@BalkenGruen1m[0] * 17.8 + 20}px' ></div>"

				#Tuesday
				#"<div class='kpi-column1' style='bottom: 125px;left: 595.5px;height:#{@BalkenGruen1t[0] * 17.8 + 20}px' ></div>"

				
    	
			
			when 4

				left = 720.5
				"<div class='kpi-column1' style='bottom: 125px;left: #{left}px;height:#{@BalkenGruen1[1] * 17.8 + 20}px' ></div>"
				 
				#Monday
				#"<div class='kpi-column1' style='bottom: 125px;left: 533.5px;height:#{@BalkenGruen1m[0] * 17.8 + 20}px' ></div>"

				 #Tuesday
				#"<div class='kpi-column1' style='bottom: 125px;left: 595.5.5px;height:#{@BalkenGruen1t[0] * 17.8 + 20}px' ></div>"

				#Wednesday
				#"<div class='kpi-column1' style='bottom: 125px;left: 658.5.5px;height:#{@BalkenGruen1w[0] * 17.8 + 20}px' ></div>"

				

			when 5

				left = 783
				"<div class='kpi-column1' style='bottom: 125px;left: #{left}px;height:#{@BalkenGruen1[1] * 17.8 + 20}px' ></div>"
					
				#Monday
				#"<div class='kpi-column1' style='bottom: 125px;left: 533.5px;height:#{@BalkenGruen1m[0] * 17.8 + 20}px' ></div>"

				 #Tuesday
				#"<div class='kpi-column1' style='bottom: 125px;left: 595.5px;height:#{@BalkenGruen1t[0] * 17.8 + 20}px' ></div>"

				#Wednesday
				#"<div class='kpi-column1' style='bottom: 125px;left: 658.5px;height:#{@BalkenGruen1w[0] * 17.8 + 20}px' ></div>"

				#Thursday
				#"<div class='kpi-column1' style='bottom: 125px;left: 720.5px;height:#{@BalkenGruen1th[0] * 17.8 + 20}px' ></div>"

				
    	end 	

   end

   	   #roter Balken 
   def kpi_column2(daten)

    	case @BalkenRot[0]

    		when 1
    			
				left = 533.5
				"<div class='kpi-column2' style='bottom:#{@BalkenRot[2] * 18 + 141}px;left:#{left}px;height:#{@BalkenRot[1] * 18.5 }px' ></div>"
				

			when 2
				
				left = 595.5
				"<div class='kpi-column2' style='bottom:#{@BalkenRot[2] * 18 + 141}px;left:#{left}px;height:#{@BalkenRot[1] * 18.5 }px' ></div>"
		
				#Monday		
				#"<div class='kpi-column2' style='bottom:#{@BalkenRot[2] * 18 + 141}px;left: 533.5px;height:#{@BalkenRotm[0] * 17.8 + 20}px' ></div>"		


			when 3
				
				left = 658.5
				"<div class='kpi-column2' style='bottom:#{@BalkenRot[2] * 18 + 141}px;left:#{left}px;height:#{@BalkenRot[1] * 18.5 }px' ></div>"
		
    			#Monday		
				#"<div class='kpi-column2' style='bottom:#{@BalkenRot[2] * 18 + 141}px;left: 533.5px;height:#{@BalkenRotm[0] * 17.8 + 20}px' ></div>"		

    			#Tuesday		
				#"<div class='kpi-column2' style='bottom:#{@BalkenRot[2] * 18 + 141}px;left: 595.5px;height:#{@BalkenRott[0] * 17.8 + 20}px' ></div>"		

				

			when 4

				left = 720.5
				"<div class='kpi-column2' style='bottom:#{@BalkenRot[2] * 18 + 141}px;left:#{left}px;height:#{@BalkenRot[1] * 18.5 }px' ></div>"
		
				#Monday		
				#"<div class='kpi-column2' style='bottom:#{@BalkenRot[2] * 18 + 141}px;left: 533.5px;height:#{@BalkenRotm[0] * 17.8 + 20}px' ></div>"		

				#Tuesday		
				#"<div class='kpi-column2' style='bottom:#{@BalkenRot[2] * 18 + 141}px;left: 595.5px;height:#{@BalkenRott[0] * 17.8 + 20}px' ></div>"		

				#Wednesday		
				#"<div class='kpi-column2' style='bottom:#{@BalkenRot[2] * 18 + 141}px;left: 658.5px;height:#{@BalkenRotw[0] * 17.8 + 20}px' ></div>"		

				


			when 5
				
				left = 783
				"<div class='kpi-column2' style='bottom:#{@BalkenRot[2] * 18 + 141}px;left:#{left}px;height:#{@BalkenRot[1] * 18.5 }px' ></div>"
	
				#Monday		
				#"<div class='kpi-column2' style='bottom:#{@BalkenRot[2] * 18 + 141}px;left: 533.5px;height:#{@BalkenRotm[0] * 17.8 + 20}px' ></div>"		

				#Tuesday		
				#"<div class='kpi-column2' style='bottom:#{@BalkenRot[2] * 18 + 141}px;left: 595.5px;height:#{@BalkenRott[0] * 17.8 + 20}px' ></div>"		

				#Wednesday		
				#"<div class='kpi-column2' style='bottom:#{@BalkenRot[2] * 18 + 141}px;left: 658.5px;height:#{@BalkenRotw[0] * 17.8 + 20}px' ></div>"		

				#Thursday			
				#"<div class='kpi-column2' style='bottom:#{@BalkenRot[2] * 18 + 141}px;left: 720.5px;height:#{@BalkenRotth[0] * 17.8 + 20}px' ></div>"		

				

    	end 	
   end

   


end 
