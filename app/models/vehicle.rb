class Vehicle < ApplicationRecord
  enum status: { enable: 1, disable: 0 }
  belongs_to :category
  validates :plate, :brand, :model, :year, :max_weight, presence: true
end
