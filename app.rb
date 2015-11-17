require 'rubygems'
require 'sinatra'
require "sinatra/activerecord"
require "chartkick"
#require 'groupdate'

ActiveRecord::Base.establish_connection(
  :adapter  => "mysql2",
  :host     => "localhost",
  :username => "termometr",
  :password => "termohaslo!",
  :database => "termometr"
)

get '/' do
  erb :index
end

post '/temperatura' do
  @temperatura = (params[:temperature])
 
  Place.create(:temperature => @temperature, :created_at => Time.now)
  open("public/log.txt","w") do |f|
    f.puts "#{Time.now} - #{request.ip} - #{@temperature}"
  end
 end

get '/temperaturaget' do
  @temperature = (params[:temperature])
#  Place.create params[:temperature]
  Place.create(:temperature => @temperature, :created_at => Time.now)
  open("public/log.txt","w") do |f|
    f.puts "#{Time.now} - #{request.ip} - #{@temperature}"
  end
  erb :ok
end

get '/temperatura2get' do
  @temperature2 = (params[:temperature])
  open("public/log2.txt","w") do |f|
    f.puts "#{Time.now} - #{request.ip} - #{@temperature2}"
  end
end

class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.float :temperature
      t.string :created_at
    end
  end
end

class Place < ActiveRecord::Base
end


class App < Sinatra::Application
end

def read
	f = File.open("log.txt")
  f.read
  @places = Place.all
end

get '/temperaturadestr' do
  @value = Place.find(params[:id])
  @value.destroy
  #redirect "/"
end
  

   
