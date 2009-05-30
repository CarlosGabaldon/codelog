require 'sequel'
require 'date'

DB = Sequel.sqlite('./db/codelog.db')

unless DB.table_exists? :logs
  DB.create_table :logs do
    primary_key :id
    text :entry
    text :date
    datetime :created_at
  end
  
  # populate the table
  DB[:logs].insert(
    :entry => 'First entry..', 
    :date => Date.today.strftime("%m-%d-%Y"),
    :created_at => DateTime.now)

  
end