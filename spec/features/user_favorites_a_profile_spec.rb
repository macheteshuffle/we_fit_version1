require 'spec_helper'



feature 'User favorites a profile', %q{
  User Story:
  As a user,
  I want to add profile favorites,
  So that I can come back to the profile later
} do
  # Acceptance Criteria:
  # * I must click on the favorite button for the profile I want to keep
  # * I must go to the Favorites page to view my favorites

  scenario 'clicks on profile to favorite', js: true do
    user = FactoryGirl.create(:user)
    profile = FactoryGirl.create(:user, username: "PilatesLover")

    visit new_user_session_path

    within ".new_user" do
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_on 'Sign in'
    end

    click_on 'Browse Members'

    within "#member_user_#{profile.id}" do
      page.find("#user_#{profile.id}").trigger('click')
      page.find('.add').trigger('click')
    end

    expect(page).to have_content('Added to Favorites')

    click_on 'Favorites'
    expect(page).to have_content(profile.username)
    expect(page).to have_content(profile.gender)
    expect(page).to have_content(profile.location)
  end
end
