class Price < ApplicationRecord
  belongs_to :transport_mode
  validates :min_weight, :max_weight, :km_price, presence: true
  validate :min_weight_not_higher_than_max_weight

  def min_weight_not_higher_than_max_weight
    if self.min_weight.present? && self.max_weight.present?
      if self.min_weight >= self.max_weight
        self.errors.add(:min_weight, " Não pode ser maior ou igual ao Peso Máximo")
      end
    end
  end
  
end
