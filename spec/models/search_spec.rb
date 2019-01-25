require 'rails_helper'

RSpec.describe Search, type: :model do
  it { should belong_to :language }
  it { should belong_to :tone }
  it { should validate_presence_of :resource }
end
