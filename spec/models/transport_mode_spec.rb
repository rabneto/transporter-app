require 'rails_helper'

RSpec.describe TransportMode, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when name is empty' do
        tm = TransportMode.new(name: '', min_range: 10, max_range: 20,
                              min_weight: 60, max_weight: 100, tax: 80)
        result = tm.valid?
        expect(result).to eq false
      end
      it 'false when min_range is empty' do
        tm = TransportMode.new(name: 'Rodoviário', min_range: '', max_range: 20,
                              min_weight: 60, max_weight: 100, tax: 80)
        result = tm.valid?
        expect(result).to eq false
      end
      it 'false when max_range is empty' do
        tm = TransportMode.new(name: 'Rodoviário', min_range: 10, max_range: '',
                              min_weight: 60, max_weight: 100, tax: 80)
        result = tm.valid?
        expect(result).to eq false
      end
      it 'false when min_weight is empty' do
        tm = TransportMode.new(name: 'Rodoviário', min_range: 10, max_range: 20,
                              min_weight: '', max_weight: 100, tax: 80)
        result = tm.valid?
        expect(result).to eq false
      end
      it 'false when max_weight is empty' do
        tm = TransportMode.new(name: 'Rodoviário', min_range: 10, max_range: 20,
                              min_weight: 60, max_weight: '', tax: 80)
        result = tm.valid?
        expect(result).to eq false
      end
      it 'false when tax is empty' do
        tm = TransportMode.new(name: 'Rodoviário', min_range: 10, max_range: 20,
                              min_weight: 60, max_weight: 100, tax: '')
        result = tm.valid?
        expect(result).to eq false
      end
    end

  end
end
