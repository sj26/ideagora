require 'spec_helper'

describe Talk do
  subject(:talk) { Talk.make }

  it_should_behave_like "timeboxed"
end
