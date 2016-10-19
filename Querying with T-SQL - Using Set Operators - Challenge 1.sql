/*
Challenge 1: Retrieve Customer Addresses
Customers can have two kinds of address: a main office address and a shipping address. 
The accounts department want to ensure that the main office address is always used for billing, 
and have asked you to write a query that clearly identifies the different types of address for each customer. 
Tip: Review the documentation for the UNION operator in the Transact-SQL Reference.
1. Retrieve billing addresses
Write a query that retrieves the company name, first line of the street address, city, and a column named AddressType 
with the value ‘Billing’ for customers where the address type in the SalesLT.CustomerAddress table is ‘Main Office’.
*/
SELECT C.[CompanyName], a.AddressLine1, a.City, AddressType='Billing'
FROM [SalesLT].[Customer] C
LEFT Join [SalesLT].[CustomerAddress] CA 
	ON CA.CustomerID=C.CustomerID
	JOIN [SalesLT].[Address] A
	on A.AddressID=CA.AddressID
WHERE CA.AddressType='Main Office'

SELECT C.[CompanyName], a.AddressLine1, a.City, AddressType='NOT Billing'
FROM [SalesLT].[Customer] C
LEFT Join [SalesLT].[CustomerAddress] CA 
	ON CA.CustomerID=C.CustomerID
	JOIN [SalesLT].[Address] A
	on A.AddressID=CA.AddressID
WHERE CA.AddressType<>'Main Office'

/*2. Retrieve shipping addresses
Write a similar query that retrieves the company name, first line of the street address, city, 
and a column named AddressType with the value ‘Shipping’ for customers where the address type 
in the SalesLT.CustomerAddress table is ‘Shipping’.
*/

SELECT C.[CompanyName], a.AddressLine1, a.City, AddressType='Shipping'
FROM [SalesLT].[Customer] C
LEFT Join [SalesLT].[CustomerAddress] CA 
	ON CA.CustomerID=C.CustomerID
	JOIN [SalesLT].[Address] A
	on A.AddressID=CA.AddressID
WHERE CA.AddressType='Shipping'

/*
3. Combine billing and shipping addresses
Combine the results returned by the two queries to create a list of all customer addresses that is sorted by company 
name and then address type.
*/
SELECT C.[CompanyName], a.AddressLine1, a.City, AddressType='Billing'
FROM [SalesLT].[Customer] C
LEFT Join [SalesLT].[CustomerAddress] CA 
	ON CA.CustomerID=C.CustomerID
	JOIN [SalesLT].[Address] A
	on A.AddressID=CA.AddressID
WHERE CA.AddressType='Main Office'

SELECT C.[CompanyName], a.AddressLine1, a.City, AddressType='Billing'
FROM [SalesLT].[Customer] C
LEFT Join [SalesLT].[CustomerAddress] CA 
	ON CA.CustomerID=C.CustomerID
	JOIN [SalesLT].[Address] A
	on A.AddressID=CA.AddressID
WHERE CA.AddressType='Main Office'
UNION ALL
SELECT C.[CompanyName], a.AddressLine1, a.City, AddressType='Shipping'
FROM [SalesLT].[Customer] C
LEFT Join [SalesLT].[CustomerAddress] CA 
	ON CA.CustomerID=C.CustomerID
	JOIN [SalesLT].[Address] A
	on A.AddressID=CA.AddressID
WHERE CA.AddressType='Shipping'
ORDER BY C.CompanyName, AddressType