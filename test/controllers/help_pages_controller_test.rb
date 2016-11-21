require 'test_helper'

class HelpPagesControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers
  test "should get about" do
    get :about
    assert_response :success
  end

  test "should get how_it_works" do
    get :how_it_works
    assert_response :success
  end

end
