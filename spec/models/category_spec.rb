require 'rails_helper'

RSpec.describe Category, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when name is empty' do
        tm = Category.new(name: '')
        result = tm.valid?
        expect(result).to eq false
      end
    end
  end
end
