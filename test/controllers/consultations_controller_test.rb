require 'test_helper'

class ConsultationsControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get consultations_new_url
    assert_response :success
  end

  test 'should get create' do
    get consultations_create_url
    assert_response :success
  end
end
