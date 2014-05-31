require 'test_helper'

class StoreControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_select '#columns #side a', :minimum=>4
    #the above looks for a a element inside side id inside columns id
    assert_select '#main .entry', 3
    #the above checks that there are 3 elements inside the entry class inside the main id
    assert_select 'h3', 'Programming Ruby 1.9'
    assert_select '.price', /\$[,\d]+\.\d\d/
    #the assert_select will look for expected css class, id or html element

  end

end
