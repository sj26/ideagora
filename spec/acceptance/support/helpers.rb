module HelperMethods
  # Put helper methods you need to be available in all tests here.
  def sign_in_as(user)
    visit sign_in_path
    fill_in 'details', :with => user.email
    click_button 'Let me in'
  end

  def assert_unauthorised
    current_path.should == root_path
    page.should have_content('Unauthorised!')
  end
end

RSpec.configuration.include HelperMethods, :type => :acceptance
RSpec.configuration.include HelperMethods, :type => :request #for capybara rspec
