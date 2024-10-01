-- https://www.namastesql.com/coding-problem/2-product-category


select category,count(*) as no_of_products from (
select *,
case when price < 100 then 'Low Price'
when price >= 100 and price <= 500 then 'Medium Price'
else 'High Price' end as category
from products ) X
group by category
order by no_of_products desc;

-- get penultimate order 

select order_id,order_date,customer_name,product_name,sales from (
select order_id,order_date,customer_name,product_name,sales,rnk,
case when max_rnk > 1 then max_rnk - 1
else max_rnk
end as rnk_fetch from (
select *,last_value(rnk) over (partition by customer_name order by rnk
                              rows between unbounded preceding and unbounded following) max_rnk from (
select *,dense_rank() over(partition by customer_name order by order_date )
rnk from orders)X ) Y ) Z
where rnk = rnk_fetch
order by customer_name ;

-- https://www.namastesql.com/coding-problem/52-loan-repayment
select loan_id,loan_amount,due_date,
case when loan_amount = amt_paid then 1 else 0 end as fully_paid_flag,
case when payment_date <= due_date then 1 else 0 end as on_time_flag
from (
select * from (
select *,dense_rank() over (partition by customer_id order by payment_date desc) payment_rnk from (

select *,sum(amount_paid) over (partition by customer_id  ) amt_paid from (

select l.customer_id,l.loan_id,l.loan_amount,p.amount_paid,l.due_date,p.payment_date
from loans l join payments p 
on l.loan_id = p.loan_id ) X ) Y ) Z
where payment_rnk = 1 ) B;


-- https://www.namastesql.com/coding-problem/26-dynamic-pricing
-- select * from products;
-- select * from orders;

select product_id,sum(price) as total_sales from (
select * from (
select *,dense_rank() over (partition by product_id,order_date order by date_diff) rnk from (
select p.product_id,p.price,p.price_date,o.order_date,abs(datediff(p.price_date,o.order_date)) as date_diff
from products p join orders o
on p.product_id = o.product_id
where p.price_date <= o.order_date) X) Y
where rnk  = 1) Z
group by product_id;

-- https://www.namastesql.com/coding-problem/61-category-sales-part-1


select category,sum(amount) as total_sales from (
select *,dayofweek(order_date) as week_days from sales ) X
where week_days not in (1,7)
and month(order_date) = 2
group by category
order by total_sales asc;


-- https://www.namastesql.com/coding-problem/62-category-sales-part-2

select category_name,ifnull(sum(amount),0) as total_sales from (
select c.category_name,s.amount
from categories c left join sales s
on c.category_id = s.category_id ) X
group by category_name
order by total_sales asc;