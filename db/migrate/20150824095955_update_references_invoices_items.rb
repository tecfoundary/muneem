class UpdateReferencesInvoicesItems < ActiveRecord::Migration
  def change
    remove_column :items, :reference
    add_column :items, :reference, :integer, null: false, default: 0
    
    change_table :invoices do |t|
      t.belongs_to :order, index: true, foreign_key: true
    end
  end
end
