require 'spec_helper'

feature 'User signs in', %q{
As a registered user,
I want to view my profile
So I can see if my profile is up to date

Acceptance Criteria
*I must sign in
*I must click on 'View Profile'
} do

  scenario 'signs in with valid attributes' do
    user = FactoryGirl.create(:user)
    sign_in_fill(user)
    click_on 'Sign in'
    expect(page).to have_content("Welcome")
    expect(page).to have_content("Profile")
    expect(page).to have_content("Browse")
    expect(page).to have_content("Sign Out")
  end

  scenario 'signs in with invalid attributes' do
    visit root_path
    click_on 'Sign In'
    click_on 'Sign in'
    expect(page).to have_content("Invalid email or password.")
  end

  scenario 'views own profile page' do
    user = FactoryGirl.create(:user)
    sign_in_fill(user)
    click_on 'Sign in'
    expect(page).to have_content(user.username)
    expect(page).to have_content(user.location)
    expect(page).to have_content(user.gender)
  end

  scenario 'edits profile page' do
    user = FactoryGirl.create(:user)
    sign_in_fill(user)
    click_on 'Sign in'
    click_on 'Edit Profile'
    expect(page).to have_content("Edit Profile")
    fill_in "Location", with: "cambridge, ma"
    fill_in "Current password", with: user.password
    click_on "Update User"
    expect(page).to have_content("WeFit")
  end
end

