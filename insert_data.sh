#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

# Truncate the teams and games tables to be able to test the script (tables data is ereased)

echo $($PSQL "TRUNCATE TABLE teams, games;")

# Loop read the data from games.csv, read all content with a while loop and use the delimiter "," and name the columns which should be read

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
# Get the data for teams table

# Get the winner teams
# Exclude the header row
if [[ $WINNER != "winner" ]]
	then
	# Search the current loop WINNER variable in the teams table team field(use '$WINNER' as a literal to pass the variable to the PSQL command)
	TEAM1_NAME=$($PSQL "SELECT name FROM teams WHERE name='$WINNER'")
	# Check if the $TEAM_NAME1 variable is empty
	if [[ -z $TEAM1_NAME ]]
		then
		# Insert the $WINNER to the teams table name field. The team_id field is populated automatically as it is a SERIAL
		INSERT_TEAM_NAME1=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
		# Check if we got back the INSERT 0 1 message after insertion
		if [[ $INSERT_TEAM_NAME1 == "INSERT 0 1" ]]
			then
				# Write "Team $WINNER inserted to the teams table!" to the console if it is success
				echo Team $WINNER inserted to the teams table!
		fi
	fi
fi

# Get the opposite teams
# Exclude the header row
if [[ $OPPONENT != "opponent" ]]
	then
		# Search the current loop OPPONENT variable in the teams table team field(use '$OPPONENT' as a literal to pass the variable to the PSQL command)
		TEAM2_NAME=$($PSQL "SELECT name FROM teams WHERE name='$OPPONENT'")
		# Check if $TEAM2_NAME variable is empty
		if [[ -z $TEAM2_NAME ]]
			then
				# Insert the $OPPONENT to the teams table name field. The team_id field is populated automatically as it is a SERIAL
				INSERT_TEAM2_NAME=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
				# Check if we got back the INSERT 0 1 message after insertion
				if [[ $INSERT_TEAM2_NAME == 'INSERT 0 1' ]]
				then
					# Write "Team $OPPONENT inserted to the teams table!" to the console if it is success
					echo Team $OPPONENT inserted to the teams table!
				fi
		fi
fi

# Fill data to games table

# Exclude the header text first. Check if the text is year
if [[ $YEAR != "year" ]]
	then
	# Select WINNER_ID from teams table
	WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
	# Select OPPONENT_ID from teams table
	OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
	# Insert a game row to the games table (game_id is SERIAL so it is filled automatically)
	INSERT_GAME=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES('$YEAR', '$ROUND', '$WINNER_ID', '$OPPONENT_ID', '$WINNER_GOALS', '$OPPONENT_GOALS')")
	# Check if we got back the INSERT 0 1 message after insertion 
	if [[ $INSERT_GAME == 'INSERT 0 1' ]]
		then
		# Write Game added: $YEAR $ROUND Winner team: $WINNER_ID Opponent team: $OPPONENT_ID score: $WINNER_GOALS : $OPPONENT_GOALS
		echo Game added: $YEAR $ROUND Winner team: $WINNER_ID Opponent team: $OPPONENT_ID score: $WINNER_GOALS : $OPPONENT_GOALS
		fi
fi

done
