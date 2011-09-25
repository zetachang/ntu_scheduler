require 'spec_helper'

describe ScheduleSet do
  subject { Factory(:schedule_set) }
  it { should have_many(:schedule) }
  it { should validate_uniqueness_of(:permalink_id) }
end
