require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  test "should get title:string" do
    get :title:string
    assert_response :success
  end

  test "should get body:text" do
    get :body:text
    assert_response :success
  end

end
