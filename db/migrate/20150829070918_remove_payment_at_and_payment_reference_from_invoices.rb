class RemovePaymentAtAndPaymentReferenceFromInvoices < ActiveRecord::Migration
  def change
    remove_column :invoices, :payment_at, :date
    remove_column :invoices, :payment_reference, :string
  end
end
