class Item < ActiveRecord::Base

  # Relation
  belongs_to :account
  belongs_to :invoice

  # Fields
  # field :product,     type: String
  # field :reference,   type: String
  # field :description, type: String
  # field :quantity,    type: Float, default: 0
  # field :cost,        type: Float, default: 0.0
  # field :discount,    type: Integer, default: 0

  # Validations
  validates_presence_of :product, :description, :quantity, :cost
  validates_numericality_of :discount,
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 100,
    only_integer: true

  def total
    (self.quantity*self.cost)*(1-(self.discount/100))
  end

  def paid?
    total == 0
  end
end
