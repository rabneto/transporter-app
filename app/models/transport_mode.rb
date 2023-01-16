class TransportMode < ApplicationRecord
  enum active: { enable: 1, disable: 0 }
  validates :name, :min_range, :max_range, :min_weight, :max_weight, :tax, presence: true
end
