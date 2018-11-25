require 'spec_helper'

describe Camp do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:current) }
  it { should validate_presence_of(:time_zone) }
  it { should validate_presence_of(:start_at) }
  it { should validate_presence_of(:end_at) }

  it { should have_many(:attendees) }
  it { should have_many(:notices) }
  it { should have_many(:talks) }
  it { should have_many(:venues) }

  describe '#talks_by_time_and_venue_for_day(day)' do
    subject(:camp) { create(:camp) }
    let!(:venue) { create(:venue, camp: camp) }
    let!(:user) { create(:user) }
    let!(:attendance) { create(:attendance, camp: camp, user: user) }
    let!(:talk) { create(:talk, camp: camp, user: user, venue: venue, start_at: camp.start_at + 1.day + 6.hours) }

    it 'returns an OrderedHash in the form of { :time => { :venue => :talk } }' do
      talks = camp.talks_by_time_and_venue_for_day(camp.start_at.to_date + 1.day)

      expect(talks).to be_a_kind_of ActiveSupport::OrderedHash
      expect(talks.keys.first).to be_a_kind_of Time

      talks_for_time = talks[talks.keys.first]
      expect(talks_for_time.keys.first).to be_a_kind_of Venue

      talk = talks_for_time[talks_for_time.keys.first]
      expect(talk).to be_a_kind_of Talk
    end
  end
end
