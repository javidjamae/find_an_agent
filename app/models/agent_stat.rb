class AgentStat < ApplicationRecord
  belongs_to :agent

  def pr1
    self.send("0_to_150k")
  end

  def pr2
    self.send("150k_to_300k")
  end

  def pr3
    self.send("300k_to_500k")
  end

  def pr4
    self.send("500k_to_750k")
  end

  def pr5
    self.send("750k_to_1m")
  end

  def pr6
    self.send("1m_plus")
  end

end
