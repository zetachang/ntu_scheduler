require 'spec_helper'

describe Schedule do
  it { should have_many(:days) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:user_id) }
end
