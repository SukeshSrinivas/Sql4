# Write your MySQL query statement below
-- Step 1: Calculate points, goals scored, and goal difference for home teams
WITH HomeTeam AS (
    SELECT 
        home_team_id AS team_id,
        CASE 
            WHEN home_team_goals > away_team_goals THEN 3 -- 3 points for a win
            WHEN home_team_goals < away_team_goals THEN 0 -- 0 points for a loss
            ELSE 1 -- 1 point for a draw
        END AS points,
        home_team_goals AS goal_for,
        away_team_goals AS goal_against,
        home_team_goals - away_team_goals AS goal_diff
    FROM Matches
),

-- Step 2: Calculate the same metrics for away teams
AwayTeam AS (
    SELECT 
        away_team_id AS team_id,
        CASE 
            WHEN home_team_goals < away_team_goals THEN 3
            WHEN home_team_goals > away_team_goals THEN 0
            ELSE 1
        END AS points,
        away_team_goals AS goal_for,
        home_team_goals AS goal_against,
        away_team_goals - home_team_goals AS goal_diff
    FROM Matches
),

-- Step 3: Combine home and away team results into a single dataset
FinalUnion AS (
    SELECT * FROM HomeTeam
    UNION ALL
    SELECT * FROM AwayTeam
)

-- Step 4: Aggregate team statistics and rank teams
SELECT 
    t.team_name, 
    COUNT(FinalUnion.team_id) AS matches_played, -- Total matches played by each team
    SUM(points) AS points, -- Total points earned by each team
    SUM(goal_for) AS goal_for, -- Total goals scored
    SUM(goal_against) AS goal_against, -- Total goals conceded
    SUM(goal_diff) AS goal_diff -- Total goal difference
FROM FinalUnion
LEFT JOIN teams t
ON FinalUnion.team_id = t.team_id
GROUP BY t.team_name
ORDER BY points DESC, goal_diff DESC, t.team_name; -- Rank by points, then goal difference
