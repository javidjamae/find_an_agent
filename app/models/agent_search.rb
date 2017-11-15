class AgentSearch < ApplicationRecord

  ###################################
  #
  #  Who: Full Stack Applicants, Backend Applicants, Data Applicants
  #
  #  Goal:
  #    To find a list of agents that best match the search parameters entered by the user. This
  #    is open to your interpretation. Your job is to think about what might matter to buyers/sellers
  #    and to implement a search function that effeciently finds a list.  See the Potential Considerations
  #    section below for starter ideas.
  #
  #  Reasoning: (please provide some commentary on your search algorithm)
  #
  #  Potential Considerations:
  #    - Buyers probably want people who have experience helping buyers, and same for sellers
  #    - Sellers probably want people who have experience selling their property type. Buyers might be more flexible
  #    - Buyers/Sellers at high price points are really picky about who they work with
  #    - Agents who work at higher price points really don't like working at low price points
  #
  ###################################
  def find_agent_matches!
    self.agent_ids = Agent.all.map(&:id)
  end

end
