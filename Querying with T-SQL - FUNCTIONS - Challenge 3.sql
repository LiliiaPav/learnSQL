/*Aggregate Product Sales
The product manager would like aggregated information about product sales.
Tip: Review the documentation for the GROUP BY clause in the Transact-SQL Reference.
1. Retrieve total sales by product
Write a query to retrieve a list of the product names and the total revenue calculated as the sum of the
LineTotal from the SalesLT.SalesOrderDetail table, with the results sorted in descending order of total
revenue.*/
SELECT [Name], SUM([LineTotal]) TotalRevenue
FROM [SalesLT].[Product] P
JOIN [SalesLT].[SalesOrderDetail] OD 
ON P.ProductID=OD.ProductID
GROUP BY P.Name
GO

/*
2. Filter the product sales list to include only products that cost over $1,000
Modify the previous query to include sales totals for products that have a list price of more than $1000.*/
SELECT [Name], SUM([LineTotal]) TotalRevenue, COUNT (OD.[ProductID]) SalesTotals
FROM [SalesLT].[Product] P
JOIN [SalesLT].[SalesOrderDetail] OD ON P.ProductID=OD.ProductID
where [ListPrice]>1000
GROUP BY P.Name
ORDER BY TotalRevenue DESC
GO

/*
3. Filter the product sales groups to include only total sales over $20,000
Modify the previous query to only include only product groups with a total sales value greater than $20,000.*/
SELECT [Name], SUM([LineTotal]) TotalRevenue
FROM [SalesLT].[Product] P
JOIN [SalesLT].[SalesOrderDetail] OD ON P.ProductID=OD.ProductID
where [ListPrice]>1000
GROUP BY P.Name
HAVING SUM([LineTotal])>20000
ORDER BY TotalRevenue DESC
GO