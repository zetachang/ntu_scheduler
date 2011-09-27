require 'spec_helper'

describe Day do
  it { should have_many(:lessons) }
  it { should belong_to(:schedule) }
  it { should validate_presence_of(:schedule_id) }
end
