require 'spec_helper'

feature 'User signs up', %q{
As a guest
I want to register
So I can create a user profile and be a member

Acceptance Criteria:
*I must provide a username
*I must provide a password
*I must confirm my password
*I must provide first name
*I must provide last name
*I must provide email
*I must submit the registration form
} do
  let(:new_email) {new_email = FactoryGirl.generate(:email)}
  let(:first_name) {first_name = "Jeff"}

  scenario 'with valid and required attributes' do
    ActionMailer::Base.deliveries = []
    visit new_user_registration_path

    fill_in "First name", with: first_name
    fill_in "Last name",  with: "Hamilton"
    fill_in "Email", with: new_email
    fill_in "Username", with: "angrybear"
    fill_in "Password", with: "somepassword"
    fill_in "Password confirmation", with: "somepassword"
    select "male", from: "Gender"
    click_on 'Create User'

    expect(page).to have_content("You have signed up successfully")
    expect(page).to have_content("Welcome angrybear")

    #expect email details pertaining to the confirmation
    expect(ActionMailer::Base.deliveries.size).to eql(1)
    last_email = ActionMailer::Base.deliveries.last
    expect(last_email).to have_subject('Member Confirmation')
    expect(last_email).to deliver_to(new_email)

  end

  scenario 'required info is not filled out' do
    visit new_user_registration_path
    click_on 'Create User'

    expect(page).to have_content("First name can't be blank")
    expect(page).to have_content("Last name can't be blank")
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password can't be blank")
    expect(page).to have_content("Gender can't be blank")
    expect(page).to_not have_content("Sign Out")
  end


  scenario 'password confirmation does not match' do
    visit new_user_registration_path

    fill_in "First name", with: first_name
    fill_in "Last name",  with: "Hamilton"
    fill_in "Email", with: new_email
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "somepassword"
    select "male", from: "Gender"


    click_on 'Create User'

    expect(page).to have_content("Password confirmation doesn't match")
  end

end
