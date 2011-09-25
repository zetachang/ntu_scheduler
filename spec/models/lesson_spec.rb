require 'spec_helper'

describe Lesson do
  it { should belong_to(:day) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:time) }
  it { should validate_presence_of(:day_id) }
end
