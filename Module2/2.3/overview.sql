--Total Sales
select sum(sales)
from orders o 

--Total Profit
select sum(profit)
from orders o 

--Profit Ratio
select round((sum(profit) / sum(sales))*100, 1) as percent
from orders o 

--Profit per Order
select sum(profit) / count(distinct o.order_id)
from orders o 

--Sales per Customer
select sum(sales) / count(distinct o.customer_id)
from orders o 

--Avg. Discount
select avg(discount)
from orders o 

--Monthly Sales by Segment 
select 
	date_trunc('month', order_date) as month,
	segment,
	sum(sales) as total_sales
from orders o 
group by month, segment
order by month

--Monthly Sales by Product Category 
select 
	date_trunc('month', order_date) as month,
	category,
	sum(sales) as total_sales
from orders o 
group by month, category 
order by month

--Sales by Product Category over time 
select 
	category,
	sum(sales) as total_sales,
	count(sales) as sales_count
from orders o 
group by category 
order by total_sales, sales_count

--Sales and Profit by Customer
select
	sum(sales) as total_sales, 
	sum(profit) as total_profit, 
	o.customer_id, 
	o.customer_name
from orders o 
group by customer_id , customer_name 
order by sum(sales) desc;

--Customer Ranking
select 
	customer_id,
	customer_name,	
	sum(profit) as total_profit
from orders o 
group by customer_id , customer_name 
order by total_profit desc
limit 10

--Sales per region
select sum(sales), state
from orders o 
group by state  
order by sum(sales) desc
