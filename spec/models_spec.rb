require 'rubygems'
require 'spec'
require 'sequel'

# Test DB - In memmory
DB = Sequel.sqlite

$LOAD_PATH.unshift(File.dirname(__FILE__) + '/')
require 'models'

describe Log do
  
  before do
    @date = Date.today.strftime("%m-%d-%Y")
		@log = Log.new do |l|
      l.entry = "Test log entry.."
      l.date = @date
      l.created_at = DateTime.now
      l.save
    end
	end
	
	it "should find log by date" do
	  Log.find_by_date(@date).should_not == nil
	end
  
  it "should allow linking between logs" do
    @related_log = Log.new do |l|
      l.entry = "This entry is related to the first"
      l.date = Date.today.strftime("%m-%d-%Y")
      l.created_at = DateTime.now
      l.save
    end
    @log.link_with @related_log
    @log.linked_log.should == @related_log.id
  end
  
end