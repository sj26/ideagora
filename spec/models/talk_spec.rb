require 'spec_helper'

describe Talk do
  subject(:talk) { build(:talk) }

  it_should_behave_like "timeboxed"
end
