require 'spec_helper'

describe User do
  subject { Factory(:user) }
  it { should have_one(:schedule) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:student_id) }
  it { should validate_presence_of(:facebook_uid) }
  it { should validate_uniqueness_of(:facebook_uid) }
  its(:schedule) { should_not be_nil }

  it "should convert student ID to lowercase" do
    user1 = Factory(:user, :student_id => "B00902109", :facebook_uid => 1)
    user2 = Factory(:user, :student_id => "b00902109", :facebook_uid => 2)
    user1.student_id.should == "b00902109"
    user2.student_id.should == "b00902109"
  end
end
