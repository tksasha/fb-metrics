class CreateMetrics < ActiveRecord::Migration[5.1]
  def change
    create_table :metrics do |t|
      t.references :page
      t.integer :shares_count , default: 0
    end
  end
end
