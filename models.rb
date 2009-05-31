require 'date'

unless DB.table_exists? :logs
  DB.create_table :logs do
    primary_key :id
    text :entry
    text :date
    integer :linked_log
    datetime :created_at
  end
end

class Log < Sequel::Model

  class << self

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
  
  def link_with(log)
    self.update(:linked_log => log.id)
  end
  
end