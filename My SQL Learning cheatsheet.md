# My SQL Learning cheatsheet
## [Updating]


## Tpyes of Data

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
The `CAST()` function in Postgres is used to convert a value of one data type to another data type. The syntax for the `CAST()` function is as follows:

```
CAST(expression AS data_type)

```

Where `expression` is the value to be converted, and `data_type` is the target data type.

For example, if we have a column `age` of type `varchar` in a table `employees`, and we want to convert it to type `integer`, we would use the following query:

```
SELECT CAST(age AS integer) FROM employees;

```

This would return the values in the `age` column as integers.
