select gender, SUM(purchase_amount) as revenue from customer group by gender;
Select customer_id, purchase_amount from customer where discount_applied = 'Yes' and purchase_amount >= (select AVG(purchase_amount) from customer);
Select item_purchased, ROUND(AVG(review_rating),2) as "Average Product Rating" from customer 
group by item_purchased order by avg(review_rating) desc limit 5;
Select shipping_type, Round(AVG(purchase_amount),2) as "Average purchase amount by shipping type" 
from customer where shipping_type in ('Standard','Express')  group by shipping_type;

Select subscription_status, count(subscription_status), AVG(purchase_amount), SUM(purchase_amount) from customer group by subscription_status;
Select item_purchased, 
Round(100* SUM(CASE when discount_applied = 'Yes' Then 1 else 0 end)/Count(*), 2) as discount_rate
from  customer group by item_purchased order by discount_rate desc limit 5;

with item_counts as (
select category, item_purchased, count(customer_id) as total_orders,
row_number() over(partition by category order by count(customer_id) desc) as item_rank from customer
group by category, item_purchased
)
select item_rank, category, item_purchased, total_orders
from item_counts
where item_rank <=3;

select age_group, sum(purchase_amount) as total_revenue from customer group by age_group order by total_revenue desc;