class Vehicle < ApplicationRecord
  enum status: { enable: 1, disable: 0 }
  belongs_to :category
  validates :plate, :brand, :model, :year, :max_weight, presence: true

  scope :weight_between, ->(min_weight, max_weight) {
    where("max_weight >= ? AND max_weight <= ?", min_weight, max_weight)
  }

  scope :active, -> { where(status: enable) }
  
end
