names = [
  "Donald Miller",
  "Rhonda Hunter",
  "Ethel Valentine",
  "Brenda Bowman",
  "Robert Jackson",
  "Linda Forster",
  "Manuel Holsinger",
  "Philip Gordon",
  "Alberta Campbell",
  "Juan Marinelli",
  "Robert New",
  "Cory Davis",
  "Ruth Larsen",
  "Mary Romero",
  "George Ray",
  "Aracely Maas",
  "Cheryl Prevost",
  "Larry Cooper",
  "Edward Johnson",
  "Anna Maloney",
  "Luis Thompson",
  "Patricia Chancellor",
  "Blanche Dennett",
  "William Smith",
  "Michael Zinn"
]

brokerages = [
  "CB",
  "C21",
  "BHG",
  "S",
  "PR",
  "CR",
  "R/M",
  "KWR",
  "ERA",
  "TCG"
]


names.each do |name|
  a = Agent.create(name: name, brokerage: brokerages.sample)

  total     = rand(40..150)
  buyers    = rand(13..total)
  sellers   = total - buyers
  sfh       = rand(0..(total * 0.7).ceil)
  remaining = total - sfh
  condo     = rand(0..(remaining * 0.8).ceil)
  remaining -= condo
  townhome = rand(0..(remaining * 0.8).ceil)
  remaining -= townhome
  mobile    = rand(0..(remaining * 0.2).ceil)
  remaining -= mobile
  land      = remaining

  buckets = [0, 0, 0, 0, 0, 0]

  r = (rand * 100).ceil

  if r < 33
    remaining  = total
    buckets[0] = rand(0..remaining)
    buckets[1] = total - buckets[0]
  elsif r >= 33 && r < 80
    remaining = total
    (0..4).each do |i|
      buckets[i] = rand((remaining * 0.16).ceil..(remaining * 0.4).ceil)
      remaining -= buckets[i]
    end
    buckets[5] = remaining
  else
    remaining  = total
    buckets[3] = rand(0..(remaining * 0.3)).ceil
    remaining  -= buckets[3]
    buckets[4] = rand(0..remaining).ceil
    remaining  -= buckets[4]
    buckets[5] = total - remaining
  end

  AgentStat.create(
    agent_id:   a.id,
    total:      total,
    buyers:     buyers,
    sellers:    sellers,
    sfh:        sfh,
    condo:      condo,
    townhome:  townhome,
    mobile:     mobile,
    land:       land,
    "0_to_150k"     => buckets[0],
    "150k_to_300k"  => buckets[1],
    "300k_to_500k"  => buckets[2],
    "500k_to_750k"  => buckets[3],
    "750k_to_1m"    => buckets[4],
    "1m_plus"       => buckets[5]
  )

end


