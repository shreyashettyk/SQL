create database ankit_interview_questions;
use ankit_interview_questions;


-- https://www.youtube.com/watch?v=WM2jN1gOs_8
CREATE TABLE city_population (
    state VARCHAR(50),
    city VARCHAR(50),
    population INT
);


INSERT INTO city_population (state, city, population) VALUES ('haryana', 'ambala', 100);
INSERT INTO city_population (state, city, population) VALUES ('haryana', 'panipat', 200);
INSERT INTO city_population (state, city, population) VALUES ('haryana', 'gurgaon', 300);
INSERT INTO city_population (state, city, population) VALUES ('punjab', 'amritsar', 150);
INSERT INTO city_population (state, city, population) VALUES ('punjab', 'ludhiana', 400);
INSERT INTO city_population (state, city, population) VALUES ('punjab', 'jalandhar', 250);
INSERT INTO city_population (state, city, population) VALUES ('maharashtra', 'mumbai', 1000);
INSERT INTO city_population (state, city, population) VALUES ('maharashtra', 'pune', 600);
INSERT INTO city_population (state, city, population) VALUES ('maharashtra', 'nagpur', 300);
INSERT INTO city_population (state, city, population) VALUES ('karnataka', 'bangalore', 900);
INSERT INTO city_population (state, city, population) VALUES ('karnataka', 'mysore', 400);
INSERT INTO city_population (state, city, population) VALUES ('karnataka', 'mangalore', 200);

select * from city_population;


select state,city,population from (
select *,dense_rank() over(partition by state order by population desc) pop_rnk_highest,
dense_rank() over(partition by state order by population asc) pop_rnk_lowest
from city_population ) X
where pop_rnk_highest = 1 or pop_rnk_lowest = 1;


select * from (
select state,city as lowest_pop,
lead(city) over (partition by  state) highest_pop from (
select state,city,population from (
select *,dense_rank() over(partition by state order by population desc) pop_rnk_highest,
dense_rank() over(partition by state order by population asc) pop_rnk_lowest
from city_population ) X
where pop_rnk_highest = 1 or pop_rnk_lowest = 1)Y ) Z
where lowest_pop is not null and highest_pop is not null;


-- https://www.youtube.com/watch?v=CYjyjQGjX7A

CREATE TABLE movies (
    id INT PRIMARY KEY,
    genre VARCHAR(50),
    title VARCHAR(100)
);


CREATE TABLE reviews (
    movie_id INT,
    rating DECIMAL(3,1),
    FOREIGN KEY (movie_id) REFERENCES movies(id)
);


INSERT INTO movies (id, genre, title) VALUES
(1, 'Action', 'The Dark Knight'),
(2, 'Action', 'Avengers: Infinity War'),
(3, 'Action', 'Gladiator'),
(4, 'Action', 'Die Hard'),
(5, 'Action', 'Mad Max: Fury Road'),
(6, 'Drama', 'The Shawshank Redemption'),
(7, 'Drama', 'Forrest Gump'),
(8, 'Drama', 'The Godfather'),
(9, 'Drama', 'Schindler''s List'),
(10, 'Drama', 'Fight Club'),
(11, 'Comedy', 'The Hangover'),
(12, 'Comedy', 'Superbad'),
(13, 'Comedy', 'Dumb and Dumber'),
(14, 'Comedy', 'Bridesmaids'),
(15, 'Comedy', 'Anchorman: The Legend of Ron Burgundy');


INSERT INTO reviews (movie_id, rating) VALUES
(1, 4.5),
(1, 4.0),
(1, 5.0),
(2, 4.2),
(2, 4.8),
(2, 3.9),
(3, 4.6),
(3, 3.8),
(3, 4.3),
(4, 4.1),
(4, 3.7),
(4, 4.4),
(5, 3.9),
(5, 4.5),
(5, 4.2),
(6, 4.8),
(6, 4.7),
(6, 4.9),
(7, 4.6),
(7, 4.9),
(7, 4.3),
(8, 4.9),
(8, 5.0),
(8, 4.8),
(9, 4.7),
(9, 4.9),
(9, 4.5),
(10, 4.6),
(10, 4.3),
(10, 4.7),
(11, 3.9),
(11, 4.0),
(11, 3.5),
(12, 3.7),
(12, 3.8),
(12, 4.2),
(13, 3.2),
(13, 3.5),
(13, 3.8),
(14, 3.8),
(14, 4.0),
(14, 4.2),
(15, 3.9),
(15, 4.0),
(15, 4.1);

select * from movies;

select * from reviews;

select id,genre,title,repeat('*',avg_rating) as stars from (
select *,row_number() over (partition by genre order by avg_rating desc) rnk from (
select id,genre,title,round(avg(rating),0) as avg_rating from (
select m.id,m.genre,m.title,r.rating
from movies m join reviews r
on m.id = r.movie_id ) X
group by id ) Y ) Z
where rnk = 1
;

-- https://www.youtube.com/watch?v=eMQDHHfUJtU&list=PLBTZqjSKn0IfuIqbMIqzS-waofsPHMS0E&index=19
drop table flights;
CREATE TABLE flights 
(
    cid VARCHAR(512),
    fid VARCHAR(512),
    origin VARCHAR(512),
    Destination VARCHAR(512)
);

INSERT INTO flights (cid, fid, origin, Destination) VALUES ('1', 'f1', 'Del', 'Hyd');
INSERT INTO flights (cid, fid, origin, Destination) VALUES ('1', 'f2', 'Hyd', 'Blr');
INSERT INTO flights (cid, fid, origin, Destination) VALUES ('2', 'f3', 'Mum', 'Agra');
INSERT INTO flights (cid, fid, origin, Destination) VALUES ('2', 'f4', 'Agra', 'Kol');

select * from flights;
select cid,origin,dest from (
select *,
lead(destination) over (partition by cid order by fid asc) dest
from flights ) X where dest is not null ;

CREATE TABLE sales 
(
    order_date date,
    customer VARCHAR(512),
    qty INT
);

INSERT INTO sales (order_date, customer, qty) VALUES ('2021-01-01', 'C1', '20');
INSERT INTO sales (order_date, customer, qty) VALUES ('2021-01-01', 'C2', '30');
INSERT INTO sales (order_date, customer, qty) VALUES ('2021-02-01', 'C1', '10');
INSERT INTO sales (order_date, customer, qty) VALUES ('2021-02-01', 'C3', '15');
INSERT INTO sales (order_date, customer, qty) VALUES ('2021-03-01', 'C5', '19');
INSERT INTO sales (order_date, customer, qty) VALUES ('2021-03-01', 'C4', '10');
INSERT INTO sales (order_date, customer, qty) VALUES ('2021-04-01', 'C3', '13');
INSERT INTO sales (order_date, customer, qty) VALUES ('2021-04-01', 'C5', '15');
INSERT INTO sales (order_date, customer, qty) VALUES ('2021-04-01', 'C6', '10');


describe sales;

select * from sales;

select order_date,count(distinct customer) as cnt from (
select * from (
select *,
row_number() over (partition by customer order by order_date) rnk
from sales ) X where rnk = 1 ) Y
group by order_date;


-- https://www.youtube.com/watch?v=J9wwR4huimI&list=PLBTZqjSKn0IfuIqbMIqzS-waofsPHMS0E&index=20

create table source(id int, name varchar(5));

create table target(id int, name varchar(5));

insert into source values(1,'A'),(2,'B'),(3,'C'),(4,'D');

insert into target values(1,'A'),(2,'B'),(4,'X'),(5,'F');

select * from source;
select * from target;

SELECT s.id,s.name
FROM SOURCE S LEFT JOIN TARGET T
ON S.ID = T.ID
WHERE (S.ID,S.NAME) NOT IN (
SELECT T.ID,T.NAME
FROM SOURCE S RIGHT JOIN TARGET T
ON S.ID = T.ID)
UNION
SELECT T.ID,T.NAME
FROM SOURCE S RIGHT JOIN TARGET T
ON S.ID = T.ID WHERE (T.ID,T.NAME) NOT IN (
SELECT s.id,s.name
FROM SOURCE S LEFT JOIN TARGET T
ON S.ID = T.ID);

-- https://www.youtube.com/watch?v=dOLBRfwzYcU&list=PLBTZqjSKn0IfuIqbMIqzS-waofsPHMS0E&index=1


CREATE TABLE events (
ID int,
event varchar(255),
YEAR INt,
GOLD varchar(255),
SILVER varchar(255),
BRONZE varchar(255)
);


INSERT INTO events VALUES (1,'100m',2016, 'Amthhew Mcgarray','donald','barbara');
INSERT INTO events VALUES (2,'200m',2016, 'Nichole','Alvaro Eaton','janet Smith');
INSERT INTO events VALUES (3,'500m',2016, 'Charles','Nichole','Susana');
INSERT INTO events VALUES (4,'100m',2016, 'Ronald','maria','paula');
INSERT INTO events VALUES (5,'200m',2016, 'Alfred','carol','Steven');
INSERT INTO events VALUES (6,'500m',2016, 'Nichole','Alfred','Brandon');
INSERT INTO events VALUES (7,'100m',2016, 'Charles','Dennis','Susana');
INSERT INTO events VALUES (8,'200m',2016, 'Thomas','Dawn','catherine');
INSERT INTO events VALUES (9,'500m',2016, 'Thomas','Dennis','paula');
INSERT INTO events VALUES (10,'100m',2016, 'Charles','Dennis','Susana');
INSERT INTO events VALUES (11,'200m',2016, 'jessica','Donald','Stefeney');
INSERT INTO events VALUES (12,'500m',2016,'Thomas','Steven','Catherine');


select * from events;

select gold from events;

select gold_winners,count(*) as gold_medal_count from (
select gold as gold_winners  from events
where gold not in (select silver from events) 
and gold not in (select bronze from events) ) X
group by gold_winners;


-- https://www.youtube.com/watch?v=gKSs5yIvTgs
CREATE TABLE transactions (
    product_id INT,
    user_id INT,
    spend DECIMAL(10, 2),
    transaction_date DATETIME
);


INSERT INTO transactions (product_id, user_id, spend, transaction_date)
VALUES
(3673, 123, 68.90, '2022-07-08 10:00:00'),
(9623, 123, 274.10, '2022-07-08 10:00:00'),
(1467, 115, 19.90, '2022-07-08 10:00:00'),
(2513, 159, 25.00, '2022-07-08 10:00:00'),
(1452, 159, 74.50, '2022-07-10 10:00:00'),
(1452, 123, 74.50, '2022-07-10 10:00:00'),
(9765, 123, 100.15, '2022-07-11 10:00:00'),
(6536, 115, 57.00, '2022-07-12 10:00:00'),
(7384, 159, 15.50, '2022-07-12 10:00:00'),
(1247, 159, 23.40, '2022-07-12 10:00:00');  

select * from transactions;

select transaction_date,user_id,count(*) as purchase_count from (
select * from (
select *,dense_rank() over (partition by user_id order by transaction_date desc) rnk
from transactions ) X
where rnk = 1 ) Y
group by transaction_date,user_id;

-- https://www.youtube.com/watch?v=cIyqUG17REA

CREATE TABLE reviews_1 (
    review_id INT PRIMARY KEY,
    user_id INT,
    submit_date DATE,
    restaurant_id INT,
    rating INT
);

INSERT INTO reviews_1 (review_id, user_id, submit_date, restaurant_id, rating) VALUES
(1001, 501, '2022-01-15', 101, 4),
(1002, 502, '2022-01-20', 101, 5),
(1003, 503, '2022-01-25', 102, 3),
(1004, 504, '2022-01-15', 102, 4),
(1005, 505, '2022-02-20', 101, 5),
(1006, 506, '2022-02-26', 101, 4),
(1007, 507, '2022-03-01', 101, 4),
(1008, 508, '2022-03-05', 102, 2);

select *,month(submit_date) as month from reviews_1;

select * from reviews_1;

select restaurant_id,month,round(avg(rating),1) as average_Rating
from (select *,month(submit_date) as month from reviews_1) X
group by restaurant_id,month
having count(*) >= 2;
-- https://www.youtube.com/watch?v=UHZd-r6wxKg

CREATE TABLE Transactions_1 (
    transaction_id INT PRIMARY KEY,
    company_id INT,
    transaction_date DATE,
    revenue DECIMAL(10, 2)
);
INSERT INTO Transactions_1 (transaction_id, company_id, transaction_date, revenue) VALUES
(101, 1, '2020-01-15', 5000.00),
(102, 2, '2020-01-20', 8500.00),
(103, 1, '2020-02-10', 4500.00),
(104, 3, '2020-02-20', 9900.00),
(105, 2, '2020-02-25', 7500.00);

CREATE TABLE Sectors (
    company_id INT PRIMARY KEY,
    sector VARCHAR(50)
);

INSERT INTO Sectors (company_id, sector) VALUES
(1, 'Technology'),
(2, 'Healthcare'),
(3, 'Technology');

select * from transactions_1;

select * from sectors;

select *,month(transaction_date) as trans_month from transactions_1;
select company_id,trans_month,avg(revenue) as avg_rev
from (select *,month(transaction_date) as trans_month from transactions_1) X
group by company_id,trans_month;

select Y.*,s.sector from  (
select company_id,trans_month,round(avg(revenue),2) as avg_rev
from (select *,month(transaction_date) as trans_month from transactions_1) X
group by company_id,trans_month ) Y join sectors s 
on Y.company_id = s.company_id;

-- https://www.youtube.com/watch?v=i-0bypiVwp0&list=PLU8R7xIwX9dBmUEBq-rwUSE6n60K6nYrs&index=3
CREATE TABLE logs (
    id INT PRIMARY KEY,
    num INT
);
INSERT INTO logs (id, num) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 2),
(5, 1),
(6, 2),
(7, 2);

select * from logs;

select count(*) OVER (partition by num) as col1 from logs;

select num from (
select *,
case when num = lead_num and lead_num = lag_num then 1 else 0 end as flg from (
select *,lead(num) over () lead_num,
lag(num) over () lag_num
from logs ) X ) Y
where flg = 1;

-- https://www.youtube.com/watch?v=D-TVx2ZsDvc&list=PLU8R7xIwX9dBmUEBq-rwUSE6n60K6nYrs&index=4
CREATE TABLE npv (
    id INT,
    year INT,
    npv DECIMAL(10, 2)
);

INSERT INTO npv (id, year, npv) VALUES 
(1, 2018, 100),
(7, 2020, 30),
(13, 2019, 40),
(1, 2019, 113),
(2, 2008, 121),
(3, 2009, 12),
(11, 2020, 99),
(7, 2019, 0); 


CREATE TABLE queries (
    id INT,
    year INT
);

INSERT INTO queries (id, year) VALUES
(1, 2019),
(2, 2008),
(3, 2009),
(7, 2018),
(7, 2019),
(7, 2020),
(13, 2019);

select id,year,
case when npv is not null then npv else 0 end as npv from (
select q.*,n.npv
from queries q left join npv n
on q.id = n.id and q.year = n.year
order by q.id,q.year asc ) X;

-- https://www.youtube.com/watch?v=m_ofo0YlmdE&list=PLU8R7xIwX9dBmUEBq-rwUSE6n60K6nYrs&index=2

CREATE TABLE Employee (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    managerId INT
);


INSERT INTO Employee (id, name, department, managerId) VALUES 
(1, 'John', 'HR', NULL),
(2, 'Bob', 'HR', 1),
(3, 'Olivia', 'HR', 1),
(4, 'Emma', 'Finance', NULL),
(5, 'Sophia', 'HR', 1),
(6, 'Mason', 'Finance', 4),
(7, 'Ethan', 'HR', 1),
(8, 'Ava', 'HR', 1),
(9, 'Lucas', 'HR', 1),
(10, 'Isabella', 'Finance', 4),
(11, 'Harper', 'Finance', 4),
(12, 'Hemla', 'HR', 3),
(13, 'Aisha', 'HR', 2),
(14, 'Himani', 'HR', 2),
(15, 'Lily', 'HR', 2);

select * from employee;

select department,managerID,cnt from (
select department,managerID,count(*) as cnt from (
select * from employee where department in (
select department from employee
group by department
having count(*) > 10) ) X
where managerID is not null
group by department,managerID ) Y
where cnt >= 5 ;

SELECT e.name,e.department,Z.cnt FROM employee e,(
SELECT department,managerID,cnt FROM (
SELECT department,managerID,count(*) as cnt FROM (
SELECT * FROM employee WHERE department in (
SELECT department FROM employee
GROUP BY department
having count(*) > 10) ) X
WHERE managerID IS NOT NULL
GROUP BY department,managerID ) Y
WHERE cnt >= 5 ) Z
WHERE e.id = Z.managerId ; 


-- https://www.youtube.com/watch?v=o76mh0bSHxs&list=PLU8R7xIwX9dBmUEBq-rwUSE6n60K6nYrs&index=2
CREATE TABLE Customers (
    Customer_id INT PRIMARY KEY,
    Name VARCHAR(100),
    Join_Date DATE
);

INSERT INTO Customers (Customer_id, Name, Join_Date) VALUES
(1, 'John', '2023-01-10'),
(2, 'Simmy', '2023-02-15'),
(3, 'Iris', '2023-03-20');

CREATE TABLE Orders (
    Order_id INT PRIMARY KEY,
    Customer_id INT,
    Order_Date DATE,
    Amount DECIMAL(10, 2)
);

INSERT INTO Orders (Order_id, Customer_id, Order_Date, Amount) VALUES
(1, 1, '2023-01-05', 100.00),
(2, 2, '2023-02-14', 150.00),
(3, 1, '2023-02-28', 200.00),
(4, 3, '2023-03-22', 300.00),
(5, 2, '2023-04-10', 250.00),
(6, 1, '2023-05-15', 400.00),
(7, 3, '2023-06-10', 350.00);


select *,
round(avg(monthly_sales) over (rows between 2 preceding and current row),2) mv_avg from (
select order_month,sum(amount) as monthly_sales from (
select *,month(order_date) as order_month from orders ) X
group by order_month ) X;

-- https://www.youtube.com/watch?v=TYWaYMwjSoE&list=PLU8R7xIwX9dBmUEBq-rwUSE6n60K6nYrs&index=15
CREATE TABLE transactions_uber (
  user_id INT,
  spend DECIMAL(10,2),
  transaction_date DATETIME
);

INSERT INTO transactions_uber (user_id, spend, transaction_date)
VALUES
  (111, 100.50, '2022-01-08 12:00:00'),
  (111, 55, '2022-01-10 12:00:00'),
  (121, 36, '2022-01-18 12:00:00'),
  (145, 24.99, '2022-01-26 12:00:00'),
  (111, 89.60, '2022-02-05 12:00:00'); 
  
  
select * from transactions_uber;
select user_id,spend,transaction_date from (
select *,dense_rank() over(partition by user_id order by  transaction_date) rnk from 
transactions_uber ) X where rnk = 3;

-- https://www.youtube.com/watch?v=uJ-ImZtjLUg&list=PLU8R7xIwX9dBmUEBq-rwUSE6n60K6nYrs&index=12

CREATE TABLE job_listings (
    company_id INT,
    job_id INT,
    title VARCHAR(255),
    description TEXT
);


INSERT INTO job_listings (company_id, job_id, title, description) VALUES
(827, 248, 'Business Analyst', 'Business analyst evaluates past and current business data with the primary goal of improving decision-making processes within organisations.'),
(845, 149, 'Business Analyst', 'Business analyst evaluates past and current business data with the primary goal of improving decision-making processes within organisations.'),
(345, 945, 'Data Analyst', 'Data analyst reviews data to identify key insights into a business\'s customers and ways the data can be used to solve problems.'),
(345, 164, 'Data Analyst', 'Data analyst reviews data to identify key insights into a business\'s customers and ways the data can be used to solve problems.'),
(244, 172, 'Data Engineer', 'Data engineer works in a variety of settings to build systems that collect, manage, and convert raw data into usable information for data scientists and business analysts to interpret.');


select * from job_listings;

select count(*) as no_complany_duplicate_postings from (
select company_id,title,description,count(*) as cnt
from job_listings
group by company_id,title,description ) X 
where cnt > 1;

-- https://www.youtube.com/watch?v=4KPPZLg_QPA&list=PLU8R7xIwX9dBmUEBq-rwUSE6n60K6nYrs&index=14
-- https://www.youtube.com/watch?v=mnn9TJSL-P4&list=PLU8R7xIwX9dBmUEBq-rwUSE6n60K6nYrs&index=8
