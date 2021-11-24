class CreateUpdateCostLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :update_cost_logs do |t|
      t.string :context
      t.string :params
      t.timestamps
    end
  end
end
