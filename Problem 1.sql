# Write your MySQL query statement below
WITH AllCandidates AS (
    SELECT experience, employee_id,  SUM(salary) OVER (PARTITION BY experience ORDER BY salary, experience ) AS CusumSalary, salary FROM Candidates
)
SElECT 'Senior' AS experience, COUNT(employee_id) AS accepted_candidates FROM AllCandidates WHERE CusumSalary <=70000 AND experience ='Senior'
UNION ALL
SElECT 'Junior' AS experience, COUNT(employee_id) AS accepted_candidates FROM AllCandidates WHERE experience ='Junior' AND
CusumSalary<= (SELECT 70000 -IFNULL(MAX(CusumSalary),0) FROM AllCandidates WHERE CusumSalary <=70000 AND experience ='Senior')

