class Payment < ActiveRecord::Base

  # Relations
  belongs_to :account
  belongs_to :invoice

  # Validations
  validates :amount, :at, presence: true

end
