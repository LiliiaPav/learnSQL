/*
Table: Visits

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| visit_id    | int     |
| customer_id | int     |
+-------------+---------+
visit_id is the primary key for this table.
This table contains information about the customers who visited the mall.
 

Table: Transactions

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| transaction_id | int     |
| visit_id       | int     |
| amount         | int     |
+----------------+---------+
transaction_id is the primary key for this table.
This table contains information about the transactions made during the visit_id.
 

Write a SQL query to find the IDs of the users who visited without making any transactions and the number of times they made these types of visits.

Return the result table sorted in any order.

The query result format is in the following example.
*/

/* Write your T-SQL query statement below */
/*
SELECT v.customer_id, COUNT( v.visit_id) as count_no_trans 
FROM Visits as v
LEFT join Transactions as t
ON t.visit_id=v.visit_id
WHERE v.visit_id NOT IN (
  SELECT visit_id FROM Transactions
)

GROUP BY v.customer_id
*/
/*
SELECT v.customer_id, COUNT( v.visit_id) as count_no_trans 
FROM Visits as v

WHERE v.visit_id NOT IN (
  SELECT visit_id FROM Transactions
)

GROUP BY v.customer_id
*/

SELECT v.customer_id, COUNT( v.visit_id) as count_no_trans 
FROM Visits as v
LEFT join Transactions as t
ON t.visit_id=v.visit_id
WHERE t.visit_id IS NULL
GROUP BY v.customer_id
