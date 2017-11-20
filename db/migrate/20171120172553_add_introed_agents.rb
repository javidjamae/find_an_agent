class AddIntroedAgents < ActiveRecord::Migration[5.1]
  def change
    add_column :agent_searches, :introed_agent_ids, :string
  end
end
