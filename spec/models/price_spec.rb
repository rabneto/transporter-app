require 'rails_helper'

RSpec.describe Price, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when min_weight is empty' do
        tm = TransportMode.create!(name: 'Express',
                                   min_range: 100,
                                   max_range: 300,
                                   min_weight: 1,
                                   max_weight: 50,
                                   tax: 200)
        p = Price.new(min_weight: '', max_weight: 10, km_price: 80, transport_mode: tm)
        result = p.valid?
        expect(result).to eq false
      end
      it 'false when min_weight is lower than tm.min_weight' do
        tm = TransportMode.create!(name: 'Express',
                                   min_range: 100,
                                   max_range: 300,
                                   min_weight: 10,
                                   max_weight: 50,
                                   tax: 200)
        p = Price.new(min_weight: 5, max_weight: 10, km_price: 80, transport_mode: tm)
        result = p.valid?
        expect(result).to eq false
      end
      it 'false when max_weight is empty' do
        tm = TransportMode.create!(name: 'Express',
                                   min_range: 100,
                                   max_range: 300,
                                   min_weight: 1,
                                   max_weight: 50,
                                   tax: 200)
        p = Price.new(min_weight: 5, max_weight: '', km_price: 80, transport_mode: tm)
        result = p.valid?
        expect(result).to eq false
      end
      it 'false when max_weight is higher than tm.max_weight' do
        tm = TransportMode.create!(name: 'Express',
                                   min_range: 100,
                                   max_range: 300,
                                   min_weight: 1,
                                   max_weight: 50,
                                   tax: 200)
        p = Price.new(min_weight: 5, max_weight: 51, km_price: 80, transport_mode: tm)
        result = p.valid?
        expect(result).to eq false
      end
      it 'false when km_price is empty' do
        tm = TransportMode.create!(name: 'Express',
                                   min_range: 100,
                                   max_range: 300,
                                   min_weight: 1,
                                   max_weight: 50,
                                   tax: 200)
        p = Price.new(min_weight: 5, max_weight: 40, km_price: '', transport_mode: tm)
        result = p.valid?
        expect(result).to eq false
      end
    end
  end
end
