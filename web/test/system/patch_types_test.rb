require "application_system_test_case"

class PatchTypesTest < ApplicationSystemTestCase
  setup do
    @patch_type = patch_types(:one)
  end

  test "visiting the index" do
    visit patch_types_url
    assert_selector "h1", text: "Patch Types"
  end

  test "creating a Patch type" do
    visit patch_types_url
    click_on "New Patch Type"

    fill_in "Name", with: @patch_type.name
    click_on "Create Patch type"

    assert_text "Patch type was successfully created"
    click_on "Back"
  end

  test "updating a Patch type" do
    visit patch_types_url
    click_on "Edit", match: :first

    fill_in "Name", with: @patch_type.name
    click_on "Update Patch type"

    assert_text "Patch type was successfully updated"
    click_on "Back"
  end

  test "destroying a Patch type" do
    visit patch_types_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Patch type was successfully destroyed"
  end
end
