SELECT * FROM walmartsalesdata.sales;

-- ------------------------------------------------------------
-- -------------------Feature Engineering----------------------
-- time_of_day
select time, 
(case 
when time Between "00:00:00" and "12:00:00" then "morning" 
when time Between "12:01:00" and "16:00:00" then "afternoon" 
else "evening" end) as time_of_day
from sales;

alter table sales add column time_of_day varchar(20);
update sales
set time_of_day = ( Case when time Between "00:00:00" and "12:00:00" then "morning" 
when time Between "12:01:00" and "16:00:00" then "afternoon" 
else "evening" end);

----- Day_name
alter table sales add column day_name varchar(20);
update sales
set day_name = dayname(date);
------ Month 
alter table sales add column month_name varchar(10);
update sales
set month_name = monthname(date);
-- -------------------------------------------------------------------
-- -------------------------------------------------------------------

-- ---------------- Generic Questions --------------------------------
-- How many unique cities does the data have?

select distinct city from sales ;

-- In which city is each branch?

select distinct city , branch from sales;

-- --------------------------------------------------------------------
-- --------------------------------------------------------------------


-- ------------------Product ------------------------------------------
-- How many unique product lines does the data have?

select count(distinct Product_line) from sales ;

-- What is the most common payment method?

select payment , count(payment) from sales group by payment ; 

-- What is the most selling product line? 

select product_line , count(product_line) as sale_quantity from sales group by product_line order by sale_quantity desc;

-- What is the total revenue by month? 

select month_name as month , sum(total) as revenue from sales group by month_name; 

-- What month had the largest COGS?

select month_name , sum(cogs)  from sales group by month_name order by sum(cogs) desc;

-- What product line had the largest revenue?

select product_line , sum(total) as revenue from sales group by product_line order by revenue desc ;

-- What is the city with the largest revenue?

select city , sum(total) from sales group by city order by sum(total) desc;

-- What product line had the largest VAT?

select product_line , avg(vat) from sales group by product_line order by avg(vat) desc;

-- Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales

select product_line , round(avg(total),2)  , (case when total > avg(total) then 'good' else 'bad' end) from sales group by product_line order by round(avg(total),2) desc;

-- Which branch sold more products than average product sold?

select branch , sum(quantity) , avg(quantity) from sales group by branch having sum(quantity) > avg(quantity) order by sum(quantity) desc;

-- What is the most common product line by gender?

select gender , product_line , count(gender) from sales group by gender , product_line order by count(gender) desc;

-- What is the average rating of each product line?

select product_line , round(avg(rating),3) from sales group by product_line order by avg(rating) desc; 
-- --------------------------------------------------------------------
-- --------------------------------------------------------------------


-- ------------------Sales --------------------------------------------

-- Number of sales made in each time of the day per weekday

select time_of_day , count(quantity) from sales where day_name = "Friday" group by time_of_day ;

-- Which of the customer types brings the most revenue?

select customer_type , sum(total) from sales group by customer_type order by sum(total) desc ;

-- Which city has the largest tax percent/ VAT (Value Added Tax)?

select city , avg(vat) from sales group by city order by avg(vat) desc ;

-- Which customer type pays the most in VAT?

select customer_type , avg(vat) from sales group by customer_type order by avg(vat) desc ;

-- --------------------------------------------------------------------
-- --------------------------------------------------------------------


-- ------------------Customers ----------------------------------------

-- How many unique customer types does the data have?

select distinct customer_type from sales;

-- How many unique payment methods does the data have?

select distinct payment from sales;

-- What is the most common customer type?

select customer_type , count(customer_type) from sales group by customer_type order by count(Customer_type) desc;

-- Which customer type buys the most?

select customer_type , sum(quantity) from sales group by Customer_type order by sum(quantity) desc;

-- What is the gender of most of the customers?

select customer_type , gender , count(Customer_type)  from sales group by customer_type , gender order by count(customer_type) desc;

-- What is the gender distribution per branch?

select branch , gender , count(gender) from sales group by branch , gender;

-- Which time of the day do customers give most ratings?

select time_of_day , avg(rating) from sales group by time_of_day order by avg(rating) desc;

-- Which time of the day do customers give most ratings per branch?

select time_of_day , branch , avg(rating) from sales group by time_of_day , branch order by avg(rating) desc;

-- Which day of the week has the best avg ratings?

select day_name , avg(rating) from sales group by day_name order by avg(rating) desc;

-- Which day of the week has the best average ratings per branch?

select day_name ,branch, avg(rating) from sales group by day_name , branch order by avg(rating) desc;

























































