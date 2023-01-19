class Category < ApplicationRecord
  enum status: { enable: 1, disable: 0 }
  validates :name, presence: true
  has_many :vehicles
end
