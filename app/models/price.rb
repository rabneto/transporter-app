class Price < ApplicationRecord
  belongs_to :transport_mode
  validates :min_weight, :max_weight, :km_price, presence: true
  validate :min_weight_not_higher_than_max_weight, :min_weight_not_lower_than_tm_min_weight, :max_weight_not_higher_than_tm_max_weight

  scope :weight_between, ->(product_weight) {
    where("min_weight <= ? AND max_weight >= ?", product_weight, product_weight)
  }

  def min_weight_not_higher_than_max_weight
    if self.min_weight.present? && self.max_weight.present?
      if self.min_weight >= self.max_weight
        self.errors.add(:min_weight, " Não pode ser maior ou igual ao Peso Máximo")
      end
    end
  end

  def min_weight_not_lower_than_tm_min_weight
    if self.min_weight.present? && self.transport_mode.min_weight.present?
      if self.min_weight < self.transport_mode.min_weight
        self.errors.add(:min_weight, " Não pode ser menor que o Peso Mínimo da Modalidade de Transporte")
      end
    end
  end

  def max_weight_not_higher_than_tm_max_weight
    if self.max_weight.present? && self.transport_mode.max_weight.present?
      if self.max_weight > self.transport_mode.max_weight
        self.errors.add(:max_weight, " Não pode ser maior que o Peso Máximo da Modalidade de Transporte")
      end
    end
  end
  
end
