CREATE TABLE Teams (
    team_id INT PRIMARY KEY,      -- Unique ID for each team
    team_name VARCHAR(100) NOT NULL -- Team name
);

-- Inserting 20 sample teams

INSERT INTO Teams (team_id, team_name) VALUES
(1, 'Red Dragons'),
(2, 'Blue Tigers'),
(3, 'Green Sharks'),
(4, 'Yellow Eagles'),
(5, 'Black Panthers'),
(6, 'White Wolves'),
(7, 'Orange Bears'),
(8, 'Purple Lions'),
(9, 'Silver Falcons'),
(10, 'Gold Hawks'),
(11, 'Crimson Hawks'),
(12, 'Azure Foxes'),
(13, 'Emerald Snakes'),
(14, 'Amber Owls'),
(15, 'Ivory Elephants'),
(16, 'Navy Dolphins'),
(17, 'Bronze Rhinos'),
(18, 'Violet Lynxes'),
(19, 'Steel Bulls'),
(20, 'Titan Bears');

-- Creating the Players table with player information
CREATE TABLE Players (
    player_id INT PRIMARY KEY,       -- Unique ID for each player
    player_name VARCHAR(100) NOT NULL, -- Player's name
    team_id INT,                      -- Reference to the team
    FOREIGN KEY (team_id) REFERENCES Teams(team_id)  -- Foreign key to Teams table
);

-- Inserting 20 sample players
INSERT INTO Players (player_id, player_name, team_id) VALUES
(1, 'John Doe', 1),
(2, 'Jane Smith', 2),
(3, 'Michael Brown', 3),
(4, 'Emily Davis', 4),
(5, 'David Wilson', 5),
(6, 'Sarah Moore', 6),
(7, 'James Taylor', 7),
(8, 'Linda Anderson', 8),
(9, 'Robert Lee', 9),
(10, 'Maria Martinez', 10),
(11, 'Chris Evans', 11),
(12, 'Scarlett Johnson', 12),
(13, 'Mark Ruffalo', 13),
(14, 'Jeremy Renner', 14),
(15, 'Tom Holland', 15),
(16, 'Benedict Cumberbatch', 16),
(17, 'Chadwick Boseman', 17),
(18, 'Elizabeth Olsen', 18),
(19, 'Paul Rudd', 19),
(20, 'Tom Hardy', 20);

-- Creating the Games table with information about the games played
CREATE TABLE Games (
    game_id INT PRIMARY KEY,          -- Unique ID for each game
    team1_id INT,                     -- Team 1 (foreign key reference to Teams)
    team2_id INT,                     -- Team 2 (foreign key reference to Teams)
    score_team1 INT,                  -- Score for team 1
    score_team2 INT,                  -- Score for team 2
    game_date DATE,                   -- Date of the game
    FOREIGN KEY (team1_id) REFERENCES Teams(team_id),  -- Foreign key to Teams
    FOREIGN KEY (team2_id) REFERENCES Teams(team_id)   -- Foreign key to Teams
);
-- Inserting 20 sample games
INSERT INTO Games (game_id, team1_id, team2_id, score_team1, score_team2, game_date) VALUES
(1, 1, 2, 5, 3, '2024-11-10'),
(2, 3, 4, 2, 4, '2024-11-11'),
(3, 5, 6, 6, 6, '2024-11-12'),
(4, 7, 8, 3, 3, '2024-11-13'),
(5, 9, 10, 7, 1, '2024-11-14'),
(6, 1, 3, 4, 2, '2024-11-15'),
(7, 2, 4, 5, 5, '2024-11-16'),
(8, 6, 7, 6, 2, '2024-11-17'),
(9, 8, 9, 4, 6, '2024-11-18'),
(10, 5, 10, 7, 3, '2024-11-19'),
(11, 11, 12, 3, 5, '2024-11-20'),
(12, 13, 14, 4, 4, '2024-11-21'),
(13, 15, 16, 7, 6, '2024-11-22'),
(14, 17, 18, 5, 8, '2024-11-23'),
(15, 19, 20, 9, 2, '2024-11-24'),
(16, 11, 13, 6, 5, '2024-11-25'),
(17, 12, 14, 7, 4, '2024-11-26'),
(18, 15, 17, 5, 6, '2024-11-27'),
(19, 16, 18, 8, 7, '2024-11-28'),
(20, 19, 11, 4, 3, '2024-11-29');

-- Creating the PlayerStats table to store performance statistics for each player in each game
CREATE TABLE PlayerStats (
    stat_id INT PRIMARY KEY,           -- Unique ID for each stat record
    player_id INT,                     -- Reference to the player
    game_id INT,                       -- Reference to the game
    points INT,                        -- Points scored by the player
    assists INT,                       -- Assists made by the player
    rebounds INT,                      -- Rebounds made by the player
    FOREIGN KEY (player_id) REFERENCES Players(player_id),  -- Foreign key to Players table
    FOREIGN KEY (game_id) REFERENCES Games(game_id)         -- Foreign key to Games table
);

-- Inserting 20 sample player statistics
INSERT INTO PlayerStats (stat_id, player_id, game_id, points, assists, rebounds) VALUES
(1, 1, 6, 8, 2, 5),
(2, 2, 7, 6, 4, 3),
(3, 3, 8, 9, 1, 2),
(4, 4, 9, 10, 2, 6),
(5, 5, 10, 12, 3, 4),
(6, 6, 6, 7, 2, 3),
(7, 7, 7, 4, 4, 2),
(8, 8, 8, 5, 3, 7),
(9, 9, 9, 6, 1, 5),
(10, 10, 10, 8, 2, 6),
(11, 1, 3, 3, 1, 4),
(12, 2, 4, 4, 2, 5),
(13, 3, 5, 5, 3, 6),
(14, 4, 6, 6, 1, 3),
(15, 5, 7, 7, 2, 4),
(16, 6, 8, 8, 3, 2),
(17, 7, 9, 9, 4, 3),
(18, 8, 10, 10, 2, 4),
(19, 9, 6, 11, 1, 5),
(20, 10, 7, 12, 3, 6);
