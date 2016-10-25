/*Retrieve Product Price Information
Adventure Works products each have a standard cost price that indicates the cost of manufacturing the product, 
and a list price that indicates the recommended selling price for the product. This data is stored in the SalesLT.Product table. 
Whenever a product is ordered, the actual unit price at which it was sold is also recorded in the SalesLT.SalesOrderDetail table. 
You must use subqueries to compare the cost and list prices for each product with the unit prices charged in each sale. 

Tip: Review the documentation for subqueries in Subquery Fundamentals.*/


/*
1. Retrieve products whose list price is higher than the average unit price
Retrieve the product ID, name, and list price for each product where the list price is higher 
than the average unit price for all products that have been sold.*/
SELECT P.[ProductID], [Name], [ListPrice], AvgUnPrice
FROM [SalesLT].[Product] P
JOIN(
SELECT [ProductID], AVG([UnitPrice])  As AvgUnPrice
FROM [SalesLT].[SalesOrderDetail]
GROUP BY [ProductID]) Temp
ON P.ProductID=Temp.ProductID
WHERE P.ListPrice>AvgUnPrice
ORDER By P.[ProductID]
GO

SELECT P.[ProductID], [Name], [ListPrice]
FROM [SalesLT].[Product] P
WHERE [ListPrice]> (
	SELECT AVG([UnitPrice])  
	FROM [SalesLT].[SalesOrderDetail]
)
ORDER By P.[ProductID]
GO

/*
2. Retrieve Products with a list price of $100 or more that have been sold for less than $100
Retrieve the product ID, name, and list price for each product where the list price is $100 or more, 
and the product has been sold for less than $100.*/
SELECT [ProductID], [Name] 
FROM [SalesLT].[Product]
WHERE [ListPrice]>100 and [ProductID] in
(
SELECT [ProductID] 
FROM [SalesLT].[SalesOrderDetail]
WHERE [UnitPrice]<100
)
GO

/*
3. Retrieve the cost, list price, and average selling price for each product
Retrieve the product ID, name, cost, and list price for each product along with the average unit price for which 
that product has been sold.*/
SELECT P.[ProductID], [Name], [StandardCost], [ListPrice], AvgUnPrice
FROM [SalesLT].[Product] P
LEFT JOIN(
	SELECT [ProductID], AVG([UnitPrice])  As AvgUnPrice
	FROM [SalesLT].[SalesOrderDetail]
	GROUP BY [ProductID]) Temp
ON P.ProductID=Temp.ProductID
GO

/*
4. Retrieve products that have an average selling price that is lower than the cost
Filter your previous query to include only products where the cost price is higher than the average selling price.*/
SELECT P.[ProductID], [Name], [StandardCost], [ListPrice], AvgSellingPrice
FROM [SalesLT].[Product] P
JOIN(
	SELECT [ProductID], AVG([UnitPrice])  As AvgSellingPrice
	FROM [SalesLT].[SalesOrderDetail]
	GROUP BY [ProductID]) Temp
ON P.ProductID=Temp.ProductID
WHERE P.StandardCost>Temp.AvgSellingPrice
GO