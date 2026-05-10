

-- SQL Retail Sales Analysis - P1


CREATE DATABASE retail_sales_project;


-- Create TABLE
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
            (
                transaction_id INT PRIMARY KEY,	
                sale_date DATE,	 
                sale_time TIME,	
                customer_id	INT,
                gender	VARCHAR(15),
                age	INT,
                category VARCHAR(15),	
                quantity	INT,
                price_per_unit FLOAT,	
                cogs	FLOAT,
                total_sale FLOAT
            );

SELECT * FROM retail_sales
LIMIT 10


    

SELECT 
    COUNT(*) 
FROM retail_sales


-- Data Cleaning
SELECT * FROM retail_sales
WHERE transactions_id IS NULL

SELECT * FROM retail_sales
WHERE sale_date IS NULL

SELECT * FROM retail_sales
WHERE sale_time IS NULL

SELECT * FROM retail_sales
WHERE 
    transaction_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
    
-- 
DELETE FROM retail_sales
WHERE 
    transaction_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;


-- Data Analysis & Business Key Problems & Answers



QUESTIONS:

Q1 - Write SQL query to retrive all columns for sales made on '2022-11-05'

select * from retail_sales
where date(sale_date) = "2022-11-05";

Q2 - Write a SQL query to retrive all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of 'Nov-2022'

SELECT *
FROM retail_sales
WHERE category = 'Clothing'
AND quantiy >= 4
AND sale_date >= '2022-11-01'
AND sale_date < '2022-12-01';


Q3 - Write a SQL query to calculate the total sales (total_sale) for each category.
    
Select Category, SUM(total_sale) as net_sale,
count(quantiy)
from retail_sales
group by Category;

Q4 - Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

Select Avg(age)
from retail_sales
where Category = "beauty"

Q5 - Write a SQL query to find all transactions where the total_sale is greater than 1000.

select * from retail_sales
where total_sale > 1000;

Q6 - Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select gender, category, count(transactions_id)
from retail_sales
group by gender, category
order by 1;

Q7 - Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

select year(sale_date), month(sale_date), avg(total_sale) from
(
select year(sale_date), month(sale_date), avg(total_sale),
rank() over(partition by extract(year from sale_date) order by avg(total_sale) desc) as rank
from retail_sales
group by 1,2
) as t1
where rank = 1;

Q8 - Write a SQL query to find the top 5 customers based on the highest total sales 
    
Select customer_id, sum(total_sale) from retail_sales
group by 1
order by 2 desc
limit 5;

Q9 - Write a SQL query to find the number of unique customers who purchased items from each category.

select category, count(distinct customer_id)as count_of_unique_cus 
from retail_sales
group by 1;

Q10 - Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

with hourly_sale
as
(
select *,
case 
    when hour(sale_time) < 12 then 'morning'
    when hour(sale_time) between 12 and 17 then 'afternoon'
    else 'evening'
    end as shift
    from retail_sales
    )
    select
    shift,
    count(*) as total_orders
    from hourly_sale
    group by shift;


----END OF PROJECT---
