/*Challenge 2: Retrieve Sales Data
As you continue to work with the Adventure Works customer and sales data, you must create queries for reports 
that have been requested by the sales team.

1. Retrieve a list of all customers and their orders
The sales manager wants a list of all customer companies and their contacts (first name and last name), 
showing the sales order ID and total due for each order they have placed. 
Customers who have not placed any orders should be included at the bottom of the list with NULL values for the order ID and total due.
*/

select SalesLT.Customer.CompanyName, SalesLT.Customer.FirstName, SalesLT.Customer.LastName, 
	ISNULL(SalesLT.SalesOrderHeader.SalesOrderID, '') as OrderID, 
	ISNULL(SalesLT.SalesOrderHeader.TotalDue, '') TotalDue 
from SalesLT.Customer 
	Left JOIN SalesLT.SalesOrderHeader 
	ON SalesLT.SalesOrderHeader.CustomerID=SalesLT.Customer.CustomerID
order by OrderID DESC;

/*
2. Retrieve a list of customers with no address
A sales employee has noticed that Adventure Works does not have address information for all customers. 
You must write a query that returns a list of customer IDs, company names, contact names (first name and last name), 
and phone numbers for customers with no address stored in the database.
*/
select C.CompanyName, C.FirstName, C.LastName, C.Phone
from SalesLT.Customer C
	Left JOIN [SalesLT].[CustomerAddress] A 
	ON A.CustomerID=C.CustomerID 
WHERE A.AddressID is NULL
order by C.CompanyName ;

/*3. Retrieve a list of customers and products without orders
Some customers have never placed orders, and some products have never been ordered. 
Create a query that returns a column of customer IDs for customers who have never placed an order, 
and a column of product IDs for products that have never been ordered. 
Each row with a customer ID should have a NULL product ID (because the customer has never ordered a product) 
and each row with a product ID should have a NULL customer ID (because the product has never been ordered by a customer).
*/

SELECT TEMP1.CustomerID, TEMP2.[ProductID]
FROM
(
SELECT C.CustomerID
FROM [SalesLT].[Customer] C
LEFT JOIN [SalesLT].[SalesOrderHeader] OH ON OH.CustomerID=C.CustomerID
WHERE OH.SalesOrderID is NULL
) as TEMP1
FULL JOIN(
SELECT P.[ProductID], OH.CustomerID
FROM [SalesLT].[Product] P
LEFT JOIN [SalesLT].[SalesOrderDetail] O ON P.[ProductID]=O.ProductID
LEFT JOIN [SalesLT].[SalesOrderHeader] OH ON OH.SalesOrderID=O.SalesOrderID
WHERE O.[SalesOrderID] is NULL 
) as TEMP2
ON TEMP1.CustomerID=TEMP2.CustomerID