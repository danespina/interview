# require 'active_record'
require_relative 'geocoding'

# ActiveRecord::Base.establish_connection(
#   :adapter => 'sqlite3',
#   :database =>  'interview.db'
# )

class Address #< ActiveRecord::Base
  # extend Geocoder::Model::ActiveRecord
  attr_accessor :lat, :lng, :full_address
  # reverse_geocoded_by :latitude, :longitude
  # geocoded_by :address
  # after_validation :geocode
  # after_validation :reverse_geocode

  def initialize(lat = nil, lng = nil, full_address = nil)
    @lat = lat
    @lng = lng
    @full_address = full_address
    self.code unless self.reverse_geocoded?
    self.rev_code unless self.geocoded? 
  end

  def geocoded?
    !!self.full_address
  end

  def reverse_geocoded?
    self.lat && self.lng
  end

  def code
    result = Geocoder.search(self.full_address)
    self.lat = result.first.latitude
    self.lng = result.first.longitude
    self
  end

  def rev_code
    result = Geocoder.search("#{self.lat},#{self.lng}")
    self.full_address = result.first.data['address']['Match_addr']
    self
  end

  def miles_to(target)
    Geocoder::Calculations.distance_between(
      [self.lat, self.lng],
      [target.lat, target.lng]
    )
  end

end
