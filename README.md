# 💻 Project: WorldCup Database 

![Worldcup banner](https://user-images.githubusercontent.com/88495091/209214406-b8edaa34-cc50-4e5b-b5f6-1312d845f3a4.png)


## Project goal: 
Create a Bash script that enters information from World Cup games.csv file into PostgreSQL, then query the database for useful statistics.

Project made as part of the <b> FreeCodeCamp Relational Databases Beta Certificate course </b>


## Creating the database

Dataset:  <a href="https:"> games.csv </a>

Created the database, 'worldcup', and the appropriate tables ('teams' and 'games') on PostgreSQL to visualise the data from games.csv.

Added appropriate constraints (primary keys and foreign keys) required to relate the tables.

Tables:
- 'games' tracks all matches and scores made by both the winner team and the opponent team (using team_id as the identifier).
- 'teams' lists all teams that played in the matches.

View: <a href=""> initial_tables_creation.sql
  </a>

### Relational Database diagram
![worldcup diagram]()

## Automating data insertion and querying with SQL
Created a Bash script that reads the games.csv data and uses SQL query commands to insert the data automatically into the tables previously created.

Took constraints into consideration when creating the Bash script to insert all winner and opponent teams individually into 'teams' and then into 'games' based on the team_id created.

View: <a href=""> insert_data.sh
  </a>
  
Finished by writing a Bash script that utilises SQL to query the database and obtain useful values.

View: <a href=""> queries.sh
  </a>

Database dump (after inserting data): <a href=""> worldcup.sql </a>
