<--In 1.sql, write a SQL query to find the average player salary by year.
--     Sort by year in descending order.
--     Round the salary to two decimal places and call the column “average salary”.
--     Your query should return a table with two columns, one for year and one for average salary.
SELECT year, ROUND(AVG(salary),2) FROM salaries GROUP BY year ORDER BY year DESC;
<--In 2.sql,write a SQL query to find Cal Ripken Jr.’s salary history.
    -- Sort by year in descending order.
    -- Your query should return a table with two columns, one for year and one for salary.
-- query using subquery.
SELECT year, salary FROM salaries WHERE player_id = (SELECT id FROM players 
    WHERE first_name = "Cal" AND last_name = "Ripken") ORDER BY year DESC;
-- query using join:
SELECT year, salary FROM salaries 
JOIN players ON players.id = salaries.player_id
WHERE first_name = "Cal" AND last_name = "Ripken"
ORDER BY year DESC;
<--In 3.sql, write a SQL query to find Ken Griffey Jr.’s home run history.

--     Sort by year in descending order.
--     Note that there may be two players with the name “Ken Griffey.” This Ken Griffey was born in 1969.
--     Your query should return a table with two columns, one for year and one for home runs.
--USING JOIN QUERY:
SELECT HR, year FROM performances JOIN players ON players.id = performances.player_id
   WHERE players.first_name = "Ken" AND players.last_name = "Griffey" AND players.birth_year = 1969
   ORDER BY year DESC;
--USING SUBQUERY:
SELECT HR, year FROM performances WHERE player_id = (SELECT id FROM players 
   WHERE birth_year = 1969 AND first_name = "Ken" AND last_name = "Griffey") ORDER BY year DESC;
<--You need to make a recommendation about which players the team should consider hiring.With the team’s dwindling budget, 
-- the general manager wants to know which players were paid the lowest salaries in 2001. 
-- In 4.sql, write a SQL query to find the 50 players paid the least in 2001.
    -- Sort players by salary, lowest to highest.
    -- If two players have the same salary, sort alphabetically by first name and then by last name.
    -- If two players have the same first and last name, sort by player ID.
    -- Your query should return three columns, one for players’ first names, one for their last names, and one for their salaries.
 SELECT first_name, last_name, salaries.salary FROM players JOIN salaries ON players.id = salaries.player_id
   WHERE year = 2001 ORDER BY salary ASC, first_name, last_name LIMIT 50;

<-- It’s a bit of a slow day in the office. Though Satchel no longer plays, in 5.sql, 
-- write a SQL query to find all teams that Satchel Paige played for.
--    Your query should return a table with a single column, one for the name of the teams.



<-- Which teams might be the biggest competition for the A’s this year? In 6.sql,
-- write a SQL query to return the top 5 teams, sorted by the total number of hits by players in 2001.
--     Call the column representing total hits by players in 2001 “total hits”.
--     Sort by total hits, highest to lowest.
--     Your query should return two columns, one for the teams’ names and one for their total hits in 2001.
SELECT name, SUM(H)AS "totat hits" FROM teams JOIN performances ON performances.team_id = teams.id
WHERE performances.year = 2001 GROUP BY performances.team_id ORDER BY "total hits" DESC;
<--You need to make a recommendation about which player (or players) to avoid recruiting. 
-- In 7.sql, write a SQL query to find the name of the player who’s been paid the highest salary, 
-- of all time, in Major League Baseball.
--     Your query should return a table with two columns, one for the player’s 
--     first name and one for their last name.
SELECT first_name, last_name FROM players JOIN salaries ON salaries.player_id = players.id
ORDER BY salary DESC LIMIT 1;
<--How much would the A’s need to pay to get the best home run hitter this past season? 
-- In 8.sql, write a SQL query to find the 2001 salary of the player who hit the most home runs in 2001.
--     Your query should return a table with one column, the salary of the player.
SELECT salary FROM performances JOIN players ON players.id = performances.player_id
JOIN salaries ON salaries.player_id = player.id
WHERE salaries.year = 2001 ORDER BY performance.HR DESC LIMIT 1;
<--What salaries are other teams paying? In 9.sql, 
-- write a SQL query to find the 5 lowest paying teams (by average salary) in 2001.
--     Round the average salary column to two decimal places and call it “average salary”.
--     Sort the teams by average salary, least to greatest.
--     Your query should return a table with two columns, one for the teams’ names and one for their average salary.
SELECT name , ROUND(AVG(salary),2) AS "average salary" FROM "teams"
JOIN salaries ON salaries.team_id = teams.id
WHERE salaries.year = 2001
GROUP BY teams.id
ORDER BY "average salary"
LIMIT 5;
<-- The general manager has asked you for a report which details each player’s name, their salary for each year they’ve been playing, 
-- and their number of home runs for each year they’ve been playing. To be precise, the table should include:
--     All player’s first names (these will come from players table)
--     All player’s last names
--     All player’s salaries (salaries will come from salaries table.)
--     All player’s home runs (Home runs will come from performances table.)
--     The year in which the player was paid that salary and hit those home runs.
SELECT salary, first_name, last_name, HR, performances.year FROM performances
JOIN players ON players.id = performances.player_id
JOIN salaries ON salaries.player_id = players.id AND performances.year = salaries.year
ORDER BY players.id, salaries.year DESC, HR DESC, salary DESC;
<-- You need a player that can get hits. Who might be the most underrated? In 11.sql, 
-- write a SQL query to find the 10 least expensive players per hit in 2001.
--     Your query should return a table with three columns, one for the players’ first names, one of their last names, and one called “dollars per hit”.
--     You can calculate the “dollars per hit” column by dividing a player’s 2001 salary by the number of hits they made in 2001. Recall you can use AS to rename a column.
--     Dividing a salary by 0 hits will result in a NULL value. Avoid the issue by filtering out players with 0 hits.
--     Sort the table by the “dollars per hit” column, least to most expensive. If two players have the same “dollars per hit”, 
--     order by first name, followed by last name, in alphabetical order.
--     As in 10.sql, ensure that the salary’s year and the performance’s year match.
--     You may assume, for simplicity, that a player will only have one salary and one performance in 2001.
SELECT first_name, last_name, salary/H AS "dollars per hit" FROM performances
JOIN players ON players.id = performances.player_id
JOIN salaries ON salaries.player_id = players.id AND performances.year = salaries.year
WHERE performances.year = 2001 AND H > 0
ORDER BY "dollars per hit", first_name, last_name
LIMIT 10;

<-- Hits are great, but so are RBIs! In 12.sql, 
-- write a SQL query to find the players among the 10 least expensive players per hit and 
-- among the 10 least expensive players per RBI in 2001.

--     Your query should return a table with two columns, one for the players’ first names and one of their last names.
--     You can calculate a player’s salary per RBI by dividing their 2001 salary by their number of RBIs in 2001.
--     You may assume, for simplicity, that a player will only have one salary and one performance in 2001.
--     Order your results by player ID, least to greatest (or alphabetically by last name, as both are the same in this case!).
--     Keep in mind the lessons you’ve learned in 10.sql and 11.sql!
select first_name, last_name from (
    select first_name, last_name, id from (select first_name, last_name,players.id AS "id" from performances
    join players on players.id = performances.player_id
    join salaries on salaries.player_id = players.id and performances.year = salaries.year
    where performances.year = 2001 and H > 0
    order by salary / H
    limit 10)
    INTERSECT
    select first_name, last_name, id from (select first_name, last_name,players.id AS id from performances
    join players on players.id = performances.player_id
    join salaries on salaries.player_id = players.id and performances.year = salaries.year
    where performances.year = 2001 and RBI > 0
    order by salary / RBI
    limit 10)
   )
order by id;