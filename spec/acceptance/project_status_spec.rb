require 'acceptance/acceptance_helper'

describe 'Viewing and setting a project\'s status', :type => :request do
  before do
    clear_db
    @c = Camp.make!
    @u = User.make!
    @c.users << @u
    @p = Project.make!(:owner => @u)
  end
  
  context 'when logged in' do
    before do
      sign_in_as(@u)
    end

    context 'when viewing an active project' do
      before do
        @p.status = Active.new
      end
      
      it "should show the status as active" do
        visit projects_path
        page.should have_content(@p.name)
        page.should have_content("Active")
        
        visit project_path(@p)
        
        page.should have_content("Status: Active")
      end
    end

    it 'can set a project status to Canned' do
      visit project_path(@p)
      
      page.should have_content('Status: Active')
      page.should have_content('Completed!')
      page.should have_content('Can it!')
      
      click_link 'Can it!'
      
      current_path.should == project_path(@p)
      
      page.should have_content('Status: Canned')
      page.should have_content('Start it up again?')
      
      page.should_not have_content('Status: Active')
      page.should_not have_content('Can it!')
    end
  end
end
