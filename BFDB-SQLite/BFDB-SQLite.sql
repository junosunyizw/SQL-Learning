


--BFDB: Get product and sales quantities information from BFDB_SalesData.--
SELECT *
FROM BFDB_SalesData;

--BFDB: Get all columns from BFDB_SalesData--
SELECT Quantities
FROM BFDB_SalesData;

--BFDB: Get all sales data for Sydney--
SELECT *
FROM BFDB_SalesData
WHERE Subsidiaries = 'Sydney';

--BFDB: Sort sales data by sales quantities in desc order.--
SELECT * 
FROM BFDB_SalesData
ORDER BY Quantities DESC;

--BFDB: Sort sales data by sales quantities in desc order for each product.--
SELECT *
FROM BFDB_SalesData
ORDER BY Product asc, Quantities DESC;

-- Show Top 20 largest sales quantities' transaction.--
SELECT Customer,Quantities
FROM BFDB_SalesData
ORDER BY Quantities DESC
LIMIT 20;

--Show Customer list for Sydney Sub--
--Challenge#1--
--BFDB: Get only the Product, Customer and Quantities columns, where Sales Quantities greater than 30, Sort by Quantities Column in ascending order--
SELECT Product,Customer,Quantities
FROM BFDB_SalesData
WHERE Quantities >30
ORDER by Quantities;

--EXERCISE #2 Conditional Filter--
--BFDB: Get all sales data for Sydney--
SELECT *
FROM BFDB_SalesData
WHERE Subsidiaries = 'Sydney';

--BFDB: Get all sales data, but excluding Sydney--
SELECT *
FROM BFDB_SalesData
WHERE NOT Subsidiaries = 'Sydney';

--BFDB: Get all sales data for Sydney and Quantities is less than 20--
SELECT *
FROM BFDB_SalesData
WHERE Subsidiaries = 'Sydney' AND Quantities <20;


--BFDB: Get all sales data for Sydney and Melbourne--
SELECT *
FROM BFDB_SalesData
WHERE Subsidiaries = 'Melbourne' OR Subsidiaries = 'Sydney';


--BFDB: Get only rows of data where Subsidiaries is Perth, Sydney, BeiJing or NewYork--
SELECT *
FROM BFDB_SalesData
WHERE Subsidiaries IN ('Perth', 'Sydney', 'BeiJing', 'NewYork');

--BFDB: Get only rows of data where Quantities is between 20 and 50--
select * 
FROM BFDB_SalesData
WHERE Quantities BETWEEN 20 AND 50;


--BFDB: Get only rows of data where Subsidiaries is Sydney or BeiJing, and Quantities is over 50--
SELECT *
FROM BFDB_SalesData
WHERE Subsidiaries IN ('Sydney','BeiJing') AND Quantities >50;


--BFDB: Get only rows of data where Subsidiaries is Sydney and Quantities is below 20, 
--or where Subsidiaries is Perth and Quantities is over 20, or others subsidiaries data--
SELECT *
FROM BFDB_SalesData
WHERE (Subsidiaries = 'Sydney' AND Quantities <20) OR (Subsidiaries = 'Perth' AND Quantities > 20) OR NOT Subsidiaries IN ('Sydney','Perth');

--EXERCISE #3 Examples--Union & Join
-- BFDB: Combine NewSales data with all BFDB_SalesData--
SELECT *,'Earth' AS Region FROM BFDB_SalesData 
UNION ALL
SELECT *,'Universe' AS Region FROM BFDB_ZSales;


--BFDB: Union all vs Union--
-- BFDB: Get product information from ProductInfo table for all BFDB_SalesData--
SELECT * 
FROM BFDB_SalesData AS a INNER JOIN ProductInfo p 
ON a.Product=p.Product;

-- BFDB:(Get) product name, sales quantities, UnitPrice, UnitCost for all BFDB_SalesData--
SELECT a.Product,Quantities,UnitPrice,UnitCost
FROM BFDB_SalesData a LEFT JOIN ProductInfo p  
ON a.Product=p.Product;

-- BFDB:Find all sales data form existing customers.--

SELECT *
FROM CustomerInfo as c , BFDB_SalesData a 
WHERE c.CustID = a.Customer;

--BFDB: Find all new customers in sales data, i.e. not in existing CustomerInfo--

--BFDB: Search for Inactive customers--
SELECT *
FROM CustomerInfo AS c LEFT JOIN BFDB_SalesData a
ON c.CustID = a.Customer
WHERE a.Quantities IS NULL;

--BFDB: Get ProCat, ProSubCat, product, Country, quantities, UnitPrice, Unticost--
SELECT a.Product,p.ProCat,p.ProSubCat,r.Country,a.Quantities,p.UnitPrice,p.UnitCost
FROM BFDB_SalesData AS a LEFT JOIN RegionInfo AS r 
ON a.Subsidiaries = r.Subsidiaries
LEFT JOIN ProductInfo AS p
ON a.Product=p.Product;

--EXERCISE #5 Example--String Functions
--BFDB: Search for all sales data related Sydney Subsidiary--
SELECT *
FROM BFDB_SalesData
WHERE lower(Subsidiaries)='sydney';

--BFDB: Get product category and size information--
SELECT *, substr(Product,6,3) AS ProCat, substr(product,-1) AS ProSize
FROM BFDB_SalesData;

Select *,Substr(Product,6,3) as ProSubCat,Substr(Product,-1) as ProSize
From BFDB_SalesData;

--BFDB: Conbine Country and Subsidiaries information from RegionInfo--
SELECT country||'-'||Subsidiaries AS Region
FROM RegionInfo;

--BFDB: Find all sales data related to all SQL products--
SELECT *
FROM BFDB_SalesData
WHERE Product LIKE '%SQL%';

--EXERCISE #6 Example--Numeric Functions
--BFDB: Calculation in SQL
SELECT 1/3
SELECT CAST(1 AS RELEASE)/3;

--BFDB: Calculate SaelsAmount & COGS for all sales records--
SELECT *, Quantities*UnitPrice,Quantities*UnitCost
FROM BFDB_SalesData AS a LEFT JOIN ProductInfo p 
ON a.product= p.Product;

--BFDB: Calculate freight expense based on country information (USA:Q*0.8, China:Q*0.6, Others: Q*0.7)--
SELECT *, 
        case when r.Country = 'USA' then a.Quantities*0.8
        WHEN r.Country = 'China' THEN a.Quantities *0.6
        ELSE Quantities*0.7 END AS Freight
FROM BFDB_SalesData a LEFT JOIN RegionInfo r 
ON a.Subsidiaries=r.Subsidiaries;

--EXERCISE #7 Example--DateTime Functions
SELECT datetime('now') as now
SELECT Date('now') as today

SELECT Date('now','+1 day') as tomorrow;

--BFDB: Get all sales data which data is after 1st Jul 2017--
SELECT *
FROM BFDB_SalesData
WHERE Date >= '2017-07-01';

--EXERCISE #8 Example-- Aggreatation
--BFDB: Get total sales volume for each Subsidiary--
SELECT Subsidiaries,sum(Quantities) as Sales_Volume
FROM BFDB_SalesData
GROUP BY Subsidiaries;

--BFDB: Get total sales volume, Number of sales transaction, Maximum quantities, Minimum quantities, Average quantities for each Subsidiary--
SELECT Subsidiaries, sum(Quantities) as sales_volume, Count(TranID)as numtrans,max(Quantities) as maxqty, round(avg(Quantities)) as avgqty
FROM BFDB_SalesData
GROUP BY Subsidiaries;

--BFDB: How many kind of product sold for each Subsidiary--
SELECT Subsidiaries, count(DISTINCT Product) as product
FROM BFDB_SalesData
GROUP BY Subsidiaries;

--BFDB: Show products' total sold quantities for each product in Sydney--
SELECT Product,Subsidiaries, sum(Quantities)
FROM BFDB_SalesData
WHERE Subsidiaries = 'Sydney'
GROUP BY Product;

--BFDB: Which products' total sold quantities are less than 50000--
SELECT Product, sum(Quantities) as total_sold_qty
FROM BFDB_SalesData
GROUP BY Product
having total_sold_qty <= 50000
ORDER BY total_sold_qty DESC;


--EXERCISE #9 Example-- Create, Update & Delete Table
--Create Table
Create Table EmployeeInfo (FirstName Text, LastName Text);
select * from EmployeeInfo;

--Insert rows
Insert into EmployeeInfo Values('Terry', 'Lin'),('Charles', 'Cheng'),('Monica', 'Zheng');
select * from EmployeeInfo;
select * from regioninfo;
Insert into regioninfo (Subsidiaries) values ('Sun');
select * from regioninfo;

--Update rows
Update Regioninfo set Country='Universe' where Subsidiaries='Sun';
select * from regioninfo;

--Delete rows
delete from Regioninfo where Subsidiaries='Sun';
select * from regioninfo;

--Delete Table
Drop Table EmployeeInfo;
select * from EmployeeInfo;
Drop Table IF EXISTS EmployeeInfo;

----EXERCISE #10 Example--Subquery
--Return sales record with max sales quantities.
select * from BFDB_salesdata 
where Quantities=max(Quantities);

select * from BFDB_salesdata 
where Quantities=(select max(Quantities) from BFDB_salesdata);

--Show all sales record for Australia
Select * from BFDB_SalesData
Where Subsidiaries in (Select Subsidiaries from RegionInfo Where Country='Australia');

select * from BFDB_salesdata 
where Subsidiaries in (select Subsidiaries from Regioninfo where Country='Australia');


--BFDB: Create Calculated columns for SalesAmount, COGS and Margin for the SalesData
SELECT *, SalesAmount-COGS AS Margin
FROM (SELECT *, Quantities*UnitPrice as SalesAmount, Quantities*UnitCost as COGS
FROM BFDB_SalesData AS A left JOIN ProductInfo AS P
ON A.Product = P.Product) ;


