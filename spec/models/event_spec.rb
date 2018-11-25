require 'spec_helper'

RSpec.describe Event do
  subject(:event) { build(:event) }

  it_should_behave_like "timeboxed"
end
