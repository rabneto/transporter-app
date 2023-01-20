class Deadline < ApplicationRecord
  belongs_to :transport_mode
  validates :min_range, :max_range, :hours, presence: true
  validate :min_range_not_higher_than_max_range, :min_range_not_lower_than_tm_min_range, :max_range_not_higher_than_tm_max_range

  def min_range_not_higher_than_max_range
    if self.min_range.present? && self.max_range.present?
      if self.min_range >= self.max_range
        self.errors.add(:min_range, " Não pode ser maior ou igual a Distância Máxima")
      end
    end
  end

  def min_range_not_lower_than_tm_min_range
    if self.min_range.present? && self.transport_mode.min_range.present?
      if self.min_range < self.transport_mode.min_range
        self.errors.add(:min_range, " Não pode ser menor que a Distância Mínima da Modalidade de Transporte")
      end
    end
  end

  def max_range_not_higher_than_tm_max_range
    if self.max_range.present? && self.transport_mode.max_range.present?
      if self.max_range > self.transport_mode.max_range
        self.errors.add(:min_range, " Não pode ser maior que a Distância Máxima da Modalidade de Transporte")
      end
    end
  end

end
