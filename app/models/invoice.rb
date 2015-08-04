class Invoice < ActiveRecord::Base

  # Relations
  belongs_to :account
  belongs_to :client
  # has_one :order
  has_many :items

  accepts_nested_attributes_for :items

  # Validations
  validates :due_at, presence: true

  # Scope
  default_scope -> { order(created_at: :desc) }

  # Public
  def to_s
    "##{number.to_s}"
  end

  def status
    if payment_at.nil?
      if due_at < Date.today
        return :overdue
      else
        return :unpaid
      end
    else
      return :paid
    end
  end

  def sub_total
    items.map(&:total).sum
  end

  def tax
    tax_rate*sub_total
  end

  def total
    (shipping || 0)+sub_total
  end

  def number
    id
  end

  def item_references
    items.map(&:reference)
  end
end
