# README

Setup:

git pull

cd find_an_agent/ruby

bundle

rake db:create

rake db:migrate

rake db:seed

rails s

http://localhost:3000


Full Stack Applicants:

  1.) Fill in the AgentSearch#find_agent_matches! method so it returns a better result set
  2.) Turn the price range radio buttons into checkboxes and use them in the AgentSearch#find_agent_matches! method
  3.) 

Frontend Candidates:

  1.) Turn the price range radio buttons into checkboxes and make sure the search still works
  2.) Turn the 3 questions into a "wizard" where you can go forward/back through the question without reloading the page.
  3.) Add a 100px by 100px circle profile picture to the results page for each agent with an avatar from https://randomuser.me (https://randomuser.me/documentation#howto)

Backend Candidates:

Growth Candidates:

  Choose 2 or 3 tasks from the list below and implement them.

  1.) The app is ugly. Add some light styling to make it more appealing to use.
  2.) Add a 100px by 100px circle profile picture to the results page for each agent with an avatar from https://randomuser.me (https://randomuser.me/documentation#howto).
  3.) Make the agent result "card" responsive so that it looks better on a large phone screen.
  4.) Fill in the AgentSearch#find_agent_matches! method so it returns a result set that matches the inputs
  5.) Turn the price range radio buttons into checkboxes, save the new input to the db, and make sure the search still works
  6.) Format the layout of the agent card so that it is more understandable
  7.) Add filtering (if you didn't do 4 above) or sorting (if you did do 4 above) to the agent result page that re-orders the agents (maybe the following options buyers (sort/filter by agents that represented more buyers), sellers (reverse of buyers), SFH (agents that do mostly sfh first), Condo (agents that do mostly condos first), luxury (agents that do a lot of $1m+ transactions)

Data Candidates:
