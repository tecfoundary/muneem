class Item
  include Mongoid::Document

  #
  # Relation
  #
  embedded_in :invoice

  #
  # Fields
  #

  field :product,     type: String
  field :reference,   type: String
  field :description, type: String
  field :quantity,    type: Float
  field :cost,        type: Float
  field :paid,        type: Boolean, default: false

  def total
    self.paid ? 0 : self.quantity*self.cost
  end
end
