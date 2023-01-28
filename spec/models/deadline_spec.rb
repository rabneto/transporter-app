require 'rails_helper'

RSpec.describe Deadline, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when min_range is empty' do
        tm = TransportMode.create!(name: 'Express',
                                   min_range: 100,
                                   max_range: 300,
                                   min_weight: 1,
                                   max_weight: 50,
                                   tax: 200)
        v = Deadline.new(min_range: '', max_range: 150, hours: 24, transport_mode: tm)
        result = v.valid?
        expect(result).to eq false
      end
      it 'false when min_range is lower than tm.min_range' do
        tm = TransportMode.create!(name: 'Express',
                                   min_range: 100,
                                   max_range: 300,
                                   min_weight: 1,
                                   max_weight: 50,
                                   tax: 200)
        v = Deadline.new(min_range: 90, max_range: 150, hours: 24, transport_mode: tm)
        result = v.valid?
        expect(result).to eq false
      end
      it 'false when max_range is empty' do
        tm = TransportMode.create!(name: 'Express',
                                   min_range: 100,
                                   max_range: 300,
                                   min_weight: 1,
                                   max_weight: 50,
                                   tax: 200)
        v = Deadline.new(min_range: 101, max_range: '', hours: 24, transport_mode: tm)
        result = v.valid?
        expect(result).to eq false
      end
      it 'false when max_range is higher than tm.max_range' do
        tm = TransportMode.create!(name: 'Express',
                                   min_range: 100,
                                   max_range: 300,
                                   min_weight: 1,
                                   max_weight: 50,
                                   tax: 200)
        v = Deadline.new(min_range: 101, max_range: 301, hours: 24, transport_mode: tm)
        result = v.valid?
        expect(result).to eq false
      end
      it 'false when min_range is higher than max_range' do
        tm = TransportMode.create!(name: 'Express',
                                   min_range: 100,
                                   max_range: 300,
                                   min_weight: 1,
                                   max_weight: 50,
                                   tax: 200)
        v = Deadline.new(min_range: 200, max_range: 100, hours: 24, transport_mode: tm)
        result = v.valid?
        expect(result).to eq false
      end
      it 'false when hours is empty' do
        tm = TransportMode.create!(name: 'Express',
                                   min_range: 100,
                                   max_range: 300,
                                   min_weight: 1,
                                   max_weight: 50,
                                   tax: 200)
        v = Deadline.new(min_range: 101, max_range: 150, hours: '', transport_mode: tm)
        result = v.valid?
        expect(result).to eq false
      end
    end
  end
end
