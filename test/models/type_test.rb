require 'test_helper'

class TypeTest < ActiveSupport::TestCase

  test 'Name should be unique' do
    corolla = Type.new(name: 'Corolla', synonym: 'corolla')
    corolla.save
    corolla2 = Type.new(name: 'Corolla', synonym: 'corolla')
    assert_not corolla2.save, 'Saved duplicate type name'
  end
end
