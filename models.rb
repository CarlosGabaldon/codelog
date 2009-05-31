require 'sequel'
require 'date'

DB = Sequel.sqlite('./db/codelog.db')


class Log < Sequel::Model
  
  class << self
    def find_today
      Log.find( :all, 
        :conditions => ["created_at BETWEEN ? AND ?", Date.today, Date.today + 1 ], 
        :order => "created_at ASC" )
    end
    
    def find_by_date(date)
      Log.filter(:date => date)
    end
    
    def find_past_dates
      dates = []
      DB['select distinct date from logs order by created_at DESC'].each do |row|
        dates << row[:date]
      end
      
    end
    
  end
  
end