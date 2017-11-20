require 'rails_helper'

def verify_normalization_for( key )
  stats = [
    AgentStat.new( key => 9, agent_id: 1 ),
    AgentStat.new( key => 11, agent_id: 2 ),
    AgentStat.new( key => 47, agent_id: 3 ),
    AgentStat.new( key => 22, agent_id: 4 ),
    AgentStat.new( key => 7, agent_id: 5 ),
    AgentStat.new( key => 98, agent_id: 6 ),
  ]
  normalized_list = AgentSearch.new.get_normalized_agent_stats( stats )
  expect( normalized_list[1][key] ).to eq( 0.02197802197802198 )
  expect( normalized_list[2][key] ).to eq( 0.04395604395604396 )
  expect( normalized_list[3][key] ).to eq( 0.43956043956043955 )
  expect( normalized_list[4][key] ).to eq( 0.16483516483516483 )
  expect( normalized_list[5][key] ).to eq( 0.0 )
  expect( normalized_list[6][key] ).to eq( 1 )
end

describe AgentSearch do

  describe "calculate_weights" do
    it "nothing set" do
      weights = AgentSearch.new.calculate_weights
      expect( weights ).to match( {
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
      } )
    end

    it "buyer sfh 0_to_150k" do
      search = AgentSearch.new( txn_side: 'buying', prop_type: 'sfh', price_range: '0_to_150k' )
      weights = search.calculate_weights
      expect( weights ).to match( {
        buyers: 3,
        sellers: 1,
        sfh: 2,
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
      } )
    end

    it "seller condo 750k_to_1m" do
      search = AgentSearch.new( txn_side: 'selling', prop_type: 'condo', price_range: '750k_to_1m' )
      weights = search.calculate_weights
      expect( weights ).to match( {
        buyers: 1,
        sellers: 3,
        sfh: 1,
        condo: 6,
        townhome: 1,
        mobile: 1,
        land: 1,
        "0_to_150k": 1,
        "150k_to_300k": 1,
        "300k_to_500k": 1,
        "500k_to_750k": 1,
        "750k_to_1m": 7,
        "1m_plus": 1,
      } )
    end
  end

  describe "get_normalized_agent_stats" do
    it "nil" do
      normalized_list = AgentSearch.new.get_normalized_agent_stats( nil )
      expect( normalized_list ).to eq( nil )
    end
    it "normalizes buyers" do
      verify_normalization_for( :buyers )
    end
    it "normalizes sellers" do
      verify_normalization_for( :sellers )
    end
    it "normalizes sfh" do
      verify_normalization_for( :sfh )
    end
    it "normalizes condo" do
      verify_normalization_for( :condo )
    end
    it "normalizes townhome" do
      verify_normalization_for( :townhome )
    end
    it "normalizes mobile" do
      verify_normalization_for( :mobile )
    end
    it "normalizes land" do
      verify_normalization_for( :land )
    end
    it "normalizes 0_to_150k" do
      verify_normalization_for( "0_to_150k" )
    end
    it "normalizes 150k_to_300k" do
      verify_normalization_for( "150k_to_300k" )
    end
    it "normalizes 300k_to_500k" do
      verify_normalization_for( "300k_to_500k" )
    end
    it "normalizes 500k_to_750k" do
      verify_normalization_for( "500k_to_750k" )
    end
    it "normalizes 750k_to_1m" do
      verify_normalization_for( "750k_to_1m" )
    end
    it "normalizes 1m_plus" do
      verify_normalization_for( "1m_plus" )
    end
    it "normalizes multiple" do
      stats = [
        AgentStat.new( townhome: 821, mobile: 8, land: 9, agent_id: 1 ),
        AgentStat.new( townhome: 2, mobile: 73, land: 11, agent_id: 2 ),
        AgentStat.new( townhome: 18, mobile: 0, land: 22, agent_id: 3 ),
      ]
      normalized_list = AgentSearch.new.get_normalized_agent_stats( stats )
      expect( normalized_list[1][:land] ).to eq( 0 )
      expect( normalized_list[2][:land] ).to eq( 0.15384615384615385 )
      expect( normalized_list[3][:land] ).to eq( 1 )
      expect( normalized_list[1][:mobile] ).to eq( 0.1095890410958904 )
      expect( normalized_list[2][:mobile] ).to eq( 1.0 )
      expect( normalized_list[3][:mobile] ).to eq( 0.0 )
      expect( normalized_list[1][:townhome] ).to eq( 1.0 )
      expect( normalized_list[2][:townhome] ).to eq( 0.0 )
      expect( normalized_list[3][:townhome] ).to eq( 0.019536019536019536 )
    end
  end

  describe "weight_normalized_stats" do
    it "weights" do
      stats = [
        AgentStat.new( buyers: 2, sellers: 0, townhome: 821, mobile: 8, land: 9, agent_id: 1, "0_to_150k": 2, "750k_to_1m": 4 ),
        AgentStat.new( buyers: 5, sellers: 1, townhome: 2, mobile: 73, land: 11, agent_id: 2, "0_to_150k": 1, "750k_to_1m": 22 ),
        AgentStat.new( buyers: 22, sellers: 9, townhome: 18, mobile: 0, land: 22, agent_id: 3, "0_to_150k": 122, "750k_to_1m": 39 ),
      ]
      search = AgentSearch.new( txn_side: 'buying', prop_type: 'sfh', price_range: '0_to_150k' )
      normalized_stats = search.get_normalized_agent_stats( stats )
      weighted_stats = search.weight_normalized_stats( normalized_stats )
      expect( weighted_stats[1][:total] ).to eq( 1.1178535039058077 )
    end
  end

end

