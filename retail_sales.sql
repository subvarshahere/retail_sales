--SQL retail sales analysis
CREATE DATABASE project_1;

DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales 
		   (transactions_id int primary key,
			sale_date date, 
			sale_time time, 
			customer_id int,
			gender varchar(15),
			age int,
			category varchar(15),
			quantity int, 
			price_per_unit float, 
			cogs float, 
			total_sale float );
SELECT * FROM retail_sales where customer_id <10

SELECT
	COUNT(*)
	FROM retail_sales 

--how many sales do we have?
SELECT COUNT(*) as total_sale from retail_sales

--how many customers we have?
SELECT COUNT(distinct customer_id) as customers from retail_sales

select distinct category from retail_sales

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
SELECT * 
from retail_sales 
where sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022

SELECT *
from retail_sales
where category='Clothing' and quantity >= 4 and to_char(sale_date, 'YYYY-MM')='2022-11'

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT 
category,
sum(total_sale) as net_sale, 
count(*)as total_orders
FROM retail_sales group by 1

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT round(avg(age),2) as average_age from retail_sales
where category='Beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
Select * from retail_sales where total_sale>1000

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
Select category, gender, count(transactions_id) from retail_sales group by category, gender

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select 
extract (year from sale_date) as year, 
extract (month from sale_date) as month, avg(total_sale) as average_sales from retail_sales 
group by 1,2
order by 1,2;
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales
select customer_id, sum(total_sale) as total_sales 
from retail_sales 
group by 1
order by 2 desc 
limit 5

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

select count(distinct customer_id), category from retail_sales group by category
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

with hourly_sale
as 
(
select * , 
case
when extract(hour from sale_time) <12 then 'morning'
when extract(hour from sale_time) between 12 and 17 then 'afternoon'
else 'Evening' 
end as shift 
from retail_sales )
select shift, count(*) as total_orders from hourly_sale
group by shift


