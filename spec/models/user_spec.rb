require 'spec_helper'

describe User do
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should have_many(:projects).dependent(:destroy) }
  it { should have_many(:camps) }
  it { should have_many(:notices) }
  
  it 'has skills tags' do
    user = User.make!
    user.update_attribute(:skill_list, 'rspec, javascript')
    user.skill_list.should include('rspec', 'javascript')
  end

  it 'has interests tags' do
    user = User.make!
    user.update_attribute(:interest_list, 'running, game-dev')
    user.interest_list.should include('running', 'game-dev')
  end
 
  context 'full_name' do
    subject(:user) { User.make!(:first_name => 'elmo', :last_name => nil) }
    specify { user.full_name.should == 'elmo' }
    
    it "should concat first and last name" do
      user.update_attribute(:last_name, 'smith')
      user.full_name.should == 'elmo smith'
    end
  end
  
  context 'organiser' do
    it "should be organiser?" do
      camp = Camp.make!(:current => true)
      user = User.make!
      attendance = Attendance.make!(:camp => camp, :user => user)
      User.organisers.count == 0
      user.should_not be_organiser
      
      attendance.update_attribute(:organiser, true)
      User.organisers.count == 1
      user.should be_organiser
    end
  end
end
