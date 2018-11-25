require "acceptance/acceptance_helper"

feature "Viewing and setting a project's status" do
  let!(:camp) { create(:camp) }
  let!(:user) { create(:user).tap { |user| create(:attendance, camp: camp, user:user ) } }
  let!(:project) { create(:project, owner: user) }
  
  context 'when logged in' do
    before { sign_in_as(user) }

    context 'when viewing an active project' do
      it "should show the status as active" do
        visit projects_path

        expect(find("table tbody tr:first-child")).to have_content(project.name)
        expect(find("table tbody tr:first-child")).to have_content("Active")
        
        visit user_project_path(user, project)
        
        expect(page).to have_content("Status: Active")
      end
    end

    it 'can set a project status to Canned' do
      visit user_project_path(user, project)
      
      expect(page).to have_content('Status: Active')
      expect(page).to have_content('Completed!')
      expect(page).to have_content('Can it!')
      
      click_link 'Can it!'
      
      expect(current_path).to eql(user_project_path(user, project))

      expect(page).to have_content('Status: Canned')
      expect(page).to have_content('Start it up again?')
      
      expect(page).not_to have_content('Status: Active')
      expect(page).not_to have_content('Can it!')
    end
  end
end
