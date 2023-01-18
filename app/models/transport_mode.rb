class TransportMode < ApplicationRecord
  enum active: { enable: 1, disable: 0 }
  validates :name, :min_range, :max_range, :min_weight, :max_weight, :tax, presence: true
  validate :min_range_not_higher_than_max_range, :min_weight_not_higher_than_max_weight

  def min_range_not_higher_than_max_range
    if self.min_range.present? && self.max_range.present?
      if self.min_range >= self.max_range
        self.errors.add(:min_range, " Não pode ser maior ou igual a Distância Máxima")
      end
    end
  end

  def min_weight_not_higher_than_max_weight
    if self.min_weight.present? && self.max_weight.present?
      if self.min_weight >= self.max_weight
        self.errors.add(:min_weight, " Não pode ser maior ou igual ao Peso Máximo")
      end
    end
  end

end
