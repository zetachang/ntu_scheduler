require 'spec_helper'

describe Schedule do
  subject { Factory(:schedule) }
  it { should have_many(:days) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:user_id) }
  it { subject.days.size.should == 6 }
end
