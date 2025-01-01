-- Getting sales persons details who is associated with company Red
WITH CTE AS (
            SELECT o.order_id, o. sales_id, o.com_id, c.name as Companyname FROM Orders o
            LEFT JOIN Company c
            ON o.com_id = c.com_id
            WHERE c.name = 'RED'

)
 --  Get sales names who are not associated with Red
SELECT name FROM SalesPerson 
WHERE sales_id NOT IN (SELECT sales_id FROM CTE)