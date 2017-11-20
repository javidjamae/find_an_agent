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
    stats = AgentStat.all
    normalized_stats = get_normalized_agent_stats( stats )
    weighted_stats = weight_normalized_stats( normalized_stats )
    sorted_stats = weighted_stats.sort_by { |key, value| value[:total] }.reverse
    self.agent_ids = sorted_stats.map { |s| s[0] }
  end

  def weight_normalized_stats( normalized_agent_stats )
    weights = calculate_weights
    keys = [
      :buyers,
      :sellers,
      :sfh,
      :condo,
      :townhome,
      :mobile,
      :land,
      "0_to_150k",
      "150k_to_300k",
      "300k_to_500k",
      "500k_to_750k",
      "750k_to_1m",
      "1m_plus",
    ]

    normalized_agent_stats.each do | stat |
      total = 0
      keys.each do |key|
        next if stat[1][key].nan?
        total += weights[ key ] * stat[1][ key ]
      end
      stat[1][:total] = total
    end

    normalized_agent_stats
  end

  def calculate_weights
    weights = {
      buyers: 1,
      sellers: 1,
      sfh: 1,
      condo: 1,
      townhome: 1,
      mobile: 1,
      land: 1,
      "0_to_150k": 1,
      "150k_to_300k": 1,
      "300k_to_500k": 1,
      "500k_to_750k": 1,
      "750k_to_1m": 1,
      "1m_plus": 1,
    }

    # Buyers probably want people who have experience helping buyers, and same for sellers
    if ( self.txn_side == 'buying' )
      weights[:buyers] = 3
    elsif ( self.txn_side == 'selling' )
      weights[:sellers] = 3
    end

    # Sellers probably want people who have experience selling their property type. Buyers might be more flexible
    if ( self.txn_side == 'buying' )
      weights[ self.prop_type ] = 2
    elsif ( self.txn_side == 'selling' )
      weights[ self.prop_type ] = 6
    end

    # Buyers/Sellers at high price points are really picky about who they work with
    # Agents who work at higher price points really don't like working at low price points
    #
    if ( self.price_range == '1m_plus' )
      weights[ self.price_range ] = 10
    elsif ( self.price_range == '750k_to_1m' )
      weights[ self.price_range ] = 7
    elsif ( self.price_range == '500k_to_750k' )
      weights[ self.price_range ] = 3
    end

    weights.with_indifferent_access
  end

  def normalize_for( key, agent_stats, normalized_stats )
    max_val = agent_stats.map(&key.to_sym).max
    min_val = agent_stats.map(&key.to_sym).min

    agent_stats.each do | stat |
      stat_to_update = normalized_stats[ stat.agent_id ]
      stat_to_update[ key ] = ( stat[ key ] - min_val ).to_f / ( max_val - min_val )
    end
  end

  def get_normalized_agent_stats( agent_stats )
    return if agent_stats.nil?

    normalized_stats = {}

    agent_stats.each do | stat |
      normalized_stats[ stat.agent_id ] = {}
    end

    normalize_for( :buyers, agent_stats, normalized_stats )
    normalize_for( :sellers, agent_stats, normalized_stats )

    normalize_for( :sfh, agent_stats, normalized_stats )
    normalize_for( :condo, agent_stats, normalized_stats )
    normalize_for( :townhome, agent_stats, normalized_stats )
    normalize_for( :mobile, agent_stats, normalized_stats )
    normalize_for( :land, agent_stats, normalized_stats )

    normalize_for( "0_to_150k", agent_stats, normalized_stats )
    normalize_for( "150k_to_300k", agent_stats, normalized_stats )
    normalize_for( "300k_to_500k", agent_stats, normalized_stats )
    normalize_for( "500k_to_750k", agent_stats, normalized_stats )
    normalize_for( "750k_to_1m", agent_stats, normalized_stats )
    normalize_for( "1m_plus", agent_stats, normalized_stats )

    normalized_stats
  end

end
