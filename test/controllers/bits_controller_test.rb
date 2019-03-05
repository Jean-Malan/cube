require 'test_helper'

class BitsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bit = bits(:one)
  end

  test "should get index" do
    get bits_url
    assert_response :success
  end

  test "should get new" do
    get new_bit_url
    assert_response :success
  end

  test "should create bit" do
    assert_difference('Bit.count') do
      post bits_url, params: { bit: { content: @bit.content, profile_id: @bit.profile_id } }
    end

    assert_redirected_to bit_url(Bit.last)
  end

  test "should show bit" do
    get bit_url(@bit)
    assert_response :success
  end

  test "should get edit" do
    get edit_bit_url(@bit)
    assert_response :success
  end

  test "should update bit" do
    patch bit_url(@bit), params: { bit: { content: @bit.content, profile_id: @bit.profile_id } }
    assert_redirected_to bit_url(@bit)
  end

  test "should destroy bit" do
    assert_difference('Bit.count', -1) do
      delete bit_url(@bit)
    end

    assert_redirected_to bits_url
  end
end
