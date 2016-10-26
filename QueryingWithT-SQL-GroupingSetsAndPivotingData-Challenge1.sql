/*
Retrieve Regional Sales Totals
Adventure Works sells products to customers in multiple country/regions around the world.

1. Retrieve totals for country/region and state/province 
Tip: Review the documentation for GROUP BY in the Transact-SQL Language Reference.

An existing report uses the following query to return total sales revenue grouped by country/region and state/province.

SELECT a.CountryRegion, a.StateProvince, SUM(soh.TotalDue) AS Revenue
FROM SalesLT.Address AS a
JOIN SalesLT.CustomerAddress AS ca ON a.AddressID = ca.AddressID
JOIN SalesLT.Customer AS c ON ca.CustomerID = c.CustomerID
JOIN SalesLT.SalesOrderHeader as soh ON c.CustomerID = soh.CustomerID
GROUP BY a.CountryRegion, a.StateProvince
ORDER BY a.CountryRegion, a.StateProvince;

You have been asked to modify this query so that the results include a grand total for all sales revenue 
and a subtotal for each country/region in addition to the state/province subtotals that are already returned.*/

SELECT a.CountryRegion, a.StateProvince, SUM(soh.TotalDue) AS Revenue
FROM SalesLT.Address AS a
JOIN SalesLT.CustomerAddress AS ca ON a.AddressID = ca.AddressID
JOIN SalesLT.Customer AS c ON ca.CustomerID = c.CustomerID
JOIN SalesLT.SalesOrderHeader as soh ON c.CustomerID = soh.CustomerID
GROUP BY ROLLUP(a.CountryRegion, a.StateProvince)
ORDER BY a.CountryRegion, a.StateProvince
GO

/*
2. Indicate the grouping level in the results 
Tip: Review the documentation for the GROUPING_ID function in the Transact-SQL Language Reference.

Modify your query to include a column named Level that indicates at which level in the total, country/region, 
and state/province hierarchy the revenue figure in the row is aggregated. 
For example, the grand total row should contain the value ‘Total’, the row showing the subtotal for United States 
should contain the value ‘United States Subtotal’, and the row showing the subtotal for California should contain 
the value ‘California Subtotal’.*/
SELECT a.CountryRegion, GROUPING_ID(a.CountryRegion), a.StateProvince,GROUPING_ID(a.StateProvince),
IIF(GROUPING_ID(a.CountryRegion) = 1 AND GROUPING_ID(a.StateProvince) = 1, 'Total', IIF(GROUPING_ID(a.StateProvince) = 1, a.CountryRegion + ' Subtotal', a.StateProvince + ' Subtotal')) AS Level,
SUM(soh.TotalDue) AS Revenue
FROM SalesLT.Address AS a
JOIN SalesLT.CustomerAddress AS ca ON a.AddressID = ca.AddressID
JOIN SalesLT.Customer AS c ON ca.CustomerID = c.CustomerID
JOIN SalesLT.SalesOrderHeader as soh ON c.CustomerID = soh.CustomerID
GROUP BY ROLLUP(a.CountryRegion, a.StateProvince)
ORDER BY a.CountryRegion, a.StateProvince
GO

/*
3. Add a grouping level for cities
Extend your query to include a grouping for individual cities.
*/
SELECT ISNULL(a.CountryRegion, 'GRAND TOTAL') CountryRegion, --GROUPING_ID(a.CountryRegion), 
	ISNULL(a.StateProvince,'') StateProvince,--GROUPING_ID(a.StateProvince), 
	ISNULL(a.[City], '') City, --GROUPING_ID(a.City), 
	CASE 
		WHEN GROUPING_ID(a.CountryRegion) = 1 AND GROUPING_ID(a.StateProvince) = 1 AND GROUPING_ID(a.City) = 1 THEN 'Total'
		WHEN GROUPING_ID(a.StateProvince) = 1 AND GROUPING_ID(a.City)=1 THEN a.CountryRegion + ' Subtotal'
		WHEN GROUPING_ID(a.StateProvince) = 0 AND GROUPING_ID(a.City)=1 THEN a.StateProvince + ' Subtotal'
		WHEN GROUPING_ID(a.StateProvince) = 0 AND GROUPING_ID(a.City)=0 THEN a.City+' Subtotal'
	END AS Level,
SUM(soh.TotalDue) AS Revenue
FROM SalesLT.Address AS a
JOIN SalesLT.CustomerAddress AS ca ON a.AddressID = ca.AddressID
JOIN SalesLT.Customer AS c ON ca.CustomerID = c.CustomerID
JOIN SalesLT.SalesOrderHeader as soh ON c.CustomerID = soh.CustomerID
GROUP BY ROLLUP(a.CountryRegion, a.StateProvince, a.City)
ORDER BY a.CountryRegion, a.StateProvince, GROUPING_ID(a.City) DESC, a.City
GO

GO



GO