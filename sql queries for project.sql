create database if not exists  salesdatapizza;
create table if not exists salesssalesssalesssaless(
    pizza_id INT PRIMARY KEY not null,
    order_id INT not null,
    pizza_name VARCHAR(255) not null,
    quantity INT not null,
    order_date DATE not null,
    order_time TIME not null,
    unit_price DECIMAL(10,2) not null,
    total_price DECIMAL(10,2) not null,
    pizza_size VARCHAR(50) not null ,
    pizza_category VARCHAR(50) not null,
    pizza_ingredients VARCHAR(50) NOT NULL,
    pizza_name_id varchar(50) not null
);

SELECT * FROM salesdatapizza.pizza_sales;

-- --------------------------QUERIES FOR KPI'S -------------------------------------------------------------
-- TOTAL REVENUE--
select sum(total_price) as total_revenue from pizza_sales; 

-- AVERAGE ORDER VALUE--
select  sum(total_price) / count(distinct order_id) as avg_order_value from pizza_sales;

-- total pizza sold--
select sum(quantity) as total_pizza_sold from pizza_sales;

-- total order--
select count(distinct order_id) as total_order from pizza_sales;

-- AVERAGE PIZZA PER ORDER--
select cast( sum(quantity) / count(distinct order_id) as decimal(10,2))
  as average_pizza_per_order from pizza_sales;

--   -----------------------CHARTS REQUIREMENT QUERY-----------------------------------------------------
-- DAILY TREND FOR TOTAL ORDER---
select date_format(order_date, "%W" ) as date_name, count(distinct order_id) as total_ordr 
from pizza_sales
group by date_format(order_date , "%W");

-- monthly trend for total orders-----
select date_format(order_date, "%M" ) as date_name, count(distinct order_id) as total_ordr 
from pizza_sales
group by date_format(order_date , "%M")
order by total_ordr desc;
 
 -- % OF SALES PER CATEGORY--
 select pizza_category,sum(total_price) as total_sales, sum(total_price) * 100 / ( select sum(total_price) from pizza_sales   where month(order_date)=1) as PCT
 from pizza_sales
 where month(order_date)=1
 group by pizza_category;
 
 -- % of pizza sales by pizza size-----------------
 select pizza_size,sum(total_price) as total_sales, cast(sum(total_price) * 100 / 
 ( select sum(total_price) from pizza_sales) as decimal (10,2))as PCT
 from pizza_sales
 group by pizza_size
 order by pct desc;
 
 -- top 5 best seller by total quantity,revenue, total orders-----
 select pizza_name, sum(total_price)as total_revenue 
 from pizza_sales
 group by pizza_name
 order by total_revenue desc
 limit 5;
 
 select pizza_name, sum(quantity )as top_quantity
 from pizza_sales
 group by pizza_name
 order by top_quantity desc
 limit 5; 
 
select pizza_name, count(distinct order_id )as top_order
 from pizza_sales
 group by pizza_name
 order by top_order desc
 limit 5;  
