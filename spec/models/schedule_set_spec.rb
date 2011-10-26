require 'spec_helper'

describe ScheduleSet do
  subject { Factory(:schedule_set) }
  it { should have_many(:schedules).through(:settings) }
  it { should validate_uniqueness_of(:permalink) }
  its(:permalink) {should_not be_nil}
end
