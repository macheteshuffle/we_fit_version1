require 'spec_helper'

feature 'User uploads profile picture', %q{
  User Story:
  As a member
  I want to upload an image
  So that other members are more likely to respond to me
} do
  # Acceptance Criteria:
  # * I can optionally include a photo of myself as part of my profile
  # * If I supply a photo, it must be a jpg, png, or gif
  # * If I supply a photo, it cannot exceed 5MB
  let(:new_email) {new_email = FactoryGirl.generate(:email)}
  let(:first_name) {first_name = "Jeff"}

  scenario 'uploads photo upon sign up' do
    visit new_user_registration_path
    fill_in "First name", with: first_name
    fill_in "Last name",  with: "Hamilton"
    fill_in "Email", with: new_email
    fill_in "Username", with: "angrybear"
    fill_in "Password", with: "somepassword"
    fill_in "Password confirmation", with: "somepassword"
    attach_file "Photo", Rails.root.join('spec/file_fixtures/profile.png')
    select "male", from: "Gender"
    click_on 'Create User'

    expect(page).to have_content("You have signed up successfully")
    expect(page).to have_content("Welcome angrybear")
    expect(User.last.photo).to be_present
  end

  scenario 'uploads photo when editing profile' do
    user = FactoryGirl.create(:user)
    sign_in_fill(user)
    click_on 'Sign in'
    click_on 'Edit Profile'
    fill_profile_fields(user)
    attach_file "Photo", Rails.root.join('spec/file_fixtures/profile.png')
    click_on "Update User"

    expect(User.last.photo).to be_present
  end

  def fill_profile_fields(user)
    fill_in "First name", with: user.first_name
    fill_in "Last name",  with: user.last_name
    fill_in "Email", with: user.email
    fill_in "Username", with: user.username
    fill_in "Current password", with: user.password
    select "male", from: "Gender"
  end

end
