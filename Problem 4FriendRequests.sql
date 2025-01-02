WITH UnionOutput AS (
    SELECT requester_id AS person, accepter_id AS friend FROM RequestAccepted
    UNION ALL
    SELECT accepter_id AS person, requester_id AS friend FROM RequestAccepted
)
SELECT 
    person AS id, 
    COUNT(friend) AS num
FROM UnionOutput
GROUP BY person
ORDER BY num DESC
LIMIT 1;