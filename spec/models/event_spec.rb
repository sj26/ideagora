require 'spec_helper'

describe Event do
  it_should_behave_like "timeboxed", Event.make
end
