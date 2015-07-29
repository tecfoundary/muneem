class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|

      t.integer   :invoice_number,   null: false
      t.date      :due_at,           null: false
      t.float     :tax_rate,         null: false
      t.float     :shipping
      t.date      :payment_at
      t.string    :payment_reference

      t.timestamps null: false

      t.belongs_to :account
      t.belongs_to :client
    end
  end
end
