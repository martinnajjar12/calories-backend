require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'association' do
    it { should have_many(:measurements) }

    it { should have_many(:measures) }
  end
end
