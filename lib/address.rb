require 'active_record'
require_relative 'geocoding'

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database =>  'interview.db'
)

class Address < ActiveRecord::Base
  extend Geocoder::Model::ActiveRecord
  attr_accessor :latitude, :longitude, :address
  reverse_geocoded_by :latitude, :longitude
  geocoded_by :address
  after_validation :geocode
  after_validation :reverse_geocode

  def rev_code
    result = Geocoder.search("#{self[:latitude]},#{self[:longitude]}")
    result.first.address
  end
  
end
