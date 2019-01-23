require 'rails_helper'

RSpec.describe Feedback, type: :model do
  it { should validate_presence_of :message }
  it { should belong_to :user }
  it { should belong_to :language }
  it { should belong_to :tone }
end
