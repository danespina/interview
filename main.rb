require 'sinatra'
require 'sinatra/base'
Dir['./lib/*.rb'].each { |f| require f }


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

  white_house = Address.new(nil, nil, '1600 Pennsylvania Avenue NW Washington, D.C. 20500')

  sorted_addresses = sample_addresses.sort_by { |addr| addr.miles_to(white_house)}


  get '/' do

    @addresses = sorted_addresses
    @target = white_house
    erb :index #, locals: { address: address }
  end
end
