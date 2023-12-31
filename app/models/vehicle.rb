class Vehicle < ApplicationRecord
  enum status: { in_delivery: 2, enable: 1, disable: 0 }
  belongs_to :category
  validates :plate, :brand, :model, :year, :max_weight, presence: true

  scope :weight_between, ->(min_weight, max_weight) {
    where("max_weight >= ? AND max_weight <= ?", min_weight, max_weight)
  }

  scope :limit_weight, ->(weight) {
    where("max_weight >= ?", weight)
  }

  scope :active, -> { where(status: enable) }
  
end
