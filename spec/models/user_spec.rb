require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'association' do
    it { should have_many(:measurements) }

    it { should have_many(:measures) }
  end

  describe 'validation' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:age) }
    it { should validate_presence_of(:gender) }
    it { should validate_presence_of(:height) }
    it { should validate_presence_of(:weight) }
    it { should validate_presence_of(:activity) }
  end
end
