-- solved questions from https://www.youtube.com/watch?v=IicPavA37ew

create database swiggy;
use swiggy;

select * from users;

select * from orders;
describe orders;

select * from food;
select * from menu;

select * from resturants;

-- 1. Find customers who have never ordered

select user_id,name from users where user_id not in (select user_id from orders);

-- 2. Average Price/dish
select distinct f.f_name,X.* from food f join (
select f_id,round(avg(price),2) as average_price
from menu
group by f_id)X
on f.f_id = X.f_id;

-- 3. Find the top restaurant in terms of the number of orders for a given month
select *,month(str_to_date(date,'%d-%m-%Y')) as order_month from orders ;
select r_id,order_month,count(*) as cnt from (
select *,month(str_to_date(date,'%d-%m-%Y')) as order_month from orders ) X
group by r_id,order_month;

select * from (
select *,dense_rank() over (partition by order_month order by cnt desc) rnk from (
select r_id,order_month,count(*) as cnt from (
select *,month(str_to_date(date,'%d-%m-%Y')) as order_month from orders ) X
group by r_id,order_month
) X ) Y where rnk = 1;

-- 6.Find restaurants with max repeated customers

select * from (
select *,dense_rank() over (order by cnt desc) rnk from (
select r_id,user_id,count(*) as cnt
from orders
group by r_id,user_id ) X ) Y
where rnk = 1;

-- 4. restaurants with monthly sales greater than 1000 for June
select r_id,sum(amount) as amt from (
select * from (
select *,month(str_to_date(date,'%d-%m-%Y')) as mnth from orders ) X
where mnth = 6 ) Y
group by r_id
having amt > 500
order by amt desc;

select * from resturants;
select * from orders;
select * from order_details;

select * from (
select *,month(str_to_date(date,'%d-%m-%Y')) as mnth from orders ) X
where mnth = 6;

-- 5. Show all orders with order details for a particular customer in a particular 
-- date range - Order details of Ankit in the range 10-June to 10-July

select * from users;
select * from orders;
select * from order_details;


select Z.order_id,Z.user_id,Z.amount,Z.date_d,Z.partner_id,Z.delivery_time,
Z.delivery_rating,Z.restaurant_rating,Z.r_name,f.f_name from (
select Y.order_id,Y.user_id,Y.amount,Y.date_d,Y.partner_id,Y.delivery_time,
Y.delivery_rating,Y.restaurant_rating,Y.f_id,r.r_name from (
select X.order_id,X.user_id,X.r_id,X.amount,X.date_d,X.partner_id,X.delivery_time,
X.delivery_rating,X.restaurant_rating,od.f_id
from (
select *,str_to_date(date,'%d-%m-%Y') as date_d from orders
where user_id = 4 
) X join order_details od
on X.order_id = od.order_id
where date_d between '2022-06-10' and '2022-07-10')Y join resturants r
on Y.r_id = r.r_id ) Z join food f on Z.f_id = f.f_id;

-- 7. month over month revenue growth of swiggy

select * from orders;

select *,((overall_month_revenue-lag(overall_month_revenue) over())/(lag(overall_month_revenue) over()))*100 as prev_month_rev from (
select month_d,sum(amount) as overall_month_revenue from (
select *,month(str_to_date(date,'%d-%m-%Y')) as month_d
from orders ) X
group by month_d ) Y;

-- 8. Customer - favorite food

select * from orders;

select * from order_details;

select o.order_id,o.user_id,od.f_id
from orders o join order_details od 
on o.order_id  = od.order_id;

select user_id,f_id,count(*) as total_occ
from (
select o.order_id,o.user_id,od.f_id
from orders o join order_details od 
on o.order_id  = od.order_id ) X
group by user_id,f_id;


select user_id,f_id from (
select *,max(total_occ) over (partition by user_id) as max
from (
select user_id,f_id,count(*) as total_occ
from (
select o.order_id,o.user_id,od.f_id
from orders o join order_details od 
on o.order_id  = od.order_id ) X
group by user_id,f_id
) Y ) Z
where total_occ = max
;

select u.name,f.f_name from (
select user_id,f_id from (
select *,max(total_occ) over (partition by user_id) as max
from (
select user_id,f_id,count(*) as total_occ
from (
select o.order_id,o.user_id,od.f_id
from orders o join order_details od 
on o.order_id  = od.order_id ) X
group by user_id,f_id
) Y ) Z
where total_occ = max ) P,
users u, food f
where P.user_id = u.user_id
and P.f_id = f.f_id
;

select * from food;

