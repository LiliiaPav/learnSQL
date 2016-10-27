/*
Challenge 3: Deleting Products
The Bells and Horns category has not been successful, and it must be deleted from the database. 
Tip: Review the documentation for DELETE in the Transact-SQL Language Reference.

1. Delete a product category and its products
Delete the records foe the Bells and Horns category and its products. 
You must ensure that you delete the records from the tables in the correct order to avoid a foreign-key constraint violation.
*/
DELETE [SalesLT].[Product]
WHERE [ProductCategoryID]=(
SELECT [ProductCategoryID] FROM [SalesLT].[ProductCategory] WHERE [Name]='Bells and Horns')

SELECT * FROM [SalesLT].[Product]