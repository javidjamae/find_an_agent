class CreateAgentSearches < ActiveRecord::Migration[5.1]
  def change
    create_table :agent_searches do |t|
      t.string :txn_side,     null: false  # which side of the transaction, buyer or seller
      t.string :prop_type,    null: false  # what property type, sfh, condo, townhome, mobile, land
      t.string :price_range,  null: false  # what price range 0to150k,150kto300k, etc
      t.string :agent_ids,    null: false  # the list of agent ids that match the search criteria as a comma separated string (if this was postgres we might use an array type or a join table)
      t.timestamps
    end
  end
end
