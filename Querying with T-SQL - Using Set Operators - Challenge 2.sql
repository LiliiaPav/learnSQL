/*
Challenge 2: Filter Customer Addresses
You have created a master list of all customer addresses, but now you have been asked to create filtered lists that 
show which customers have only a main office address, and which customers have both a main office and a shipping address. 
Tip: Review the documentation for the EXCEPT and INTERSECT operators in the Transact-SQL Reference.

1. Retrieve customers with only a main office address. Write a query that returns the company name of each 
company that appears in a table of customers with a ‘Main Office’ address, but not in a table of customers with a ‘Shipping’ address.
*/
SELECT c.CompanyName
FROM [SalesLT].[Customer] C 
JOIN [SalesLT].[CustomerAddress] CA 
ON c.CustomerID=ca.CustomerID
where ca.AddressType='Main Office'
EXcEPT
SELECT c.CompanyName
FROM [SalesLT].[Customer] C 
JOIN [SalesLT].[CustomerAddress] CA 
ON c.CustomerID=ca.CustomerID
where ca.AddressType='Shipping'

/*
2. Retrieve only customers with both a main office address and a shipping address
Write a query that returns the company name of each company that appears in a table 
of customers with a ‘Main Office’ address, and also in a table of customers with a ‘Shipping’ address.
*/
SELECT c.CompanyName
FROM [SalesLT].[Customer] C 
JOIN [SalesLT].[CustomerAddress] CA 
ON c.CustomerID=ca.CustomerID
where ca.AddressType='Main Office'
INTERSECT
SELECT c.CompanyName
FROM [SalesLT].[Customer] C 
JOIN [SalesLT].[CustomerAddress] CA 
ON c.CustomerID=ca.CustomerID
where ca.AddressType='Shipping'