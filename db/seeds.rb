address_coords = [
  {latitude: 61.582195, longitude: -149.443512},
  {latitude: 44.775211, longitude: -68.774184},
  {latitude: 25.891297, longitude: -97.393349},
  {latitude: 25.891297, longitude: -97.393349},
  {latitude: 45.787839, longitude: -108.502110},
  {latitude: 35.109937, longitude: -89.959983}
]

address_coords.each do |coords|
  p coords
  Address.create!(coords)
end
