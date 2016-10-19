select distinct City,StateProvince from SalesLT.Address;

select top 10 percent Weight from SalesLT.Product where Weight is not null order by Weight desc ;

select Weight from SalesLT.Product where Weight is not null order by Weight desc OFFSET 10 rows FETCH NEXT 100 rows only;