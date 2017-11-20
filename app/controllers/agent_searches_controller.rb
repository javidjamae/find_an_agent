class AgentSearchesController < ApplicationController

  def show
    @search = AgentSearch.find(params[:id])
    agent_ids = @search.agent_ids.gsub(/[\[\]\s]/, '').split(",")
    @agents = Agent.where(id: agent_ids)
    @agents = @agents.sort_by { |agent| agent_ids.index( agent.id.to_s ) }
  end

  def create
    search = AgentSearch.new(params.permit(:txn_side, :prop_type, :price_range))

    if search.txn_side.blank? || search.prop_type.blank? || search.price_range.blank?
      redirect_to(root_path)
      return
    end

    search.find_agent_matches!

    if search.save
      redirect_to agent_search_path(search)
    end

  end

end
