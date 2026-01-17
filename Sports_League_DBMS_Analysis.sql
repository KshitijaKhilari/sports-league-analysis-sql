-- =========================================================
-- SPORTS LEAGUE ANALYSIS : SQL QUESTION SET
-- =========================================================

-- 1. Query to calculate the total points scored by each player
SELECT p.player_name, SUM(ps.points) AS total_points
FROM Players p
JOIN PlayerStats ps ON p.player_id = ps.player_id
GROUP BY p.player_id;


-- 2. Query to find players who scored points between 3 and 6
SELECT DISTINCT p.player_name
FROM Players p
JOIN PlayerStats ps ON p.player_id = ps.player_id
WHERE ps.points BETWEEN 3 AND 6;


-- 3. Find players from the same team
SELECT t.team_name, p.player_name
FROM Teams t
JOIN Players p ON t.team_id = p.team_id
ORDER BY t.team_name;


-- 4. Find games played in the last 30 days
SELECT *
FROM Games
WHERE game_date >= CURDATE() - INTERVAL 30 DAY;


-- 5. Create a view to summarize player statistics
CREATE VIEW Player_Stats_Summary AS
SELECT p.player_name,
       SUM(ps.points) AS total_points,
       SUM(ps.assists) AS total_assists,
       SUM(ps.rebounds) AS total_rebounds
FROM Players p
JOIN PlayerStats ps ON p.player_id = ps.player_id
GROUP BY p.player_id;


-- 6. Create a trigger to ensure points cannot be negative before inserting
DROP TRIGGER IF EXISTS prevent_negative_points_insert;

DELIMITER $$

CREATE TRIGGER prevent_negative_points_insert
BEFORE INSERT ON PlayerStats
FOR EACH ROW
BEGIN
    IF NEW.points < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Points cannot be negative';
    END IF;
END$$

DELIMITER ;

# Testing the trigger
INSERT INTO PlayerStats (stat_id, player_id, game_id, points, assists, rebounds)
VALUES (99, 1, 1, -10, 2, 3);


-- 6. Create a trigger to ensure points cannot be negative before updating
DROP TRIGGER IF EXISTS prevent_negative_points_update;

DELIMITER $$

CREATE TRIGGER prevent_negative_points_update
BEFORE UPDATE ON PlayerStats
FOR EACH ROW
BEGIN
    IF NEW.points < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Points cannot be negative';
    END IF;
END;

DELIMITER ;

-- 7. Fetch all players and their respective teams, including players without a team
SELECT p.player_name, t.team_name
FROM Players p
LEFT JOIN Teams t ON p.team_id = t.team_id;


-- 8. Total points scored by players, grouped by their teams
SELECT t.team_name, SUM(ps.points) AS team_total_points
FROM Teams t
JOIN Players p ON t.team_id = p.team_id
JOIN PlayerStats ps ON p.player_id = ps.player_id
GROUP BY t.team_id;


-- 9. Players who scored more than 5 points
SELECT DISTINCT p.player_name
FROM Players p
JOIN PlayerStats ps ON p.player_id = ps.player_id
WHERE ps.points > 5;


-- 10. Update and assign Sarah Moore to the team Green Sharks
UPDATE Players
SET team_id = (
    SELECT team_id FROM Teams WHERE team_name = 'Green Sharks'
)
WHERE player_name = 'Sarah Moore';


-- 11. Deleting all records where the game id is 5
DELETE FROM PlayerStats WHERE game_id = 5;
DELETE FROM Games WHERE game_id = 5;


-- 12. Players who scored more than the average points in a specific game (example: game_id = 6)
SELECT p.player_name, ps.points
FROM PlayerStats ps
JOIN Players p ON ps.player_id = p.player_id
WHERE ps.game_id = 6
AND ps.points > (
    SELECT AVG(points)
    FROM PlayerStats
    WHERE game_id = 6
);


-- 13. Find the top 3 players who have scored the highest total points across all games
SELECT p.player_name, SUM(ps.points) AS total_points
FROM Players p
JOIN PlayerStats ps ON p.player_id = ps.player_id
GROUP BY p.player_id
ORDER BY total_points DESC
LIMIT 3;


-- 14. Retrieve a list of teams that have won at least one game
SELECT DISTINCT t.team_name
FROM Teams t
JOIN Games g
ON (t.team_id = g.team1_id AND g.score_team1 > g.score_team2)
OR (t.team_id = g.team2_id AND g.score_team2 > g.score_team1);


-- 15. Determine the average number of rebounds per player for each team
--     and list the teams in descending order of average rebounds
SELECT t.team_name, AVG(ps.rebounds) AS avg_rebounds
FROM Teams t
JOIN Players p ON t.team_id = p.team_id
JOIN PlayerStats ps ON p.player_id = ps.player_id
GROUP BY t.team_id
ORDER BY avg_rebounds DESC;

-- =========================================================
-- END OF SPORTS LEAGUE ANALYSIS SQL
-- =========================================================
