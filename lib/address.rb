require_relative 'geocoding'

class Address
  attr_accessor :lat, :lng, :full_address

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
