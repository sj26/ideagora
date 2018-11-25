require "acceptance/acceptance_helper"

feature "message board notices" do
  let!(:camp) { create(:camp) }
  let!(:user) { create(:user).tap { |user| create(:attendance, camp: camp, user: user) } }
  let!(:organiser) { create(:user).tap { |user| create(:attendance, camp: camp, user: user, organiser: true) } }
  let!(:notice) { create(:notice, camp: camp, user: organiser) }

  context "when not logged in" do
    it "can see /camps/:id/message_board" do
      visit message_board_camp_path(camp)
      expect(page).to have_content(notice.title)
    end
  end
    
  context "when logged in user" do
    it "cannot access /notices/new" do
      sign_in_as(user)
      visit new_notice_path
      assert_unauthorised
    end
  end

  context "when logged in organiser" do
    before do
      sign_in_as(organiser)
    end

    it "can create a new notice" do
      visit new_notice_path
      expect(page).to have_content("Create a new notice")

      click_button "Create Notice"

      expect(page).to have_content("Create a new notice")
      expect(page).to have_content("can't be blank")

      save_page

      fill_in "Title", with: "Welcome"
      fill_in "Content", with: "Lorem ipsum"

      click_button "Create Notice"

      expect(page).to have_content("All Notices")
      expect(page).to have_content("Notice was successfully created")
      expect(page).to have_content("Welcome")
      expect(page).to have_content("Lorem ipsum")
    end

    it "can edit an existing notice" do
      visit notices_path
      expect(page).to have_content("All Notices")
      expect(page).to have_content(notice.title)

      find("li#notice_#{notice.id}").click_link("Edit")

      fill_in "Title", with: "New Title"
      click_button "Update Notice"

      expect(page).to have_content("All Notices")
      expect(page).to have_content("Notice was successfully updated")
      expect(page).to have_content("New Title")
    end

    it "can delete notice" do
      visit notices_path
      expect(page).to have_content("All Notices")
      expect(page).to have_content(notice.title)

      find("li#notice_#{notice.id}").click_link("Delete")
      expect(page).to have_content("All Notices")
      expect(page).to have_content("Notice was successfully destroyed")
      expect(page).not_to have_content(notice.title)
    end
  end
end
