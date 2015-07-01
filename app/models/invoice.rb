class Invoice
  include Mongoid::Document
  include Mongoid::Timestamps

  #
  # Relations
  #
  belongs_to :account
  belongs_to :client
  # has_one :order
  embeds_many :items

  accepts_nested_attributes_for :items

  #
  # Callbacks
  #
  before_create :increment_invoice_number


  field :invoice_number,  type: Integer
  field :due_at,          type: DateTime
  field :tax_rate,        type: Float, default: 0.1
  field :shipping,        type: Float

  field :payment_at,      type: DateTime
  field :payment_ref,     type: String

  default_scope -> { desc(:created_at) }

  def to_s
    "##{number.to_s}"
  end

  def status
    if self.payment_at.nil?
      if self.due_at < Date.today
        return :overdue
      else
        return :unpaid
      end
    else
      return :paid
    end
  end

  def sub_total
    self.items.map(&:total).sum
  end

  def tax
    self.tax_rate*sub_total
  end

  def total
    (self.shipping || 0)+sub_total
  end

  def number
    self.invoice_number
  end

  def item_references
    self.items.map(&:reference)
  end

  private

  def increment_invoice_number
    self.invoice_number = (Invoice.max(:invoice_number) || 0) + 1
  end

end
