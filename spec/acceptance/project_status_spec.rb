require "acceptance/acceptance_helper"

feature "Viewing and setting a project's status" do
  before do
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
      it "should show the status as active" do
        visit projects_path

        find("table tbody tr:first-child").should have_content(@p.name)
        find("table tbody tr:first-child").should have_content("Active")
        
        visit user_project_path(@u, @p)
        
        page.should have_content("Status: Active")
      end
    end

    it 'can set a project status to Canned' do
      visit user_project_path(@u, @p)
      
      page.should have_content('Status: Active')
      page.should have_content('Completed!')
      page.should have_content('Can it!')
      
      click_link 'Can it!'
      
      expect(current_path).to eql(user_project_path(@u, @p))

      page.should have_content('Status: Canned')
      page.should have_content('Start it up again?')
      
      page.should_not have_content('Status: Active')
      page.should_not have_content('Can it!')
    end
  end
end
