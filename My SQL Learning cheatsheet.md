# My SQL Learning cheatsheet
## [Updating]


## 💽Types of Data

- integer or INT - whole numbers
- numeric - number with decimal
- varchar(x) - 'x' maxmium of character,normal is 50 or 200
- char(x) - 'x' fix length of character strings
- text - any length of character strings
- boolean - True = 1, False = 0 or NULL
- date - date
- time - datetime
- timestamps - timezone

### CAST Statement

```
CAST(expression AS data_type);

```
### CONVERT Statement


### FORMAT Statement

Date Formatting

```
--Transform US date format to SQL date format

UPDATE NashvilleHousingData SET SALEDATE = DATE_FORMAT(STR_TO_DATE(SALEDATE, '%M %e, %Y'), '%Y-%m-%d');

```



## 🧹Data Clearning

### Substring & Locate

```
-- MYSQL

SELECT OwnerAddress,
      substring_index(substring_index(OwnerAddress,',',1),',',-1) AS Address,
      substring_index(substring_index(OwnerAddress,',',2),',',-1) AS City,
      substring_index(substring_index(OwnerAddress,',',3),',',-1) AS State
FROM NashvilleHousingData;

```



## 💡TIPS

### *OR & AND Operators*

When there are multiple conditions related to OR and AND Operators, Must use **()** for OR operator for serparating the conditions. Otherwise, Results may be different.


### CTE

Common Table Expressions (CTEs) are generally more efficient and performant than Subqueries, Temp tables, and Views. However, if you are creating multiple CTEs in the same query, you cannot partially process the query of the second CTE that is related to the first CTE.

```
Example:

with 
t1
    as
    (
    select s.name reps_name, r.name reg_name, sum(total_amt_usd) total_sales
    from accounts a
    JOIN orders o
    on a.id=o.account_id
    JOIN sales_reps s
    on s.id=a.sales_rep_id
    JOIN region r
    on r.id=s.region_id
    GROUP BY 1,2
    order by 3 desc
    ),
t2 as
    (select reg_name, max(total_sales) total_sales
    from t1
    GROUP BY 1) -- error to partially process the query in t2 only as t1 is not existed in t2 table
select t1.reps_name, t1.reg_name,t1.total_sales
from t1
JOIN t2
on t1.reg_name=t2.reg_name AND t1.total_sales=t2.total_sales

```


## ❌ERRORS IN SQL & HOW TO FIX THEM

### *Division by Zero Error*
- Method 1: Use the NULLIF Function
```
SELECT numerator / NULLIF(denominator, 0)
FROM my_table;
```
- Method 2: Use a CASE Statement
```
SELECT
  CASE
    WHEN denominator = 0 THEN NULL
    ELSE numerator / denominator
  END
FROM my_table;
```
- Method 3: Use a TRY/CATCH Block (using PostgreSQL 10 or later)
```
BEGIN
  SELECT numerator / denominator
  FROM my_table;
EXCEPTION
  WHEN division_by_zero THEN
    -- Handle the error here
END;
```

### *Column Cannot Be Cast Automatically to Type Date error*
This is likely because there are some values in the column that are not in the correct date format.
- Method 1: Update the existing data in the column to the correct date format before altering the data type. This can be done using the TO_DATE() function in PostgreSQL.
- Method 2: Use the USING clause in your ALTER TABLE statement to specify a custom conversion function that will convert the existing data to the correct date format
```
Use the USING clause in your ALTER TABLE statement to specify a custom conversion function that will convert the existing data to the correct date format
```