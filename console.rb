require('pry')
require_relative('models/property_tracker')
PropertyTracker.delete_all()

property1 = PropertyTracker.new({
  'address' => '15 Castle Terrace Street',
  'value' => 5000000,
  'number_of_bedrooms' => 6,
  'year_built' => 2006
})

property1.save()

property2 = PropertyTracker.new({
  'address' => '32 Queens Ferry Road',
  'value' => 100000,
  'number_of_bedrooms' => 1,
  'year_built' => 1850
})

property2.save()
property1.address = '33 Castle Terrace Street'
property1.update()


binding.pry
nil
