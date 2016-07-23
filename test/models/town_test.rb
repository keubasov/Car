require 'test_helper'

class TownTest < ActiveSupport::TestCase

  test 'should not save region town without name or region' do
    tara = Town.new(name: tara)
    assert_not tara.save, 'Saved the town without region'
    tara.update(name: nil, region_id: 1)
    assert_not tara.save, 'Saved the town without name'
  end

  test 'town in region should be unique' do
    tara1 = Town.new(name: 'tara', region_id: 1)
    tara2 = Town.new(name: 'tara', region_id: 1)
    tara1.save
    assert_not tara2.save, 'Saved duplicate town in the same region'
  end
end
