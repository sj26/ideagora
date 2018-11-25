require 'spec_helper'

describe User do
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should have_many(:projects).dependent(:destroy) }
  it { should have_many(:camps) }
  it { should have_many(:notices) }
  
  it 'has skills tags' do
    user = create(:user)
    user.update_attribute(:skill_list, 'rspec, javascript')
    expect(user.skill_list).to include('rspec', 'javascript')
  end

  it 'has interests tags' do
    user = create(:user)
    user.update_attribute(:interest_list, 'running, game-dev')
    expect(user.interest_list).to include('running', 'game-dev')
  end
 
  context 'full_name' do
    subject(:user) { create(:user, first_name: 'elmo', last_name: nil) }
    specify { expect(user.full_name).to eql('elmo') }
    
    it "should concat first and last name" do
      user.update_attribute(:last_name, 'smith')
      expect(user.full_name).to eql('elmo smith')
    end
  end
  
  context 'organiser' do
    it "should be organiser?" do
      camp = create(:camp)
      user = create(:user)
      attendance = create(:attendance, camp: camp, user: user)
      User.organisers.count == 0
      expect(user).not_to be_organiser
      
      attendance.update!(organiser: true)
      User.organisers.count == 1
      expect(user).to be_organiser
    end
  end
end
