require 'spec_helper'

describe WelcomeController do
  describe '#index' do
    let(:camp) { Camp.current || Camp.make! }
        
    it "collects talks and groups them by venue" do
      skip 'changed in rcx version'
      library = Venue.make! :camp => camp
      Talk.make! :camp => camp, :venue => library, :start_at => Time.zone.now
      Talk.make! :camp => camp, :venue => library, :start_at => 1.minute.from_now
      
      study = Venue.make! :camp => camp
      Talk.make! :camp => camp, :venue => study, :start_at => Time.zone.now
      Talk.make! :camp => camp, :venue => study, :start_at => 2.days.from_now
      
      get :index
      
      # puts assigns[:todays_talks_by_venue_id].inspect
      
      # assigns[:todays_talks_by_venue_id][library.id].length.should == 2
      # assigns[:todays_talks_by_venue_id][study.id].length.should   == 1
    end
  end
end
