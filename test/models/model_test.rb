require 'test_helper'

class ModelTest < ActiveSupport::TestCase

  test 'Name should be unique' do
    corolla = Model.new(name: 'Corolla', synonym: 'corolla')
    corolla.save
    corolla2 = Model.new(name: 'Corolla', synonym: 'corolla')
    assert_not corolla2.save, 'Saved duplicate model name'
  end
end
