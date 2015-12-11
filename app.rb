require 'rubygems'
require 'sinatra'
require "sinatra/activerecord"
require "chartkick"
require_relative "activeRecord"
require 'groupdate'
require 'pry'

get '/' do
  @measurements = Measurement.all
  @chart_room1_temp = Measurement.where(:place_name=> "room1").pluck(:created_at, :temperature) # substring(:temperature, 1, 10)
  @chart_room2_temp = Measurement.where(:place_name=> "room2").pluck(:created_at, :temperature)
  @chart_room3_temp = Measurement.where(:place_name=> "room3").pluck(:created_at, :temperature)
  @chart_room1_humi = Measurement.where(:place_name=> "room1").pluck(:created_at, :humidity)
  @chart_room2_humi = Measurement.where(:place_name=> "room2").pluck(:created_at, :humidity)
  @chart_room3_humi = Measurement.where(:place_name=> "room3").pluck(:created_at, :humidity)
  @average_by_date = Measurement.group_by_day(:created_at).average(:temperature)#.collect { |a| [a[0].to_s,a[1].to_f] }
  erb :index
end
counter = 0
decimationFactor = 10
post '/measurement' do
  counter += 1
  @temperature = (params[:temperature])
  @humidity = (params[:humidity])
  @status = (params[:status])
  @place_name = (params[:place_name])
  if (counter == decimationFactor)
    Measurement.create(:temperature => @temperature, 
      :humidity => @humidity,
      :created_at => Time.now,
      :status => @status,
      :place_name => @place_name)
    counter = 0;
  end
  open("public/" + @place_name + "-lastMeasurements.txt", "w") do |f|
    f.puts "#{@temperature}"
    f.puts "#{@humidity}"
    f.puts "#{@status}"
    f.puts "#{Time.now}"
    f.puts "#{request.ip}"
  end
end

post '/movement' do
  @place_name = (params[:place_name])
  Movement.create(:created_at => Time.now, :place_name => @place_name)
  open("public/" + @place_name + "-lastMovement.txt", "w") do |f|
    f.puts "#{Time.now}"
  end
end

class Measurement < ActiveRecord::Base
end

class Movement < ActiveRecord::Base
end


class App < Sinatra::Application
end

get '/destroyMeasurement' do
  @value = Measurement.find(params[:id])
  @value.destroy
  #redirect "/"
end
 