require 'test_helper'

class RegionTest < ActiveSupport::TestCase
  test 'should not save region without name' do
    region = Region.new
    assert_not region.save, 'Saved the region without name'
  end

  test 'region name should be unique' do
    region1 = Region.new name: 'one'
    region1.save
    region2 =Region.new name: 'one'
    assert_not region2.save, 'Saved the region with existing name'
  end
end
