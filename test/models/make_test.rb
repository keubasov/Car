require 'test_helper'

class MakeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test 'Name should be unique' do
    toyota = Make.new(name: 'Toyota', synonym: 'toyota')
    toyota.save
    toyota2 = Make.new(name: 'Toyota', synonym: 'toyota2')
    assert_not toyota2.save, 'Saved duplicate make name'
  end
end
