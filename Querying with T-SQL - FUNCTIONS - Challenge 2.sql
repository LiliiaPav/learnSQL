/*
Rank Customers by Revenue
The sales manager would like a list of customers ranked by sales.
Tip: Review the documentation for Ranking Functions in the Transact-SQL Reference.
1. Retrieve companies ranked by sales totals
Write a query that returns a list of company names with a ranking of their place in a list of highest
TotalDue values from the SalesOrderHeader table.
*/
SELECT [CompanyName], [TotalDue], RANK() OVER (ORDER BY [TotalDue] DESC) Revenue
FROM [SalesLT].[Customer] C
JOIN [SalesLT].[SalesOrderHeader] OH ON C.CustomerID=OH.CustomerID
GO


SELECT ProductID, Name, ListPrice,
		DENSE_RANK() OVER (order by ListPrice)
FROM [SalesLT].[Product]