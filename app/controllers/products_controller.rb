class ProductsController < ApplicationController



	def show

		#16.10.2017 filtern über scope im model product.rb

		#Chart_Box
		@rueckmeldung_alt = Product.p_status('800').rueckmeldung_alt
		@rueckmeldung_KW_aktuell = Product.p_relevanz('Ja,M').rueckmeldung_kw_aktuell
		@uebergabe_KW_aktuell = Product.p_relevanz('Ja,M').uebergabe_kw_aktuell
		@uebergabe_KW_naechste = Product.p_relevanz('Ja,M').uebergabe_kw_naechste


		#JS Graph --- Wochenbericht siehe auch sb-admin-charts.js.erb 20.01.2018

		#letzte Woche
		@montageuebergabe1 = Product.p_relevanz('Ja,M').uebergabe_letzte_kw
		@inklaerung1 = Product.in_klärung.zeit_last_week_P_Statusd
        @nichtmontagerelevant1 = Product.notrelevant.no_p_relevanz('Ja,M').no_p_relevanz('Ja ,M').no_p_relevanz('Ja, M').zeit_last_week_P_Statusd
        @eingaenge1 = Product.eingaenge

        #vorletzte Woche
        @montageuebergabe2 = Product.p_relevanz('Ja,M').uebergabe_vorletzte_kw
        @inklaerung2 = Product.in_klärung.zeit_last2_week_P_Statusd
        @nichtmontagerelevant2 = Product.notrelevant.no_p_relevanz('Ja,M').no_p_relevanz('Ja ,M').no_p_relevanz('Ja, M').zeit_last2_week_P_Statusd
        @eingaenge2 = Product.eingaenge2

        #vor 3 Wochen
        @montageuebergabe3 = Product.p_relevanz('Ja,M').uebergabe_vorvorletzte_kw
        @inklaerung3 = Product.in_klärung.zeit_last3_week_P_Statusd
        @nichtmontagerelevant3 = Product.notrelevant.no_p_relevanz('Ja,M').no_p_relevanz('Ja ,M').no_p_relevanz('Ja, M').zeit_last3_week_P_Statusd
        @eingaenge3 = Product.eingaenge3

        #vor 4 Wochen
        @montageuebergabe4 = Product.p_relevanz('Ja,M').uebergabe_vorvorvorletzte_kw
        @inklaerung4 = Product.in_klärung.zeit_last4_week_P_Statusd
        @nichtmontagerelevant4 = Product.notrelevant.no_p_relevanz('Ja,M').no_p_relevanz('Ja ,M').no_p_relevanz('Ja, M').zeit_last4_week_P_Statusd
        @eingaenge4 = Product.eingaenge4


		a_array = [ @montageuebergabe4.count, @montageuebergabe3.count, @montageuebergabe2.count, @montageuebergabe1.count ]

		b_array = [ @inklaerung4.count, @inklaerung3.count, @inklaerung2.count, @inklaerung1.count ]

		c_array = [ @nichtmontagerelevant4.count, @nichtmontagerelevant3.count, @nichtmontagerelevant2.count, @nichtmontagerelevant1.count ]

		d_array = [@eingaenge4.count, @eingaenge3.count, @eingaenge2.count, @eingaenge1.count ]



		@data = [{

                name: 'Montageübergabe',
                data:  print(a_array)
            },  {
                name: 'In Klärung',
      			data: print(b_array)
            }, {
                name: 'keine Montagerelevanz',
      			data: print(c_array)

      		}, {
      			type: 'spline',
      			name: 'Eingänge',
      			data: print(d_array),

			marker: {
            lineWidth: 2,

        	}


            }]

        # KPI_Bericht ################ 29.01.2018############################

        #Übergabe diese Woche


        # Code Amine ###############

        #
        ################
        @y_werte = []
        @wt = Time.zone.now.wday

        (1..@wt).each do |day|
            @y_werte << JsDatum.p_relevanz('Ja,M').uebergabe_kw_aktuell_KPI_gruenerBalken.day(day).count.to_i
        end




        #grüner Balken Daten aus model js_datum.rb + aktuller Wochentag  --> application_helper.rb
        @BalkenGruen = JsDatum.p_relevanz('Ja,M').uebergabe_kw_aktuell_KPI_gruenerBalken #aktueller Tag unabhängig von Day

     	@BalkenGruenMonday = JsDatum.p_relevanz('Ja,M').uebergabe_kw_aktuell_KPI_gruenerBalken.day('1')
     	@kpi_data = [ @wt , @BalkenGruen.count, @BalkenGruenMonday.count ]



        #Dienstag grüner Balken
        @BalkenGruenTuesday = JsDatum.p_relevanz('Ja,M').uebergabe_kw_aktuell_KPI_gruenerBalken.day('2')
        @kpi_datatday = [@BalkenGruenTuesday.count]

		#Mittwoch grüner Balken
        @BalkenGruenWednesday = JsDatum.p_relevanz('Ja,M').uebergabe_kw_aktuell_KPI_gruenerBalken.day('3')
        @kpi_datawday = [@BalkenGruenWednesday.count]

        #Donnerstag grüner Balken
        @BalkenGruenThursday = JsDatum.p_relevanz('Ja,M').uebergabe_kw_aktuell_KPI_gruenerBalken.day('4')
        @kpi_datathday = [@BalkenGruenThursday.count]





     	#blaue Linien#######################

		#blaue Linie ET nächste Woche
     	@BlaueLinieET = JsDatum.p_relevanz('Ja,M').uebergabe_kw_naechste_KPI_blaueLinie
		@kpi_Balken = [ @BlaueLinieET.count ]

		#blaue Linie ET übernächste Woche
		@BlaueLinieET1W = JsDatum.p_relevanz('Ja,M').uebergabe_kw_naechsten2_KPI_blaueLinie2
		@kpi_Balken1 = [ @BlaueLinieET1W.count ]

		#blaue Linie ET diese Woche
		@BlaueLinieET2W = JsDatum.p_relevanz('Ja,M').uebergabe_kw_thisweek_KPI_blaueLinie3
		@kpi_Balken2 = [ @BlaueLinieET2W.count ]

		##Einsatzrückmeldung ############################

		#grüner Balken Einsatzrückmeldung
		@EinsatzDieseW = JsDatum.einsatz_kw_aktuell_KPI
		@BalkenGruen1  = [ @wt ,@EinsatzDieseW.count]
		#render richtiges Format in index#view


		#Montag grüner Balken
		@EinsatzDieseWMonday = JsDatum.einsatz_kw_aktuell_KPI.day('1')
		@BalkenGruen1m  = [ @EinsatzDieseWMonday.count]

		#Dienstag grüner Balken
		@EinsatzDieseWTuesday = JsDatum.einsatz_kw_aktuell_KPI.day('2')
		@BalkenGruen1t  = [ @EinsatzDieseWTuesday.count]

		#Mittwoch grüner Balken
		@EinsatzDieseWWednesday = JsDatum.einsatz_kw_aktuell_KPI.day('3')
		@BalkenGruen1w  = [ @EinsatzDieseWWednesday.count]

		#Donnerstag grüner Balken
		@EinsatzDieseWThursday = JsDatum.einsatz_kw_aktuell_KPI.day('4')
		@BalkenGruen1th = [ @EinsatzDieseWThursday.count]



		#roter Balken Einsatzrückmeldung_alt
		@EinsatzRueckm =  JsDatum.rueckmeldung_alt_KPI

		@BalkenRot	  = [ @wt, @EinsatzRueckm.count, @BlaueLinieET2W.count] #@NummerVorhanden.count]


		#Montag roter Balken
		#@EinsatzRueckmm = JsDatum.rueckmeldung_alt_KPI.day('1')
		#@BalkenRotm	= [ @EinsatzRueckmm.count]

		#Dienstag roter Balken
		#@EinsatzRueckmt =  JsDatum.rueckmeldung_alt_KPI.day('2')
		#@BalkenRott	= [ @EinsatzRueckmt.count]

		#Mittwoch roter Balken
		#@EinsatzRueckmw =  JsDatum.rueckmeldung_alt_KPI.day('3')
		#@BalkenRotw	= [ @EinsatzRueckmw.count]

		#Donnerstag roter Balken
		#@EinsatzRueckmth =  JsDatum.rueckmeldung_alt_KPI.day('4')
		#@BalkenRotth	= [ @EinsatzRueckmth.count]






		respond_to do |format|

			format.html
			format.csv  { send_data @products.to_csv  }
			format.xls  { send_data 	@products.to_xls  }
		end

	end







	#1. Import Dateien
	def import

		Product.import(params[:file])
		JsDatum.import(params[:file])
		Shopfloor.import(params[:file])
		redirect_to root_url, notice: "Product imported"

		#@JSdata = Product.import(params[:file]).merge


	end



	def shopfloor

       	@array = Shopfloor.p_status('800').techUnterlagennichtvorhanden.map(&:Vorhaben)

        @labels = ['dog', 'cat', 'fish', 'joe']

    end







private

	def print(nums)
		nums.each do |number|
    	puts number
		end
	end


end





