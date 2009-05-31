require 'sequel'
require 'date'

DB = Sequel.sqlite('./db/codelog.db')

# populate the table
DB[:logs].insert(
  :entry => 'First entry..', 
  :date => Date.today.strftime("%m-%d-%Y"),
  :linked_log => nil,
  :created_at => DateTime.now)
