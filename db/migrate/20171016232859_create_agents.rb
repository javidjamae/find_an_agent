class CreateAgents < ActiveRecord::Migration[5.1]
  def change
    create_table :agents do |t|
      t.string      :name,       null: false
      t.string      :brokerage,  null: false
      t.timestamps
    end
  end
end
