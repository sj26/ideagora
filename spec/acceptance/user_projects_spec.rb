require "acceptance/acceptance_helper"

feature "User's projects" do
  let!(:camp) { create(:camp) }
  let!(:user) { create(:user).tap { |user| create(:attendance, camp: camp, user: user) } }

  context "when logged in" do
    before do
      sign_in_as(user)
    end

    it "can create a new project" do
      visit user_path(user)
      expect(page).to have_content("Add a project")

      click_link "Add a project"
      expect(page).to have_content("Create a new project")

      page.click_button "Create Project"
      expect(current_path).to eql(user_projects_path(user))
      expect(page).to have_content "can't be blank"
    end

    it "creates and sets current_user as owner" do
      visit new_user_project_path(user)

      fill_in "Name", with: "Happy Campers"
      fill_in "Description", with: "App for railscamps"

      page.click_button "Create Project"

      expect(current_path).to eql(user_path(user))
      expect(page).to have_content("Project was successfully created")
      expect(page).to have_content("Happy Campers")
    end

    context "with existing project" do
      let!(:project) { create(:project, owner: user, name: "Happy Campers") }

      it "cannot edit else's project" do
        other_user = create(:user)
        other_project = create(:project, owner: other_user)

        visit user_path(other_user)
        expect(page).not_to have_content("My projects")
        expect(find(".projects")).to have_content(other_project.name)
        expect(find(".projects")).not_to have_content("Edit")
        expect(find(".projects")).not_to have_content("Delete")

        visit edit_user_project_path(other_user, other_project)
        expect(current_path).to eql(root_path)
        expect(page).to have_content("You cannot edit projects that are not yours")
      end

      it "can edit own projects" do
        visit user_path(user)
        expect(page).to have_content("My projects")
        expect(page).to have_content("Happy Campers")

        find("article#project_#{project.id}").click_link("Edit this project")

        fill_in "Name", with: "New Name"
        page.click_button "Update Project"

        expect(current_path).to eql(user_path(user))
        expect(page).to have_content("Project was successfully updated")
        expect(page).to have_content("New Name")
        expect(page).not_to have_content("Happy Campers")
      end

      it "can delete own project" do
        visit user_path(user)
        expect(page).to have_content("My projects")
        expect(page).to have_content("Happy Campers")

        find("article#project_#{project.id}").click_link("Delete this project")
        expect(page).to have_content("Project was successfully destroyed")
        expect(page).not_to have_content("Happy Campers")
      end
    end
  end
end
