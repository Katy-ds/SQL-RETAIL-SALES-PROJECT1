use retail_sales_project;
select * from retail_sales;
select count(*) from retail_sales;

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


Q3 - write sql query to calculate the Total sales for each category
Select Category, SUM(total_sale) as net_sale,
count(quantiy)
from retail_sales
group by Category;

Q4 - Average age of the custoemrs from beauty category
Select Avg(age)
from retail_sales
where Category = "beauty"

Q5 - find transactions where total sale is greater than 1000
select * from retail_sales
where total_sale > 1000;

Q6 - Total number of transactions made b each gender in each category
select gender, category, count(transactions_id)
from retail_sales
group by gender, category
order by 1;

Q7 - Average sale in each month. Find out best selling month in each year
select year(sale_date), month(sale_date), avg(total_sale) from
(
select year(sale_date), month(sale_date), avg(total_sale),
rank() over(partition by extract(year from sale_date) order by avg(total_sale) desc) as rank
from retail_sales
group by 1,2
) as t1
where rank = 1;

Q8 - Find top 5 customers based on highest total sales
Select customer_id, sum(total_sale) from retail_sales
group by 1
order by 2 desc
limit 5;

Q9 - find number of Unique customers who purchased items from each category
select category, count(distinct customer_id)as count_of_unique_cus 
from retail_sales
group by 1;

Q10 - find number of orders in each shift (ex Morning < 12, afternoon - between 12 and 17, else evening)
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