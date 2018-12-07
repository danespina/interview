require 'sinatra'
require 'sinatra/base'
# require 'sinatra/activerecord'
Dir['./lib/*.rb'].each { |f| require f }

# configure :development, :test do
#   set :database, {adapter: 'sqlite3', database: 'interview.db'}
# end

class Main < Sinatra::Base
  sample_addresses = [
    {lat: 61.582195, lng: -149.443512},
    {lat: 44.775211, lng: -68.774184},
    {lat: 25.891297, lng: -97.393349},
    {lat: 45.787839, lng: -108.502110},
    {lat: 35.109937, lng: -89.959983}
  ]

  sample_addresses.map! do |coords|
    Address.new(coords[:lat], coords[:lng])
  end


  get '/' do

    @addresses = sample_addresses
    @target = Address.new(nil, nil, '1600 Pennsylvania Avenue NW Washington, D.C. 20500')
    # @addresses = Address.all
    erb :index #, locals: { address: address }
  end
end
