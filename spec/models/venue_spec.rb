require 'spec_helper'

describe Venue do
  subject(:venue) { build(:venue) }

  it { should validate_presence_of(:name) }
  it { should belong_to(:camp) }
end
