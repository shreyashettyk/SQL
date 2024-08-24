-- create database sql_interview;

use sql_interview;

select * from customer;

select * from orders;
select *  from orders where order_date like '__-04-2021' or order_date like '__-05-2021';

select a.customer_id,a.order_id,a.order_date,b.customer_name
from orders a , customer b 
where a.order_date like '__-04-2021' or a.order_date like '__-05-2021'
and a.customer_id = b.customer_id ;

-- write a query to get customer name, count of orders purchased in april'2021 and may'2021
select b.customer_name,count(*) as order_apr_may_21
from orders a join customer b
on a.customer_id = b.customer_id
where a.order_date like '__-04-2021' or a.order_date like '__-05-2021'
group by b.customer_id;

-- write a query to get customer names who bought in May'2021 and are from Jharkhand							
select b.customer_name,count(*) as order_apr_may_21
from orders a join customer b
on a.customer_id = b.customer_id
where  a.order_date like '__-05-2021'
and b.state  = 'Jharkhand'
group by b.customer_id;

-- write a query to get customer name and their latest order information						

select * from orders;



select X.order_id,X.order_date,X.amount, c.customer_name
from 
(select *,
first_value(order_id) over(partition by customer_id order by order_id desc) last_order
from orders) X join customer c on X.customer_id = c.customer_id
where X.order_id = X.last_order;


-- write a query to get top 2 customer id and name based on total transaction value for each month									

select month(str_to_date(order_date,'%d-%m-%Y')) from orders;


select *,month(str_to_date(order_date,'%d-%m-%Y')) month_data from orders;


select *,sum(amount) over (partition by month_data,customer_id order by month_data) customer_month_sales
from 
( select *,
month(str_to_date(order_date,'%d-%m-%Y')) month_data from orders
) X;






