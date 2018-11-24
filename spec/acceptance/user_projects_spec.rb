require "acceptance/acceptance_helper"

feature "User's projects" do
  before do
    clear_db
    @c = Camp.make!
    @u = User.make!
    @c.users << @u
    @p = Project.make!(:owner => @u)
  end
  
  context 'when not logged in' do
    it 'can see /projects' do
      visit projects_path
      page.should have_content(@p.name)
    end
    
    it 'can see /users/1/projects' do
      visit user_projects_path(@u)
      page.should have_content(@p.name)
    end
    
    it 'cannot access /users/1/projects/new' do
      visit new_user_project_path(@u)
      assert_unauthorised
    end
  end

  context 'when logged in' do
    before do
      sign_in_as(@u)
    end

    context 'when new project' do
      it "should not create a project without a name" do
        visit user_path(@u)
        page.should have_content('Add a project')
        click_link 'Add a project'
      
        page.should have_content('Create a new project')
        
        page.click_button 'Create Project'
        
        current_path.should == user_projects_path(@u)
        page.should have_content "can't be blank"
      end
      
      it 'creates and sets current_user as owner' do
        visit new_user_project_path(@u)
        
        attrs = { 
          :name => 'Happy campers',
          :description => 'App for railscamps'
        }
      
        attrs.each do |attr, value|
          fill_in attr.to_s.humanize, :with => value
        end
      
        page.click_button 'Create Project'
      
        current_path.should == user_path(@u)
        page.should have_content('Happy campers')

        # check flash
        @u.projects.count.should == 2
        Project.last.owner == @u
      end
    end
    
    context 'with existing project' do
      it "cannot edit else's project" do
        @other = User.make!
        @other_project = Project.make!(:owner => @other)
        visit root_url
        visit edit_user_project_path(@other, @other_project)
        expect(current_path).to eql(root_path)
        expect(page).to have_content('You cannot edit projects that are not yours')
      end
      
      it "when on other camper's page, should not see edit or delete links" do
        @other = User.make!
        @other_project = Project.make!(:owner => @other)
        visit user_path(@other)
        
        find('.projects').should_not have_content('Edit')
        find('.projects').should_not have_content('Delete')
      end
      
      it "can edit own projects" do
        visit user_path(@u)
        page.should have_content('My projects')
        find("article#project_#{@p.id}").click_link('Edit this project')
        
        fill_in 'Name', :with => 'new name'
        page.click_button 'Update Project'
        
        current_path.should == user_path(@u)
        @u.projects.count == 0
      end
      
      it "can delete own project" do
        visit user_path(@u)
        find("li#project_#{@p.id}").click_link('Delete')
        @u.projects.count == 0
      end
    end
  end
end
