require 'rails_helper'

RSpec.describe Measure, type: :model do
  describe 'association' do
    it { should have_many(:measurements) }
  end
end
