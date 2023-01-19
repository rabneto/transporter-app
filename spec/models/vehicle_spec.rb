require 'rails_helper'

RSpec.describe TransportMode, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when category is empty' do
        v = Vehicle.new(plate: 'EUW-2389', brand: 'FIAT', model: 'Ducato', year: 2020, max_weight: 2000, category: nil)
        result = v.valid?
        expect(result).to eq false
      end
      it 'false when plate is empty' do
        category = Category.create!(name: 'Carros')
        v = Vehicle.new(plate: '', brand: 'FIAT', model: 'Ducato', year: 2020, max_weight: 2000, category: category)
        result = v.valid?
        expect(result).to eq false
      end
      it 'false when brand is empty' do
        category = Category.create!(name: 'Carros')
        v = Vehicle.new(plate: 'EUW-2389', brand: '', model: 'Ducato', year: 2020, max_weight: 2000, category: category)
        result = v.valid?
        expect(result).to eq false
      end
      it 'false when model is empty' do
        category = Category.create!(name: 'Carros')
        v = Vehicle.new(plate: 'EUW-2389', brand: 'FIAT', model: '', year: 2020, max_weight: 2000, category: category)
        result = v.valid?
        expect(result).to eq false
      end
      it 'false when year is empty' do
        category = Category.create!(name: 'Carros')
        v = Vehicle.new(plate: 'EUW-2389', brand: 'FIAT', model: 'Ducato', year: '', max_weight: 2000, category: category)
        result = v.valid?
        expect(result).to eq false
      end
      it 'false when max_weight is empty' do
        category = Category.create!(name: 'Carros')
        v = Vehicle.new(plate: 'EUW-2389', brand: 'FIAT', model: 'Ducato', year: 2020, max_weight: '', category: category)
        result = v.valid?
        expect(result).to eq false
      end
    end

  end
end