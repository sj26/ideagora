require 'spec_helper'

describe Venue do
  subject(:venue) { Venue.make }

  it { should validate_presence_of(:name) }
  it { should belong_to(:camp) }
end
