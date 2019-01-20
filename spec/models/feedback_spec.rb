require 'rails_helper'

RSpec.describe Feedback, type: :model do
  it { should validate_presence_of :message }
end
