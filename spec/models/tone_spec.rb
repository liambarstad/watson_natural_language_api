require 'rails_helper'

RSpec.describe Tone, type: :model do
  it { should validate_presence_of :emotion }
  it { should validate_uniqueness_of :emotion }
  it { should have_many :feedbacks }
  it { should have_many :searches }
end
