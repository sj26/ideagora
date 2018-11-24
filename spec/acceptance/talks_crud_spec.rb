require_relative "acceptance_helper"

feature "users CRUDing talks" do
  before do
    @camp = Camp.make!(start_at: "2018-11-23 15:00:00 UTC+11", end_at: "2018-11-26 09:00:00 UTC+11")
    @user = User.make!
    @attendance = Attendance.create!(camp: @camp, user: @user)
    @venue = Venue.make!(:camp => @camp)
    sign_in_as(@user)
  end

  it "lets users view the talks" do
    talk = Talk.make!(:camp => @camp, :venue => @venue, :name => "Sample Talk", :user => @user,
                      :start_at => "2018-11-24 09:00:00 UTC+11", :end_at => "2018-11-24 10:00:00 UTC+11")

    viewing_day = Date.new(2018, 11, 24)
    Timecop.freeze(viewing_day) do
      visit talks_path

      # Do we see the details for each talk on this day?
      @camp.talks.for_day(viewing_day).each do |talk|
        page.should have_content talk.name
      end

      #We should have links for the other talk days
      @camp.talks.collect(&:day).uniq.each do |day|
        page.should have_link day.strftime("%A") unless day == viewing_day
      end
    end
  end

  it "lets a user create a new talk" do
    visit talks_path

    click_link "Add a talk"

    first(:link, "Add Talk").click

    fill_in "Talk Title", with: "New Title"
    fill_in "Description", with: "A fantastic talk full of fantastic things"

    click_button "Create Talk"

    page.should have_content "Talk was successfully created"

    page.should have_content "New Title"
    page.should have_content "A fantastic talk full of fantastic things"
  end
end
