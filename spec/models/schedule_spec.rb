require 'spec_helper'

describe Schedule do
  it { should have_many(:days) }
  it { should belong_to(:user) }
end
