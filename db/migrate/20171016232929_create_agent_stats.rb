class CreateAgentStats < ActiveRecord::Migration[5.1]
  def change
    create_table :agent_stats do |t|
      t.references  :agent,      null: false
      t.integer     :total,         null: false, default: 0  # the total number of properties an agent has sold
      t.integer     :buyers,        null: false, default: 0  # the number of buyers they represented and sold
      t.integer     :sellers,       null: false, default: 0  # the number of sellers they represented and sold
      t.integer     :sfh,           null: false, default: 0  # the number of single family homes sold
      t.integer     :condo,         null: false, default: 0  # the number of condos sold
      t.integer     :townhome,      null: false, default: 0  # the number of townhomes sold
      t.integer     :mobile,        null: false, default: 0  # the number of mobile homes sold
      t.integer     :land,          null: false, default: 0  # the number of land homes sold
      t.integer     "0_to_150k",    null: false, default: 0  # the number of homes sold between 0 and $150k
      t.integer     "150k_to_300k", null: false, default: 0  # the number of homes sold between $150k and $300k
      t.integer     "300k_to_500k", null: false, default: 0  # etc.
      t.integer     "500k_to_750k", null: false, default: 0
      t.integer     "750k_to_1m",   null: false, default: 0
      t.integer     "1m_plus",      null: false, default: 0
      t.timestamps
    end
  end
end
