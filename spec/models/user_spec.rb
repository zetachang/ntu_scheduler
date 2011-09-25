require 'spec_helper'

describe User do
  subject { Factory(:user) }
  it { should have_one(:schedule) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:student_id) }
  it { should validate_presence_of(:facebook_uid) }
  it { should validate_uniqueness_of(:facebook_uid) }
  it { subject.schedule.should_not be_nil }
end
