require 'spec_helper'

describe Talk do
  it_should_behave_like "timeboxed", Talk.make
end
