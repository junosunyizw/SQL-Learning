Course Sources: Original course from [Udacity - SQL for Data Analysis](https://www.udacity.com/course/sql-for-data-analysis--ud198) -Postgres SQL
*This is amazing free comprehesive SQL course with resources and practices to take you from basic to intermediate level.*

## Introduction



***
## Table of Content
<details>
<summary>
Click here to expand!
</summary>
         
### 1.Basic SQL

### 2.SQL Joins

### 3.SQL Aggregations

### 4.SQL Subqueries & Temporary Tables

### 5.SQL Data Cleaning
         
### 6.[Advanced] SQL Window Functions

### 7.[Advanced] SQL Advanced JOINs & Performance Tuning

</details>

***



```
--Update the data type for date column after import my data from cvs., which is easier for you to process query for next practicing.
--it saves much for you to CAST everytime for query with Date manipulation.

ALTER TABLE orders 
ALTER COLUMN occurred_at TYPE date 
USING to_date(occurred_at, 'YYYY-MM-DD');

ALTER TABLE web_events 
ALTER COLUMN occurred_at TYPE date 
USING to_date(occurred_at, 'YYYY-MM-DD');
```


## Basic SQL

### Select statement

*Q1:Try writing your own query to select only the id, account_id, and occurred_at columns for all orders in the orders table.*
```
SELECT id,account_id,occurred_at
FROM orders;
```

### Limit statement

*Q2:Try using LIMIT yourself below by writing a query that displays all the data in the occurred_at, account_id, and channel columns of the web_events table, and limits the output to only the first 15 rows.*
```
SELECT occurred_at,account_id,channel
FROM web_events
limit 15;
```

### Order statement

*Q3:Write a query to return the 10 earliest orders in the orders table. Include the id, occurred_at, and total_amt_usd.*
```
SELECT id, occurred_at,total_amt_usd
FROM orders
ORDER BY occurred_at ASC
LIMIT 10;
```

*Q4:Write a query to return the top 5 orders in terms of largest total_amt_usd. Include the id, account_id, and total_amt_usd.*
```
SELECT id,account_id,total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC
LIMIT 5;
```

*Q5:Write a query to return the lowest 20 orders in terms of smallest total_amt_usd. Include the id, account_id, and total_amt_usd.*
```
SELECT id, account_id, total_amt_usd
FROM orders 
ORDER BY total_amt_usd ASC
LIMIT 20;
```

*Q6:Write a query that displays the order ID, account ID, and total dollar amount for all the orders, sorted first by the account ID (in ascending order), and then by the total dollar amount (in descending order).*
```
--my thoughts, using number to replace column name in 'order by' statement, which could save much time to input the name again.
SELECT id,account_id,total_amt_usd
FROM orders
ORDER BY 2 ASC, 3 DESC;
```

*Q7:Now write a query that again displays order ID, account ID, and total dollar amount for each order, but this time sorted first by total dollar amount (in descending order), and then by account ID (in ascending order).*
```
SELECT id,account_id,total_amt_usd
FROM orders
ORDER BY 3 DESC, 2 ASC;
```

*Q8:Compare the results of these two queries above. How are the results different when you switch the column you sort on first? In query 1, group by account id and then sort by amount in each id. in query 2, group by amount and then sort by id in each same amount group.*


### Where Statement

*Q9:Pulls the first 5 rows and all columns from the orders table that have a dollar amount of gloss_amt_usd greater than or equal to 1000.*
```
select *
FROM orders
where gloss_amt_usd >= 1000
LIMIT 5;
```

*Q10:Pulls the first 10 rows and all columns from the orders table that have a total_amt_usd less than 500.*
```
SELECT *
FROM orders
WHERE total_amt_usd < 500
LIMIT 10;
```

*Q11:Filter the accounts table to include the company name, website, and the primary point of contact (primary_poc) just for the Exxon Mobil company in the accounts table.*
```
SELECT name,website,primary_poc
FROM accounts
where name = 'Exxon Mobil';
```

### Arithmetic Operations 

*Q12:Create a column that divides the standard_amt_usd by the standard_qty to find the unit price for standard paper for each order. Limit the results to the first 10 orders, and include the id and account_id fields.*
```
SELECT id,account_id, round(cast(standard_amt_usd/standard_qty as numeric),2) as unit_price_standard
FROM orders
LIMIT 10;
```

*Q13:Write a query that finds the percentage of revenue that comes from poster paper for each order. You will need to use only the columns that end with _usd.*
```
select id, account_id, cast(poster_amt_usd/total_amt_usd as numeric)*100 as perc_poster_income
from orders
WHERE total_amt_usd <> 0 AND gloss_amt_usd <> 0
LIMIT 10;
```

### Logical Operators
### Like Operator

*Q14:All the companies whose names start with 'C'.*
```
select *
from accounts
where name Like 'C%';
```

*Q15:All companies whose names contain the string 'one' somewhere in the name.*
```
SELECT *
FROM accounts
WHERE name like '%one%';
```

*Q16:All companies whose names end with 's'.*
```
SELECT *
FROM accounts
where name like '%s';
```

### In Operator

*Q17:Use the accounts table to find the account name, primary_poc, and sales_rep_id for Walmart, Target, and Nordstrom.*
```
SELECT name,primary_poc,sales_rep_id
FROM accounts
WHERE name IN ('Walmart','Target','Nordstrom');
```

*Q18:Use the web_events table to find all information regarding individuals who were contacted via the channel of organic or adwords.*
```
SELECT *
FROM web_events
WHERE channel IN('organic','adwords');
```

### NOT Operator

*Q19:Use the accounts table to find the account name, primary poc, and sales rep id for all stores except Walmart, Target, and Nordstrom.*
```
SELECT name,primary_poc,sales_rep_id
FROM accounts
WHERE not name IN ('Walmart','Target','Nordstrom');
```

*Q20:Use the web_events table to find all information regarding individuals who were contacted via any method except using organic or adwords methods.*
```
SELECT *
FROM web_events
WHERE NOT channel IN('organic','adwords');
```

*Q21:All the companies whose names do not start with 'C'.*
```
SELECT *
FROM accounts
WHERE NOT name like 'C%';
```

*Q22:All companies whose names do not contain the string 'one' somewhere in the name.*
```
SELECT *
FROM accounts
WHERE NOT name like '%one%';
```

*Q23:All companies whose names do not end with 's'.*
```
SELECT *
FROM accounts
WHERE NOT name like 's%';
```

### AND and BETWEEN Operators

*Q24:Write a query that returns all the orders where the standard_qty is over 1000, the poster_qty is 0, and the gloss_qty is 0.*
```
SELECT *
FROM orders
where standard_qty > 1000 AND poster_qty = 0 AND gloss_qty = 0;
```

*Q25:Using the accounts table, find all the companies whose names do not start with 'C' and end with 's'.*
```
SELECT *
FROM accounts
WHERE not name BETWEEN 'C%' AND '%s';
```

*Q26:When you use the BETWEEN operator in SQL, do the results include the values of your endpoints, or not? Figure out the answer to this important question by writing a query that displays the order date and gloss_qty data for all orders where gloss_qty is between 24 and 29. Then look at your output to see if the BETWEEN operator included the begin and end values or not.*
```
SELECT occurred_at,gloss_qty
FROM orders
WHERE gloss_qty BETWEEN '24' and '29';
```

*Q27:Use the web_events table to find all information regarding individuals who were contacted via the organic or adwords channels, and started their account at any point in 2016, sorted from newest to oldest.*
```
Select *
from web_events
where channel in ('organic','adwords') and date_part('year',cast(occurred_at as date))= '2016'--or using (WHERE channel IN ('organic', 'adwords') AND occurred_at BETWEEN '2016-01-01' AND '2017-01-01')
ORDER BY occurred_at;
```


### OR Operator 
*tips:(key: when using or & and operator on multiple conditions, rememeber to use () for spliting these conditions, otherwise results would be different)*

*Q27:*Find list of orders ids where either gloss_qty or poster_qty is greater than 4000. Only include the id field in the resulting table.*
```
select id
from orders
where gloss_qty > 4000 OR poster_qty > 4000;
```

*Q28:Write a query that returns a list of orders where the standard_qty is zero and either the gloss_qty or poster_qty is over 1000.*
```
select *
from orders
where standard_qty = 0 and (gloss_qty > 1000 or poster_qty>1000)
```

*Q29:Find all the company names that start with a 'C' or 'W', and the primary contact contains 'ana' or 'Ana', but it doesn't contain 'eana'.*
```
select *
FROM accounts
where (name like 'C%' or name like 'W%') and ((primary_poc like '%ana%' or primary_poc like '%Ana%') and not primary_poc like '%eana%');
```

## SQL Joins

### JOIN 

*Q30:Try pulling all the data from the accounts table and all the data from the orders table.*

```
select *
from accounts a
JOIN orders o
on  a.id=o.account_id;
```

*Q31:Try pulling standard_qty, gloss_qty, and poster_qty from the orders table, and the website and the primary_poc from the accounts table.*
```
select standard_qty,gloss_qty,poster_qty,website,primary_poc
from orders o
JOIN accounts a
on a.id=o.account_id;
```

*Q32:Provide a table for all web_events associated with account name of Walmart. There should be three columns. Be sure to include the primary_poc, time of the event, and the channel for each event. Additionally, you might choose to add a fourth column to assure only Walmart events were chosen.*
```
select w.occurred_at,a.primary_poc,w.channel,a.name
from web_events w
JOIN accounts a
on w.account_id=a.id
where a.name = 'Walmart';
```

*Q33:Provide a table that provides the region for each sales_rep along with their associated accounts. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.*
```
select a.name as account_name,s.name as reps_name,r.name as region_name
from sales_reps s
JOIN accounts a
on  a.sales_rep_id=s.id
JOIN region r
on  s.region_id=r.id
ORDER BY 1;
```

*Q34:Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. Your final table should have 3 columns: region name, account name, and unit price. A few accounts have 0 for total, so I divided by (total + 0.01) to assure not dividing by zero.*
```
select r.name as region_name, a.name as account_name, ROUND(CAST(o.total_amt_usd/nullif(total,0) AS numeric),2) as unit_price --different solution from request of question.
from orders o
JOIN accounts a
on   o.account_id=a.id
JOIN sales_reps s
on s.id=a.sales_rep_id
JOIN region r
on s.region_id=r.id;
```

*Q35:Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.*
```
select r.name region_names,s.name sales_name,a.name account_name
from sales_reps s
JOIN accounts a
on a.sales_rep_id=s.id
JOIN region r
on r.id=s.region_id
where r.name ='Midwest'
ORDER BY 3;
```

*36:Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for accounts where the sales rep has a first name starting with S and in the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.*
```
select r.name region_names,s.name sales_name,a.name account_name
from sales_reps s
JOIN accounts a
on a.sales_rep_id=s.id
JOIN region r
on r.id=s.region_id
where s.name like 'S%' and r.name = 'Midwest'
ORDER BY 3;
```

*Q37:Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for accounts where the sales rep has a last name starting with K and in the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.*
```
select r.name region_names,s.name sales_name,a.name account_name
from sales_reps s
JOIN accounts a
on a.sales_rep_id=s.id
JOIN region r
on r.id=s.region_id
where s.name like 'K%' and r.name = 'Midwest'
ORDER BY 3;
```

*Q38:Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100. Your final table should have 3 columns: region name, account name, and unit price. In order to avoid a division by zero error, adding .01 to the denominator here is helpful total_amt_usd/(total+0.01).*
```
select r.name region_names,a.name account_name,round(cast(total_amt_usd/nullif(total,0) as numeric),4)
from sales_reps s
JOIN accounts a
on a.sales_rep_id=s.id
JOIN region r
on r.id=s.region_id
JOIN orders o
on o.account_id=a.id
where standard_qty >100
ORDER BY 3;
```

*Q39:Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. Your final table should have 3 columns: region name, account name, and unit price. Sort for the smallest unit price first. In order to avoid a division by zero error, adding .01 to the denominator here is helpful (total_amt_usd)/(total+0.01).*
```
select r.name region_names,a.name account_name,round(cast(total_amt_usd/nullif(total,0) as numeric),4)
from sales_reps s
JOIN accounts a
on a.sales_rep_id=s.id
JOIN region r
on r.id=s.region_id
JOIN orders o
on o.account_id=a.id
where standard_qty>100 and poster_qty>50
ORDER BY 3;
```

*Q40:Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. Your final table should have 3 columns: region name, account name, and unit price. Sort for the largest unit price first. In order to avoid a division by zero error, adding .01 to the denominator here is helpful (total_amt_usd)/(total+0.01).*
```
select r.name region_names,a.name account_name,round(cast(total_amt_usd/nullif(total,0) as numeric),4)
from sales_reps s
JOIN accounts a
on a.sales_rep_id=s.id
JOIN region r
on r.id=s.region_id
JOIN orders o
on o.account_id=a.id
where standard_qty>100 and poster_qty>50
ORDER BY 3 DESC;
```

*Q41:What are the different channels used by account id 1001? Your final table should have only 2 columns: account name and the different channels. You can try SELECT DISTINCT to narrow down the results to only the unique values.
```
select DISTINCT a.name account_name, w.channel channels
from accounts a
JOIN web_events w
on a.id=w.account_id
where a.id = 1001;
```

*Q42:Find all the orders that occurred in 2015. Your final table should have 4 columns: occurred_at, account name, order total, and order total_amt_usd.*
```
select o.occurred_at, a.name,o.total,o.total_amt_usd
from orders o
JOIN accounts a
on  o.account_id=a.id
where date_part('year',cast(occurred_at as date)) = 2016
ORDER BY 1;
```

## SQL Aggregations

### SUM

*Q43:Find the total amount of poster_qty paper ordered in the orders table.*
```
select SUM(poster_qty)
from orders;
```

*Q44:Find the total amount of standard_qty paper ordered in the orders table.*
```
select SUM(standard_qty)
from orders;
```

*Q45:Find the total dollar amount of sales using the total_amt_usd in the orders table.*
```
select SUM(total_amt_usd)
from orders;
```

*Q46:Find the total amount spent on standard_amt_usd and gloss_amt_usd paper for each order in the orders table. This should give a dollar amount for each order in the table.*
```
select id,standard_amt_usd,gloss_amt_usd
from orders;
```

*Q47:Find the standard_amt_usd per unit of standard_qty paper. Your solution should use both an aggregation and a mathematical operator.*
```
select id, round(cast(standard_amt_usd/nullif(standard_qty,0) as numeric),2)
from orders;
```

### MIN, MAX, & AVG

*Q48:When was the earliest order ever placed? You only need to return the date.*
```
select MIN(occurred_at)
from orders;
```

*Q49:Try performing the same query as in question 1 without using an aggregation function.*
```
select occurred_at
from orders
ORDER BY 1
limit 1;
```

*Q50:When did the most recent (latest) web_event occur?*
```
select max(occurred_at)
from web_events;
```

*Q51:Try to perform the result of the previous query without using an aggregation function.*
```
select occurred_at
from web_events
ORDER BY 1
limit 1;
```

*Q52:Find the mean (AVERAGE) amount spent per order on each paper type, as well as the mean amount of each paper type purchased per order. Your final answer should have 6 values - one for each paper type for the average number of sales, as well as the average amount.*
```
select AVG(standard_amt_usd),avg(poster_amt_usd),avg(gloss_amt_usd)
from orders;
```

*Q53:Via the video, you might be interested in how to calculate the MEDIAN. Though this is more advanced than what we have covered so far try finding - what is the MEDIAN total_usd spent on all orders?*
```
SELECT *
FROM (SELECT total_amt_usd
         FROM orders
         ORDER BY total_amt_usd
         LIMIT 
                 (select count(*)/2
                    from orders)) AS Table1
ORDER BY total_amt_usd DESC
LIMIT 2;
```

### GROUP BY

*Q54:Which account (by name) placed the earliest order? Your solution should have the account name and the date of the order.*
```
select a.name account_name, MIN(o.occurred_at) earliest_order
from accounts a
JOIN orders o
on  a.id=o.account_id
GROUP BY a.name;
```

*Q55:Find the total sales in usd for each account. You should include two columns - the total sales for each company's orders in usd and the company name.*
```
select a.name account_name, SUM(total_amt_usd) total_sales
from accounts a
JOIN orders o
on  a.id=o.account_id
GROUP BY a.name;
```

*Q56:Via what channel did the most recent (latest) web_event occur, which account was associated with this web_event? Your query should return only three values - the date, channel, and account name.*
```
select w.channel channels, a.name account_name,max(w.occurred_at) dates
FROM accounts a
JOIN web_events w
on  a.id=w.account_id
GROUP BY w.channel,a.name;
```

*Q57:Find the total number of times each type of channel from the web_events was used. Your final table should have two columns - the channel and the number of times the channel was used.*
```
select channel, count(*)
from web_events
GROUP BY channel;
```

*Q58:Who was the primary contact associated with the earliest web_event?*
```
select primary_poc,MIN(occurred_at) earliest_event
from web_events w
JOIN accounts a
on w.account_id=a.id
GROUP BY primary_poc;
```

*Q59:What was the smallest order placed by each account in terms of total usd. Provide only two columns - the account name and the total usd. Order from smallest dollar amounts to largest.*
```
select a.name, min(total_amt_usd)
from orders o
JOIN accounts a
on   a.id=o.account_id
GROUP BY a.name
order BY 2;
```

*Q60:Find the number of sales reps in each region. Your final table should have two columns - the region and the number of sales_reps. Order from fewest reps to most reps.*
```
select region_id, count(*)
from sales_reps
GROUP BY region_id;
```

*Q61:For each account, determine the average amount of each type of paper they purchased across their orders. Your result should have four columns - one for the account name and one for the average quantity purchased for each of the paper types for each account.*
```
select a.name ,avg(standard_qty),avg(gloss_qty),avg(poster_qty)
from accounts a
JOIN orders o
on  a.id=o.account_id
GROUP BY a.name;
```

*Q62:For each account, determine the average amount spent per order on each paper type. Your result should have four columns - one for the account name and one for the average amount spent on each paper type.*
```
select a.name ,avg(standard_amt_usd),avg(gloss_amt_usd),avg(poster_amt_usd)
from accounts a
JOIN orders o
on  a.id=o.account_id
GROUP BY a.name;
```

*Q63:Determine the number of times a particular channel was used in the web_events table for each sales rep. Your final table should have three columns - the name of the sales rep, the channel, and the number of occurrences. Order your table with the highest number of occurrences first.*
```
select s.name,w.channel,count(*)
from web_events w
JOIN accounts a
on  w.account_id=a.id
JOIN sales_reps s
on a.sales_rep_id=s.id
GROUP BY s.name,w.channel
order BY 3 desc;
```

*Q64:Determine the number of times a particular channel was used in the web_events table for each region. Your final table should have three columns - the region name, the channel, and the number of occurrences. Order your table with the highest number of occurrences first.*
```
select r.name, w.channel,count(*)
from web_events w
JOIN accounts a
on  w.account_id=a.id
JOIN sales_reps s
on a.sales_rep_id=s.id
JOIN region r
on r.id=s.region_id
GROUP BY r.name,w.channel
ORDER BY 3 desc;
```

### DISTINCT

*Q65:Use DISTINCT to test if there are any accounts associated with more than one region.*
```
(select name
from accounts
=
select DISTINCT name
from accounts);
```

*Q66:Have any sales reps worked on more than one account?*
```
select DISTINCT id
from sales_reps;
```

### HAVING

*Q67:How many of the sales reps have more than 5 accounts that they manage?*
```
SELECT sales_rep_id, count(*)
FROM accounts
GROUP BY sales_rep_id
HAVING COUNT(*) >= 5;
```

*Q68:How many accounts have more than 20 orders?*
```
SELECT a.name, count(o.id)
FROM orders o
JOIN accountS a
on a.id=o.account_id
GROUP BY a.name
HAVING count(o.id)>= 20;
```

*Q69:Which account has the most orders?*
```
select a.name, count(o.id)
FROM orders o
JOIN accountS a
on a.id=o.account_id
GROUP BY 1
order BY 2 desc
limit 1;
```

*Q70:Which accounts spent more than 30,000 usd total across all orders?*
```
select a.name, sum(total_amt_usd) 
FROM orders o
JOIN accountS a
on a.id=o.account_id
GROUP BY 1
HAVING sum(total_amt_usd) > 30000;
```

*Q71:Which accounts spent less than 1,000 usd total across all orders?*
```
select a.name, sum(total_amt_usd) 
FROM orders o
JOIN accountS a
on a.id=o.account_id
GROUP BY 1
having sum(total_amt_usd) <=1000;
```

*Q72:Which account has spent the most with us?*
```
select a.name, sum(total_amt_usd)
FROM orders o
JOIN accountS a
on a.id=o.account_id
GROUP BY 1
order by 2 desc
limit 1;
```

*Q73:Which account has spent the least with us?*
```
select a.name, sum(total_amt_usd)
FROM orders o
JOIN accountS a
on a.id=o.account_id
GROUP BY 1
order by 2 
limit 1;
```

*Q74:Which accounts used facebook as a channel to contact customers more than 6 times?*
```
select a.name,w.channel, count(*)
FROM web_events w
JOIN accountS a
on a.id=w.account_id
GROUP BY a.name,w.channel
having count(*) > 6 and w.channel = 'facebook';
```

*Q75:Which account used facebook most as a channel?*
```
select a.name,w.channel, count(*)
FROM web_events w
JOIN accountS a
on a.id=w.account_id
GROUP BY a.name,w.channel
having w.channel = 'facebook'
order BY 3 desc
limit 1;
```

*Q76:Which channel was most frequently used by most accounts?*
```
select a.name,w.channel, count(*)
FROM web_events w
JOIN accountS a
on a.id=w.account_id
GROUP BY a.name,w.channel
order BY 3 desc
limit 10;
```

### DATE Functions

*Q77:Find the sales in terms of total dollars for all orders in each year, ordered from greatest to least. Do you notice any trends in the yearly sales totals?*
 ```
select date_part('year',cast(occurred_at as DATE)), sum(total_amt_usd)
from orders 
GROUP BY 1
order BY 1 ;
```

*Q78:Which month did Parch & Posey have the greatest sales in terms of total dollars? Are all months evenly represented by the dataset?*
```
select date_trunc('month',cast(occurred_at as date)), sum(total_amt_usd)
from orders
GROUP BY 1
order by 1;
```

*Q79:Which year did Parch & Posey have the greatest sales in terms of total number of orders? Are all years evenly represented by the dataset?*
```
select date_part('year',cast(occurred_at as DATE)), sum(total)
from orders 
GROUP BY 1
order BY 1;
```

*Q80:Which month did Parch & Posey have the greatest sales in terms of total number of orders? Are all months evenly represented by the dataset?*
```
select date_trunc('month',cast(occurred_at as date)), sum(total)
from orders
GROUP BY 1
order by 1;
```

*Q81:In which month of which year did Walmart spend the most on gloss paper in terms of dollars?*
```
select date_trunc('month',cast(occurred_at as date)),max(gloss_amt_usd)
from orders o
JOIN accounts a
on o.account_id=a.id
where a.name = 'Walmart'
GROUP BY 1
order BY 2 desc
limit 1;
```


### CASE

*Q82:Write a query to display for each order, the account ID, total amount of the order, and the level of the order - ‘Large’ or ’Small’ - depending on if the order is $3000 or more, or smaller than $3000.*
```
SELECT a.id,total_amt_usd,
        CASE when total_amt_usd >= 3000 then 'Large'
        else 'Small'
        end as level_of_order
FROM orders O
JOIN accounts a
on o.account_id=a.id;
```

*Q83:Write a query to display the number of orders in each of three categories, based on the total number of items in each order. The three categories are: 'At Least 2000', 'Between 1000 and 2000' and 'Less than 1000'.*
```
select account_id, total,
        CASE when total >=2000 then 'At Lease 2000'
        when total >= 1000 and total <2000 then 'Between 1000 and 2000'
        else 'Less than 1000'
        end as Categories
from orders;
```

*Q84:We would like to understand 3 different levels of customers based on the amount associated with their purchases. The top level includes anyone with a Lifetime Value (total sales of all orders) greater than 200,000 usd. The second level is between 200,000 and 100,000 usd. The lowest level is anyone under 100,000 usd. Provide a table that includes the level associated with each account. You should provide the account name, the total sales of all orders for the customer, and the level. Order with the top spending customers listed first.*
```
with cte_customer_level
as
(
select a.name customer_name,sum(o.total_amt_usd) total_sales
from accounts a
JOIN orders o
on o.account_id=a.id
GROUP BY 1
)
select *,
        case when total_sales >= 200000 then 'Lifetime Value'
        when total_sales >=100000 and total_sales <200000 then 'second level'
        else  'Lowest level'
        end as customer_levels
from cte_customer_level
ORDER BY 2 desc;
```

*Q85:We would now like to perform a similar calculation to the first, but we want to obtain the total amount spent by customers only in 2016 and 2017. Keep the same levels as in the previous question. Order with the top spending customers listed first.*
```
with cte_customer_level
as
(
select a.name customer_name,sum(o.total_amt_usd) total_sales
from accounts a
JOIN orders o
on o.account_id=a.id
where o.occurred_at between '2016' and '2017'
GROUP BY 1
)
select *,
        case when total_sales >= 200000 then 'Lifetime Value'
        when total_sales >=100000 and total_sales <200000 then 'second level'
        else  'Lowest level'
        end as customer_levels
from cte_customer_level
ORDER BY 2 desc;
```

*Q86:We would like to identify top performing sales reps, which are sales reps associated with more than 200 orders. Create a table with the sales rep name, the total number of orders, and a column with top or not depending on if they have more than 200 orders. Place the top sales people first in your final table.*
```
with cte_reps_levels
as
(
select s.name reps_name, count(o.id) num_orders
from accounts a
JOIN orders o
on a.id=o.account_id
JOIN sales_reps s
on s.id=a.sales_rep_id
GROUP BY 1
)
select *,
        case when num_orders >= 200 then 'Top Seller'
        else 'null'
        end as level_reps
from cte_reps_levels
where num_orders >= 200
ORDER BY 2 desc;
```

*Q87:The previous didn't account for the middle, nor the dollar amount associated with the sales. Management decides they want to see these characteristics represented as well.We would like to identify top performing sales reps, which are sales reps associated with more than 200 orders or more than 750000 in total sales. The middle group has any rep with more than 150 orders or 500000 in sales. Create a table with the sales rep name, the total number of orders, total sales across all orders, and a column with top, middle, or low depending on this criteria. Place the top sales people based on dollar amount of sales first in your final table. You might see a few upset sales people by this criteria!*
```
with cte_reps_levels
as
(
select s.name reps_name, count(o.id) num_orders,sum(total_amt_usd) sales_amount
from accounts a
JOIN orders o
on a.id=o.account_id
JOIN sales_reps s
on s.id=a.sales_rep_id
GROUP BY 1
)
select *,
        case when num_orders > 200 or sales_amount >750000 then 'Top Seller'
        when num_orders > 150 or sales_amount >500000 then 'Mid Seller'
        else 'Low Seller'
        end as level_reps
from cte_reps_levels
--where num_orders <150 --just for double check the answers
--ORDER BY 3 desc; --just for double check the answers
```


## SQL Subqueries & Temporary Tables

### Subqueries

*Q88:Provide the(name of the sales_rep) (in each region with the largest amount of total_amt_usd sales).*
```
select s.name  reps_name,r.name region_name, sum(o.total_amt_usd)
from accounts a
JOIN orders o
on  a.id=o.account_id
JOIN sales_reps s
on s.id=a.sales_rep_id
JOIN region r
on r.id=s.region_id
GROUP BY 1,2
order BY 3 desc;
```

*Q89:For the region with the largest (sum) of sales total_amt_usd, how many total (count) orders were placed?*
```
select count(o.id)
from accounts a
        JOIN orders o
        on  a.id=o.account_id
        JOIN sales_reps s
        on s.id=a.sales_rep_id
        JOIN region r
        on r.id=s.region_id
where r.name =
(select region_names
    from 
        (select r.name region_names ,sum(total_amt_usd) total_sales
        from accounts a
        JOIN orders o
        on  a.id=o.account_id
        JOIN sales_reps s
        on s.id=a.sales_rep_id
        JOIN region r
        on r.id=s.region_id
        GROUP BY 1
        order BY 2 DESC
        limit 1) top_sales_region
);
```

*Q90:How many accounts had more total purchases than the (account name which has bought the most standard_qty paper) throughout their lifetime as a customer?*
```
select count(*)
from
    (select a.name, sum(total) total_purchase
    from accounts a
            JOIN orders o
            on  a.id=o.account_id
            GROUP BY 1
    having sum(total) >
    (select total_std_purcahse
        from
            (select a.name acc_name, sum(standard_qty) total_std_purcahse
            from accounts a
            JOIN orders o
            on  a.id=o.account_id
            GROUP BY 1
            order BY 2 desc
            limit 1) sub1
        ) ) sub2;
```

*Q91:For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd, how many web_events did they have for each channel?*
```
select a.name,w.channel, count(*)
from web_events w
JOIN accounts a
on a.id=w.account_id
where a.name = 
    (select cus_name
    from
        (select a.name cus_name, sum(total_amt_usd)
        from orders o
        JOIN accounts a
        on o.account_id=a.id
        GROUP BY 1
        order by 2 desc
        limit 1) sub1)
GROUP BY 1,2
order BY 2;
```

*Q92:What is the (lifetime average amount spent in terms of total_amt_usd ) for the (top 10 total spending accounts)?*
```
select avg(top_sales)
from (select top_sales
        from
        (select a.name cus_name, sum(total_amt_usd) top_sales
        from accounts   a
        JOIN orders o
        on a.id=o.account_id
        GROUP BY 1
        order BY 2 desc
        limit 10) sub1) sub2;
```

*Q93:What is the lifetime average amount spent in terms of total_amt_usd, including only the companies that spent more per order, on average, than the average of all orders.*
```
select avg(total_amt_usd)
from orders o
JOIN accounts a
on a.id=o.account_id
where a.name in
        (select cus_name
        from
            (select a.name cus_name, avg(total_amt_usd)
            from orders o
            JOIN accounts a
            on a.id=o.account_id
            GROUP BY 1
            having avg(total_amt_usd) >
                    (select avg(total_amt_usd)
                    from orders))sub1);
```


### CTE
### WITH

*Q94:Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.*
```
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
    GROUP BY 1)
select t1.reps_name, t1.reg_name,t1.total_sales
from t1
JOIN t2
on t1.reg_name=t2.reg_name AND t1.total_sales=t2.total_sales;
```

*Q95:For the region with the largest sales total_amt_usd, how many total orders were placed?*
```
with
t1
as
    (select r.name reg_name,sum(total_amt_usd) total_sales
    from accounts a
    JOIN orders o
    on a.id=o.account_id
    JOIN sales_reps s
    on s.id=a.sales_rep_id
    JOIN region r
    on r.id=s.region_id
    GROUP BY 1
    order BY 2 desc
    limit 1),
t2
as
    (select t1.reg_name 
    from t1)
select r.name, count(o.id)
from accounts a
    JOIN orders o
    on a.id=o.account_id
    JOIN sales_reps s
    on s.id=a.sales_rep_id
    JOIN region r
    on r.id=s.region_id
    GROUP BY 1
    having r.name = (SELECT * from t2);
```

*Q96:How many accounts had more total purchases than the account name which has bought the most standard_qty paper throughout their lifetime as a customer?*
```
with
t1
as
    (select a.name, sum(standard_qty ) total_std_qty
    from accounts a
        JOIN orders o
        on a.id=o.account_id
        GROUP BY 1
        ),
t2
as
    (select max(t1.total_std_qty)
    from t1),
t3
as
    (select a.name, sum(total)
    from accounts a
    JOIN orders o
    on a.id=o.account_id
    GROUP BY 1
    having sum(total) > (SELECT* FROM t2))
select count(*)
from t3;
```

*Q97:For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd, how many web_events did they have for each channel?*
```
with
t1
    as
    (select a.name cus_name, sum(total_amt_usd) total_sales
    from accounts a
    JOIN orders o
    on a.id=o.account_id
    GROUP BY 1
    order BY 2 desc
    limit 1)
select a.name,w.channel, COUNT(*)
from web_events w
JOIN accounts a
on a.id=w.account_id and a.name = (select cus_name from t1)
GROUP BY 1,2;
```

*Q98:What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts?*
```
WITH 
T1 AS
    (SELECT A.NAME cus_name, SUM(total_amt_usd) TOP_SALES
    FROM orders O
    JOIN accountS A
    ON A.id= O.account_id
    GROUP BY 1
    ORDER BY 2 DESC
    LIMIT 10)
SELECT AVG(TOP_SALES)
FROM T1;
```

*Q99:What is the lifetime average amount spent in terms of total_amt_usd, including only the companies that spent more per order, on average, than the average of all orders.*
```    
with
t1 as
    (SELECT AVG(o.total_amt_usd)
    FROM orders o
    JOIN accounts a
    on a.id=o.account_id),
t2 as
    (select a.name cus_name, avg(total_amt_usd) avg_per
    FROM orders o
    JOIN accounts a
    on a.id=o.account_id
    GROUP BY 1),
t3 as
    (select t2.cus_name,t2.avg_per
    from t2
    where t2.avg_per > (select* from t1)
    )
select avg(total_amt_usd)
FROM orders o
JOIN accounts a
on a.id=o.account_id
where a.name in (select cus_name from t3);
```

## SQL Data Cleaning

### LEFT & RIGHT

*Q100:In the accounts table, there is a column holding the website for each company. The last three digits specify what type of web address they are using. A list of extensions (and pricing) is provided here. Pull these extensions and provide how many of each website type exist in the accounts table.*
```
select  RIGHT(website,3), count(*)
from accountS
group BY 1;
```

*Q101:There is much debate about how much the name (or even the first letter of a company name) matters. Use the accounts table to pull the first letter of each company name to see the distribution of company names that begin with each letter (or number).*
```
select left(name,1) firstletter_company, COUNT(*)
from accounts
GROUP BY 1;
```

*Q102:Use the accounts table and a CASE statement to create two groups: one group of company names that start with a number and a second group of those company names that start with a letter. What proportion of company names start with a letter?*
```
with t1 as
    (
    select 
            case when  left(name,1) in ('0','1','2','3','4','5','6','7','8','9') then 1
            else '0' 
            end as num,
            case when left(name,1) in ('0','1','2','3','4','5','6','7','8','9') then 0
            else '1' 
            end as letter
        
    from accounts
    )
select SUM(num) nums, sum(letter) letters, round(cast(sum(num) as numeric)/cast(sum(letter) as numeric)*100,2) percentage
from t1;
```

*Q103:Consider vowels as a, e, i, o, and u. What proportion of company names start with a vowel, and what percent start with anything else?*
```
with t1
as
(

    select 
            case when left(lower(name),1) in ('a','e','i','o','u') then 1
            else 0
            end as spc_name,
            case when left(lower(name),1) in ('a','e','i','o','u') then 0
            else 1
            end as nonspc_name
    from accounts
)

select sum(spc_name),sum(nonspc_name), round(sum(cast(spc_name as numeric))/(sum(cast(spc_name as numeric))+sum(cast(nonspc_name as numeric)))*100,2) percentage
from t1;
```

### POSITION, STRPOS, & SUBSTR

*Q104:Use the accounts table to create first and last name columns that hold the first and last names for the primary_poc.*
```
select primary_poc, left(primary_poc, STRPOS(primary_poc,' ')-1) first_name,SUBSTR(primary_poc,STRPOS(primary_poc,' ')+1) as last_name
from accounts;
```

*Q105:Now see if you can do the same thing for every rep name in the sales_reps table. Again provide first and last name columns.*
```
select name, left(name,STRPOS(name,' ')-1) first_name, SUBSTR(name,STRPOS(name,' ')+1) last_name
from sales_reps;
```

### CONCAT & REPLACE

*Q106:Each company in the accounts table wants to create an email address for each primary_poc. The email address should be the first name of the primary_poc . last name primary_poc @ company name .com.*
```
--company email address should base on their domain name. not all email address should end up with .com according data records.
select primary_poc, name, CONCAT(left(primary_poc,STRPOS(primary_poc,' ')-1),'.',SUBSTR(primary_poc,STRPOS(primary_poc,' ')+1),'@',SUBSTR(website,STRPOS(website, '.')+1)) emails
FROM accounts ;
--OR
select primary_poc, name, CONCAT(Replace(primary_poc,' ','.'),'@',SUBSTR(website,STRPOS(website, '.')+1)) emails
FROM accounts;
```

*Q107:You may have noticed that in the previous solution some of the company names include spaces, which will certainly not work in an email address.See if you can create an email address that will work by removing all of the spaces in the account name, but otherwise your solution should be just as in question 1. Some helpful documentation is here.*
```
select replace(name,' ','')
from accounts;
```

*Q108:We would also like to create an initial password, which they will change after their first log in. The first password will be the first letter of the primary_poc's first name (lowercase), then the last letter of their first name (lowercase), the first letter of their last name (lowercase), the last letter of their last name (lowercase), the number of letters in their first name, the number of letters in their last name, and then the name of the company they are working with, all capitalized with no spaces.*
```
with t1 as(

select primary_poc, left(lower(primary_poc),1) fl_fn ,right(left(lower(primary_poc), STRPOS(primary_poc,' ')-1),1) ll_fn,
        right(lower(primary_poc),1) ll_ln, (STRPOS(primary_poc,' ')-1) num_fn,length(SUBSTR(primary_poc,STRPOS(primary_poc,' ')+1)) num_ln,
        UPPER(replace(name,' ','')) company_name
from accounts
)
select CONCAT(fl_fn,ll_fn,ll_ln,num_fn,num_ln,company_name)
from t1;
```

### COALESCE
(same with isnull function in ms sql)
```
select a.id,COALESCE(o.total,'123'),a.primary_poc
from accounts a
left JOIN orders o
on a.id=o.account_id
where o.total is null;
```

## [Advanced] SQL Window Functions

### OVER 

*Q109:Using Derek's previous video as an example, create another running total. This time, create a running total of standard_amt_usd (in the orders table) over order time with no date truncation. Your final table should have two columns: one with the amount being added for each new row, and a second with the running total.*
```
select occurred_at, standard_amt_usd,
        sum(standard_amt_usd) over (ORDER BY occurred_at)
from orders;
```

### PARTITION BY

*Q110:Now, modify your query from the previous quiz to include partitions. Still create a running total of standard_amt_usd (in the orders table) over order time, but this time, date truncate occurred_at by year and partition by that same year-truncated occurred_at variable. Your final table should have three columns: One with the amount being added for each row, one for the truncated date, and a final column with the running total within each year.*
```
select date_trunc('year', cast(occurred_at as date)) dates, standard_amt_usd std_amount,
        sum(standard_amt_usd) over (partition by date_trunc('year', cast(occurred_at as date)) ORDER BY occurred_at )
from orders;
```

### ROW_NUMBER & RANK

*Q111:Select the id, account_id, and total variable from the orders table, then create a column called total_rank that ranks this total amount of paper ordered (from highest to lowest) for each account using a partition. Your final table should have these four columns.*
```
select id, account_id,total,
        ROW_NUMBER() over (partition by account_id ORDER BY total desc) as total_rank
from orders;
```

### Aggregates in Window Functions
```
SELECT id,
       account_id,
       standard_qty,
       DATE_TRUNC('month', cast(occurred_at as date)) AS month,
       rank() OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',cast(occurred_at as date))) AS norm_rank, -- not count rank side by side
       DENSE_RANK() OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',cast(occurred_at as date))) AS dense_rank,-- count rank side by side in sequence
       SUM(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',cast(occurred_at as date))) AS sum_std_qty,
       COUNT(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',cast(occurred_at as date))) AS count_std_qty,
       AVG(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',cast(occurred_at as date))) AS avg_std_qty,
       MIN(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',cast(occurred_at as date))) AS min_std_qty,
       MAX(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',cast(occurred_at as date))) AS max_std_qty
FROM orders
```

*Q112:Remove Order by --without ORDER BY, each column's value is simply an aggregation (e.g., sum, count, average, minimum, or maximum) of all the standard_qty values in its respective account_id.*
```
SELECT id,
       account_id,
       standard_qty,
       DATE_TRUNC('month', cast(occurred_at as date)) AS month,
       DENSE_RANK() OVER (PARTITION BY account_id ) AS dense_rank,
       SUM(standard_qty) OVER (PARTITION BY account_id ) AS sum_std_qty,
       COUNT(standard_qty) OVER (PARTITION BY account_id ) AS count_std_qty,
       AVG(standard_qty) OVER (PARTITION BY account_id  ) AS avg_std_qty,
       MIN(standard_qty) OVER (PARTITION BY account_id ) AS min_std_qty,
       MAX(standard_qty) OVER (PARTITION BY account_id ) AS max_std_qty
FROM orders;
```

### Aliases for MULTIPLE WINDOW FUNCTIONS
```
SELECT id,
       account_id,
       standard_qty,
       DATE_TRUNC('month', cast(occurred_at as date)) AS month,
       rank() OVER W1 AS norm_rank, 
       DENSE_RANK() OVER W1 AS dense_rank,
       SUM(standard_qty) OVER W1 AS sum_std_qty,
       COUNT(standard_qty) OVER W1 AS count_std_qty,
       AVG(standard_qty) OVER W1 AS avg_std_qty,
       MIN(standard_qty) OVER W1 AS min_std_qty,
       MAX(standard_qty) OVER W1 AS max_std_qty
FROM orders
WINDOW W1 AS (PARTITION BY account_id ORDER BY DATE_TRUNC('month',cast(occurred_at as date)));
```
*Q113:Practice*
```
SELECT id,
       account_id,
       DATE_TRUNC('year',CAST(occurred_at AS DATE)) AS year,
       DENSE_RANK() OVER W1 AS dense_rank,
       total_amt_usd,
       SUM(total_amt_usd) OVER W1 AS sum_total_amt_usd,
       COUNT(total_amt_usd) OVER W1 AS count_total_amt_usd,
       AVG(total_amt_usd) OVER W1 AS avg_total_amt_usd,
       MIN(total_amt_usd) OVER W1 AS min_total_amt_usd,
       MAX(total_amt_usd) OVER W1 AS max_total_amt_usd
FROM orders
WINDOW W1 AS (PARTITION BY account_id ORDER BY DATE_TRUNC('year',CAST(occurred_at AS DATE)));
```

*Q114:Practice, account id. total sum, date.*
```
with
t1 as
    (
    select account_id, total, date_trunc('month', cast(occurred_at as date)),
            lag(total) over w1 as previous_total,
            lead(total) over w1 as next_total
    from orders
    Window w1 as (partition by account_id order BY date_trunc('month', cast(occurred_at as date)))
    )
select *, total - previous_total as different_previous, total - next_total as different_next
from t1;
```

### PERCENTILE

*Q115:Use the NTILE functionality to divide the accounts into 4 levels in terms of the amount of standard_qty for their orders. Your resulting table should have the account_id, the occurred_at time for each order, the total amount of standard_qty paper purchased, and one of four levels in a standard_quartile column.*
```
SELECT id,
       account_id,
       standard_qty,
       DATE_TRUNC('month', cast(occurred_at as date)) AS month,
       NTILE(4) OVER (PARTITION BY account_id ORDER BY standard_qty)

from orders;
```

*Q116:Use the NTILE functionality to divide the accounts into two levels in terms of the amount of gloss_qty for their orders. Your resulting table should have the account_id, the occurred_at time for each order, the total amount of gloss_qty paper purchased, and one of two levels in a gloss_half column.*
```
SELECT id,
       account_id,
       gloss_qty,
       DATE_TRUNC('month', cast(occurred_at as date)) AS month,
       NTILE(2) OVER (PARTITION BY account_id ORDER BY gloss_qty)

from orders;
```

*Q117:Use the NTILE functionality to divide the orders for each account into 100 levels in terms of the amount of total_amt_usd for their orders. Your resulting table should have the account_id, the occurred_at time for each order, the total amount of total_amt_usd paper purchased, and one of 100 levels in a total_percentile column.*
```
SELECT id,
       account_id,
       total_amt_usd,
       DATE_TRUNC('month', cast(occurred_at as date)) AS month,
       NTILE(100) OVER (PARTITION BY account_id ORDER BY total_amt_usd)
from orders;
```

## [Advanced] SQL Advanced JOINs & Performance Tuning

### FULL OUTER JOIN

*Q118:each account who has a sales rep and each sales rep that has an account (all of the columns in these returned rows will be full)*
```
select *
from accounts a
full outer join sales_reps s
on a.sales_rep_id=s.id;
```

*Q119:but also each account that does not have a sales rep and each sales rep that does not have an account (some of the columns in these returned rows will be empty)*
```
select *
FROM accounts a
full outer join sales_reps s
on  a.sales_rep_id=s.id
Where a.sales_rep_id is null or s.id is null;
```

### JOINs with Comparison Operators--Inequality JOINs

*Q120In the following SQL Explorer, write a query that left joins the accounts table and the sales_reps tables on each sale rep's ID number and joins it using the < comparison operator on accounts.primary_poc and sales_reps.name, like so:(https://stackoverflow.com/questions/26080187/sql-string-comparison-greater-than-and-less-than-operators/26080240#26080240)*
```
select a.name,a.primary_poc,s.name
from accounts a
left join sales_reps s
on a.sales_rep_id=s.id  and a.primary_poc < s.name
where a.name = 'Walmart';
```

### Self JOINs 

*Q121:change the interval to 1 day to find those web events that occurred after, but not more than 1 day after, another web event add a column for the channel variable in both instances of the table in your query*
```
--too hard to understand

SELECT we1.id AS we_id,
       we1.account_id AS we1_account_id,
       we1.occurred_at AS we1_occurred_at,
       we1.channel AS we1_channel,
       we2.id AS we2_id,
       we2.account_id AS we2_account_id,
       we2.occurred_at AS we2_occurred_at,
       we2.channel AS we2_channel
  FROM web_events we1 
 LEFT JOIN web_events we2
   ON we1.account_id = we2.account_id
  AND we1.occurred_at > we2.occurred_at
  AND we1.occurred_at <= we2.occurred_at + INTERVAL '1 day'
ORDER BY we1.account_id, we2.occurred_at;
```

### UNION

```
SELECT *
FROM accounts
UNION all
select *
from accounts;
```

*Q122:Add a WHERE clause to each of the tables that you unioned in the query above, filtering the first table where name equals Walmart and filtering the second table where name equals Disney. Inspect the results then answer the subsequent quiz.*
```
select *
from accounts 
where name = 'Walmart'
UNION all
select *
from accounts
where name ='Disney';
```

*Q123:Perform the union in your first query (under the Appending Data via UNION header) in a common table expression and name it double_accounts. Then do a COUNT the number of times a name appears in the double_accounts table. If you do this correctly, your query results should have a count of 2 for each name.*
```
with 
t1 as
(
    select *
    from accounts
    UNION all
    select *
    from accounts
)
select name,count(*)
FROM t1
GROUP BY 1
order by 2;
```

### Performance Tuning
```
--1.limit time can provide more performance in query
--2.limit function in aggragation function query do not provide better proformance becasuse limit is the last fucntion to be processed.
--using subquery to limit amount of data set to be aggragated will perform much better.
--3. making Joins less complicated. and reduce tables size before joining them.
--4.EXPLAIN function to check how much cost of runtime for query.

--practice, count(id),(rep_id),(order_id),(web_id) by date(day)

--low performace query.
select DATE_TRUNC('day',cast(o.occurred_at as date)) as dates,
        count(DISTINCT a.id) as num_acc_id,
        count(DISTINCT a.sales_rep_id) as num_sal_id,
        count(DISTINCT o.id) as num_ord_id,
        count(DISTINCT w.id) as num_web_id
FROM orders o
join accounts a
on a.id=o.account_id
join web_events w
on DATE_TRUNC('day',cast(o.occurred_at as date)) = DATE_TRUNC('day',cast(w.occurred_at as date))
GROUP BY 1;
--see how many dataset before aggragating
select *
FROM orders o
join accounts a
on a.id=o.account_id
join web_events w
on  DATE_TRUNC('day',cast(o.occurred_at as date)) = DATE_TRUNC('day',cast(w.occurred_at as date))


--better performance solution
--joining the tables after aggragation.
```



