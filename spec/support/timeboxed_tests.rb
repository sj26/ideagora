shared_examples_for "timeboxed" do |thing|

  it { should belong_to :user }
  it { should belong_to :venue }
  it { should belong_to :camp }

  describe 'validations' do
    before { thing }
    it { should validate_presence_of :start_at }
    it { should validate_presence_of :end_at }
    it { should validate_presence_of :user }
    it { should validate_presence_of :venue }
    it { should validate_presence_of :camp }

    it 'ensures end_at > start_at' do
      thing.update_attributes :start_at => 1.day.ago, :end_at => 1.day.from_now
      thing.should be_valid
      thing.update_attributes :start_at => 1.day.from_now, :end_at => 1.day.ago
      thing.should be_invalid
      thing.should have(1).errors_on(:start_at)
    end
  end
end
