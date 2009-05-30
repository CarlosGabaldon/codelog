require 'rubygems'
require 'sinatra'
require 'models'


before do
  
end

get '/' do
 @logs = Log.all
 erb :list
end

get '/log/:date' do |date|
  @logs = Log.find_by_date(date)
  erb :view
end

post '/' do
  entry = params[:entry]
  unless entry == ""
    Log.new do |l|
      l.entry = entry
      l.date = Date.today.strftime("%m-%d-%Y")
      l.created_at = DateTime.now
      l.save
    end
  end
  redirect '/'
end


helpers do
  def log_permalink(log)
    "log-#{log.id}-#{log.created_at.strftime("%m-%d-%Y")}"
  end
  def time_of_day(date)
    "#{date.strftime("%Y-%m-%d")}::#{date.strftime("%I:%M %p")}"
  end
  def past_logs
    Log.find_past_dates
  end
end
