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
CAST(expression AS data_type)


### CONVERT Statement


### FORMAT Statement



## TIPS

### OR & AND Operators

When there are multiple conditions related to OR and AND Operators, Must use **()** for OR operator for serparating the conditions. Otherwise, Results may be different.




## ERROR IN SQL & HOW TO FIX THEM

### Division by Zero Error
Method 1: Use the NULLIF Function
```
SELECT numerator / NULLIF(denominator, 0)
FROM my_table;

Method 2: Use a CASE Statement
```
SELECT
  CASE
    WHEN denominator = 0 THEN NULL
    ELSE numerator / denominator
  END
FROM my_table;

Method 3: Use a TRY/CATCH Block (using PostgreSQL 10 or later)
```
BEGIN
  SELECT numerator / denominator
  FROM my_table;
EXCEPTION
  WHEN division_by_zero THEN
    -- Handle the error here
END;

