create database zomato;

use zomato;


drop table if exists goldusers_signup;
CREATE TABLE goldusers_signup(userid integer,gold_signup_date varchar(200)); 

INSERT INTO goldusers_signup(userid,gold_signup_date) 
 VALUES (1,'09-22-2017'),
(3,'04-21-2017');

drop table if exists users;
CREATE TABLE users(userid integer,signup_date varchar(200)); 

INSERT INTO users(userid,signup_date) 
 VALUES (1,'09-02-2014'),
(2,'01-15-2015'),
(3,'04-11-2014');

drop table if exists sales;
CREATE TABLE sales(userid integer,created_date varchar(200),product_id integer); 

INSERT INTO sales(userid,created_date,product_id) 
 VALUES (1,'04-19-2017',2),
(3,'12-18-2019',1),
(2,'07-20-2020',3),
(1,'10-23-2019',2),
(1,'03-19-2018',3),
(3,'12-20-2016',2),
(1,'11-09-2016',1),
(1,'05-20-2016',3),
(2,'09-24-2017',1),
(1,'03-11-2017',2),
(1,'03-11-2016',1),
(3,'11-10-2016',1),
(3,'12-07-2017',2),
(3,'12-15-2016',2),
(2,'11-08-2017',2),
(2,'09-10-2018',3);


drop table if exists product;
CREATE TABLE product(product_id integer,product_name text,price integer); 

INSERT INTO product(product_id,product_name,price) 
 VALUES
(1,'p1',980),
(2,'p2',870),
(3,'p3',330);

show tables;

select * from users;
select * from product;
select * from sales;
select * from goldusers_signup;

-- total amount spent by each customer on zomato ?
select s.userid,s.product_id,sum(p.price) TOTAL_SPENT
from product p join sales s 
on p.product_id = s.product_id
group by s.userid;

-- numberr of days each customer visited the zomato site to purchase a product ?
select userid,count(*) as VISIT_COUNT from (
select distinct userid,created_date
from sales
order by userid asc) X
group by userid;

-- First product purchased by each user ?
create view zomato_sales as 
select userid,product_id,str_to_date(created_date,'%m-%d-%Y') as sales_date
from sales;
select * from zomato_sales order by sales_date asc;


select userid,first_value(product_name) over
(partition by userid order by sales_date asc ) FIRST_PURCHASE from (

select s.userid,s.sales_date,s.product_id,p.product_name
from zomato_sales s join product p 
on s.product_id = p.product_id) X;




-- most purchased product on zomato and number of times it was purchased
-- by each customer

select distinct userid,product_id,sales_date from zomato_sales;

-- (A) most purchased item on zomato
select product_id,count(*) as PRODUCT_PURCHASE
from zomato_sales
group by product_id
order by PRODUCT_PURCHASE desc
limit 1;

-- (B) number of times each customer purchased the most
-- purchased item

select z.userid,count(*) as NUMBER_OF_PURCHASE
from zomato_sales z,
(
select product_id,count(*) as PRODUCT_PURCHASE
from zomato_sales
group by product_id
order by PRODUCT_PURCHASE desc
limit 1
) X
where X.product_id = z.product_id
group by z.userid
order by NUMBER_OF_PURCHASE asc
;

-- which item is most popular for each customer
select * from zomato_sales;

select userid,product_id,count(*) as PRODUCT_PURCHASE_CNT
from zomato_sales
group by userid,product_id
order by userid;


select userid,product_id from (
select *,rank() over (partition by userid order by PRODUCT_PURCHASE_CNT desc) POP_ITEM
from (
select userid,product_id,count(*) as PRODUCT_PURCHASE_CNT
from zomato_sales
group by userid,product_id
order by userid) X ) Y
where POP_ITEM = 1
;






