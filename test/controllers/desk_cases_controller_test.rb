require 'test_helper'

class DeskCasesControllerTest < ActionController::TestCase
  setup do
    @desk_case = desk_cases(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:desk_cases)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create desk_case" do
    assert_difference('DeskCase.count') do
      post :create, desk_case: {  }
    end

    assert_redirected_to desk_case_path(assigns(:desk_case))
  end

  test "should show desk_case" do
    get :show, id: @desk_case
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @desk_case
    assert_response :success
  end

  test "should update desk_case" do
    patch :update, id: @desk_case, desk_case: {  }
    assert_redirected_to desk_case_path(assigns(:desk_case))
  end

  test "should destroy desk_case" do
    assert_difference('DeskCase.count', -1) do
      delete :destroy, id: @desk_case
    end

    assert_redirected_to desk_cases_path
  end
end
