require 'spec_helper'

RSpec.describe Event do
  subject(:event) { Event.make }

  it_should_behave_like "timeboxed"
end
