class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|

      t.string    :product,          null: false
      t.string    :reference,        null: false
      t.string    :description,      null: false
      t.integer   :quantity,         default: 0
      t.float     :cost
      t.float     :discount,         default: 0.0

      t.timestamps null: false

      t.belongs_to :account
      t.belongs_to :invoice
    end
  end
end
