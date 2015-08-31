class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.float :amount, null: false
      t.string :reference
      t.datetime :at, null: false

      t.timestamps null: false

      t.belongs_to :account, index: true, foreign_key: true, null: false
      t.belongs_to :invoice, index: true, foreign_key: true, null: false
    end
  end
end
