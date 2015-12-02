require 'rubygems'
require 'sinatra'
require "sinatra/activerecord"
require "chartkick"
require_relative "activeRecord"
require 'groupdate'
require 'pry'

get '/' do
  @measurements = Measurement.all
  @data_for_chart = Measurement.pluck(:created_at, :temperature)
  @average_by_date = Measurement.group_by_day(:created_at).average(:temperature).to_a #.collect { |a| [a[0].to_s,a[1].to_f] }
  erb :index
end

post '/sensor1' do
  @temperature = (params[:temperature])
  @humidity = (params[:humidity])
  #Measurement.create(:temperature => @temperature, :created_at => Time.now)
  #Measurement.create(:humidity => @humidity, :created_at => Time.now)
  open("public/sensor1.txt","w") do |f|
    f.puts "#{Time.now} - #{request.ip}\n"
    f.puts "\n"
    f.puts " "
    cDegree = "\u2103"
    #f.puts cDegree.force_encoding('utf-8')
    f.puts "#{@temperature} #{cDegree.force_encoding('utf-8')} - #{@humidity} %"
  end
 end

class Measurement < ActiveRecord::Base
end


class App < Sinatra::Application
end

get '/destroyMeasurement' do
  @value = Measurement.find(params[:id])
  @value.destroy
  #redirect "/"
end
  

   
