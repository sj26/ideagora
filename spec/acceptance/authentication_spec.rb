require "acceptance/acceptance_helper"

feature "Authentication", %q{
  In order to take part in rc activities
  As a rails peep
  I want to be able to log in
} do
  let!(:camp) { create(:camp) }
  let!(:user) { create(:user).tap { |user| create(:attendance, camp: camp, user: user) } }

  scenario "current railscamp peep with email" do
    visit sign_in
    expect(page).to have_content('Sign in')

    fill_in 'details', :with => user.email
    click_button 'Let me in'
    expect(page).to have_content('Logged in!')
  end

  scenario "current railscamp peep with twitter username" do
    visit sign_in
    expect(page).to have_content('Sign in')

    fill_in 'details', :with => user.twitter
    click_button 'Let me in'
    expect(page).to have_content('Logged in!')
  end

  scenario "an unregistered email" do
    visit sign_in
    expect(page).to have_content('Sign in')

    fill_in 'details', with: Faker::Internet.email
    click_button 'Let me in'
    expect(page).to have_content('Cannot log you in.')
  end

  scenario "not logged in, trying to access user profile page" do
    visit sign_in
    expect(page).to have_content('Sign in')

    visit my_profile_path
    assert_unauthorised
  end
end
