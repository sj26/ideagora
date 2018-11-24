require "acceptance/acceptance_helper"

feature 'message board notices' do
  before do
    clear_db
    @c = Camp.current || Camp.make!
    @u = User.make!
    Attendance.make!(:camp => @c, :user => @u)
    
    @organiser = User.make!
    Attendance.make!(:camp => @c, :user => @organiser, :organiser => true)
    
    User.all.count == 2
    User.organisers == 1
    
    # puts @organiser.attendances.first.organiser
    # @organiser.organiser?.should be_true
    
    @notice = Notice.make!(:camp => @c, :user => @organiser)
  end

  context 'when not logged in' do
    it 'can see /camps/:id/message_board' do
      visit message_board_camp_path(@c)
      page.should have_content(@notice.title)
    end
  end
    
  context 'when logged in user' do
    it 'cannot access /notices/new' do
      sign_in_as(@u)
      visit new_notice_path
      assert_unauthorised
    end
  end

  context 'when logged in organiser' do
    before do
      sign_in_as(@organiser)
    end

    context 'when new notice' do
      it "should not create a notice without valid attrs" do
        skip
        visit new_notice_path
        page.should have_content('Create a new notice')
      
        page.click_button 'Create Notice'
        
        current_path.should == new_notice_path
        page.should have_content "can't be blank"
      end
      
      it 'creates and sets current_user as owner' do
        skip
        visit new_notice_path
        
        attrs = { 
          :title => 'Welcome',
          :content => 'Lorem ipsum',
        }
      
        attrs.each do |attr, value|
          fill_in attr.to_s.humanize, :with => value
        end
      
        page.click_button 'Create Notice'
      
        current_path.should == notices_path
        page.should have_content('Welcome')

        # check flash
        @c.notices.count.should == 2
        Notice.last.user == @organiser
      end
    end
    
    context 'with existing notice' do
      it "can edit" do
        skip
        visit notices_path
        page.should have_content('All notices')
        find("li#notice_#{@notice_.id}").click_link('Edit')
        
        fill_in 'Title', :with => 'new title'
        page.click_button 'Update Notice'
        
        current_path.should == notices_path
        page.should have_content('new title')
      end
      
      it "can delete notice" do
        skip
        visit notices_path
        find("li#notice_#{@notice_.id}").click_link('Delete')
        Notice.count == 1
      end
    end
  end
end
