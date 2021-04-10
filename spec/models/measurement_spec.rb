require 'rails_helper'

RSpec.describe Measurement, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }

    it { should belong_to(:measure) }
  end

  describe 'validation' do
    it { should validate_presence_of(:value) }
  end
end
