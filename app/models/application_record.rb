class ApplicationRecord < ActiveRecord::Base
  
  Time.zone = 'America/Mexico_City'		

  self.abstract_class = true
  
 

end
