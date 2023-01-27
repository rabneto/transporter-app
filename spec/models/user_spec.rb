require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when name is empty' do
        u = User.new(name: '')
        result = u.valid?
        expect(result).to eq false
      end
    end
  end
end
