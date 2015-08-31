class Item < ActiveRecord::Base

  # Relation
  belongs_to :account
  belongs_to :invoice

  # Validations
  validates_presence_of :product, :description, :quantity, :cost
  validates_numericality_of :discount,
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 100,
    only_integer: true

  def total
    (self.quantity*self.cost)*(1-(self.discount/100))
  end

end
