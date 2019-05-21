require 'test_helper'

class PatchTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @patch_type = patch_types(:one)
  end

  test "should get index" do
    get patch_types_url
    assert_response :success
  end

  test "should get new" do
    get new_patch_type_url
    assert_response :success
  end

  test "should create patch_type" do
    assert_difference('PatchType.count') do
      post patch_types_url, params: { patch_type: { name: @patch_type.name } }
    end

    assert_redirected_to patch_type_url(PatchType.last)
  end

  test "should show patch_type" do
    get patch_type_url(@patch_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_patch_type_url(@patch_type)
    assert_response :success
  end

  test "should update patch_type" do
    patch patch_type_url(@patch_type), params: { patch_type: { name: @patch_type.name } }
    assert_redirected_to patch_type_url(@patch_type)
  end

  test "should destroy patch_type" do
    assert_difference('PatchType.count', -1) do
      delete patch_type_url(@patch_type)
    end

    assert_redirected_to patch_types_url
  end
end
