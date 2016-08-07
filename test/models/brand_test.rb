require 'test_helper'

class BrandTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test 'Name should be unique' do
    toyota = Brand.new(name: 'Toyota', synonym: 'toyota')
    toyota.save
    toyota2 = Brand.new(name: 'Toyota', synonym: 'toyota2')
    assert_not toyota2.save, 'Saved duplicate brand name'
  end
end
