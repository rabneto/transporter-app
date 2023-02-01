class Order < ApplicationRecord

  belongs_to :transport_mode, optional: true
  belongs_to :vehicle, optional: true
  enum status: { pendent: 1, in_delivery: 2, delivered: 3 }
  
  before_create :generate_code

  validates :distance,
            :product_id,
            :product_width,
            :product_height,
            :product_depth,
            :product_weight,
            :origin_address,
            :origin_city,
            :origin_uf,
            :sender_name,
            :sender_document,
            :sender_phone,
            :destiny_address,
            :destiny_city,
            :destiny_uf,
            :recipient_name,
            :recipient_document,
            :recipient_phone,
            presence: true
  
  def generate_code
    self.code = SecureRandom.alphanumeric(15).upcase
  end

  #def created_at
  #  self.created_at = created_at.strftime("posted on %b, %m %Y - %H:%M")
  #end

  def pending
    self.created_at = created_at.strftime("posted on %b, %m %Y - %H:%M")
  end

end
