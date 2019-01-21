require 'rails_helper'

RSpec.describe Language, type: :model do
  it { should validate_presence_of :abbr }
  it { should validate_uniqueness_of :abbr }
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
  it { should have_many :feedbacks }
end
