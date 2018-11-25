RSpec.shared_examples_for "timeboxed" do
  it { should belong_to :user }
  it { should belong_to :venue }
  it { should belong_to :camp }

  describe 'validations' do
    it { should validate_presence_of :start_at }
    it { should validate_presence_of :end_at }
    it { should validate_presence_of :user }
    it { should validate_presence_of :venue }
    it { should validate_presence_of :camp }

    it 'ensures end_at > start_at' do
      subject.assign_attributes(start_at: 1.day.ago, end_at: 1.day.from_now)
      expect(subject).to be_valid

      subject.assign_attributes(start_at: 1.day.from_now, end_at: 1.day.ago)
      expect(subject).to be_invalid
      expect(subject).to have(1).errors_on(:start_at)
    end
  end
end
