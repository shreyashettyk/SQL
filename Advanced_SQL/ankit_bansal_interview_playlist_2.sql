-- https://www.youtube.com/watch?v=4KPPZLg_QPA&list=PLU8R7xIwX9dBmUEBq-rwUSE6n60K6nYrs&index=14
CREATE TABLE ProductSpend (
    category VARCHAR(50),
    product VARCHAR(100),
    user_id INT,
    spend DECIMAL(10, 2)
);

INSERT INTO ProductSpend (category, product, user_id, spend) VALUES
('appliance', 'refrigerator', 165, 26.00),
('appliance', 'refrigerator', 123, 3.00),
('appliance', 'washing machine', 123, 19.80),
('electronics', 'vacuum', 178, 5.00),
('electronics', 'wireless headset', 156, 7.00),
('electronics', 'vacuum', 145, 15.00),
('electronics', 'laptop', 114, 999.99),
('fashion', 'dress', 117, 49.99),
('groceries', 'milk', 243, 2.99),
('groceries', 'bread', 645, 1.99),
('home', 'furniture', 276, 599.99),
('home', 'decor', 456, 29.99);

select * from productspend;

select category,product,total_spend from (
select *,dense_rank() over (partition by category order by total_spend desc) rnk from (
select category,product,sum(spend) as total_spend
from productspend
group by category,product ) X ) Y
where rnk = 1 or rnk = 2;
-- https://www.youtube.com/watch?v=mnn9TJSL-P4&list=PLU8R7xIwX9dBmUEBq-rwUSE6n60K6nYrs&index=8

CREATE TABLE artists (
    artist_id INT PRIMARY KEY,
    artist_name VARCHAR(100),
    label_owner VARCHAR(100)
);

INSERT INTO artists (artist_id, artist_name, label_owner) VALUES
(101, 'Ed Sheeran', 'Warner Music Group'),
(120, 'Drake', 'Warner Music Group'),
(125, 'Bad Bunny', 'Rimas Entertainment'),
(130, 'Lady Gaga', 'Interscope Records'),
(140, 'Katy Perry', 'Capitol Records');


CREATE TABLE songs (
    song_id INT PRIMARY KEY,
    artist_id INT,
    name VARCHAR(100)
);


INSERT INTO songs (song_id, artist_id, name) VALUES
(55511, 101, 'Perfect'),
(45202, 101, 'Shape of You'),
(22222, 120, 'One Dance'),
(19960, 120, 'Hotline Bling'),
(33333, 125, 'Dákiti'),
(44444, 125, 'Yonaguni'),
(55555, 130, 'Bad Romance'),
(66666, 130, 'Poker Face'),
(99999, 140, 'Roar'),
(101010, 140, 'Firework');

CREATE TABLE global_song_rank (
    day INT,
    song_id INT,
    ranking INT
);

INSERT INTO global_song_rank (day, song_id, ranking) VALUES
(1, 45202, 5),
(3, 45202, 2),
(1, 19960, 3),
(9, 19960, 6),
(1, 55511, 8),
(5, 22222, 7),
(2, 33333, 4),
(4, 44444, 8),
(6, 55555, 1),
(7, 66666, 10),
(5, 99999, 5);

select * from artists;

select * from songs;


select * from global_song_rank;

select a.artist_name,Z.rnk from (
select *,dense_rank() over (order by cnt desc) rnk from (
select artist_id, count(*) as cnt from (
select g.*,s.artist_id
from global_song_rank g join songs s 
on g.song_id = s.song_id ) X
group by artist_id ) Y ) Z join  artists a 
on Z.artist_id = a.artist_id
limit 5;


-- https://www.youtube.com/watch?v=yGww6dmMR0Q&list=PLU8R7xIwX9dBmUEBq-rwUSE6n60K6nYrs&index=16
-- https://www.youtube.com/watch?v=l72hohmWA68
CREATE TABLE stock (
    supplier_id INT,
    product_id INT,
    stock_quantity INT,
    record_date DATE
);

INSERT INTO stock (supplier_id, product_id, stock_quantity, record_date)
VALUES
    (1, 1, 60, '2022-01-01'),
    (1, 1, 40, '2022-01-02'),
    (1, 1, 35, '2022-01-03'),
    (1, 1, 45, '2022-01-04'),
 (1, 1, 51, '2022-01-06'),
 (1, 1, 55, '2022-01-09'),
 (1, 1, 25, '2022-01-10'),
    (1, 1, 48, '2022-01-11'),
 (1, 1, 45, '2022-01-15'),
    (1, 1, 38, '2022-01-16'),
    (1, 2, 45, '2022-01-08'),
    (1, 2, 40, '2022-01-09'),
    (2, 1, 45, '2022-01-06'),
    (2, 1, 55, '2022-01-07'),
    (2, 2, 45, '2022-01-08'),
 (2, 2, 48, '2022-01-09'),
    (2, 2, 35, '2022-01-10'),
 (2, 2, 52, '2022-01-15'),
    (2, 2, 23, '2022-01-16');
    
select * from stock;


select *,
stk_flg+nxt as alert_flg from (
select *,
lead(stk_flg) over (partition by supplier_id,product_id order by record_date asc) as nxt from (
select *,
case when stock_quantity  < 50 then 1 else 0 end as stk_flg  
from stock ) X ) Y;
-- https://www.youtube.com/watch?v=F0cQMOPMkAA

-- https://www.youtube.com/watch?v=JHUlQZrviCI
CREATE TABLE city_distance
(
    distance INT,
    source VARCHAR(512),
    destination VARCHAR(512)
);
INSERT INTO city_distance(distance, source, destination) VALUES ('100', 'New Delhi', 'Panipat');
INSERT INTO city_distance(distance, source, destination) VALUES ('200', 'Ambala', 'New Delhi');
INSERT INTO city_distance(distance, source, destination) VALUES ('150', 'Bangalore', 'Mysore');
INSERT INTO city_distance(distance, source, destination) VALUES ('150', 'Mysore', 'Bangalore');
INSERT INTO city_distance(distance, source, destination) VALUES ('250', 'Mumbai', 'Pune');
INSERT INTO city_distance(distance, source, destination) VALUES ('250', 'Pune', 'Mumbai');
INSERT INTO city_distance(distance, source, destination) VALUES ('2500', 'Chennai', 'Bhopal');
INSERT INTO city_distance(distance, source, destination) VALUES ('2500', 'Bhopal', 'Chennai');
INSERT INTO city_distance(distance, source, destination) VALUES ('60', 'Tirupati', 'Tirumala');
INSERT INTO city_distance(distance, source, destination) VALUES ('80', 'Tirumala', 'Tirupati');

select * from city_distance;


select a.*
from city_distance a,city_distance b
where b.source = a.destination and b.destination = a.source and a.distance = b.distance;

select a.*
from city_distance a,city_distance b
where b.source = a.destination and b.destination = a.source and a.distance = b.distance
and a.source < a.destination
UNION
select distance,source,destination
from city_distance where (distance,source,destination) not in (select a.*
from city_distance a,city_distance b
where b.source = a.destination and b.destination = a.source and a.distance = b.distance)
and source < destination;


-- https://www.youtube.com/watch?v=V7KFQD0PIj8

CREATE TABLE cinema (
    seat_id INT PRIMARY KEY,
    free int
);

INSERT INTO cinema (seat_id, free) VALUES (1, 1);
INSERT INTO cinema (seat_id, free) VALUES (2, 0);
INSERT INTO cinema (seat_id, free) VALUES (3, 1);
INSERT INTO cinema (seat_id, free) VALUES (4, 1);
INSERT INTO cinema (seat_id, free) VALUES (5, 1);
INSERT INTO cinema (seat_id, free) VALUES (6, 0);
INSERT INTO cinema (seat_id, free) VALUES (7, 1);
INSERT INTO cinema (seat_id, free) VALUES (8, 1);
INSERT INTO cinema (seat_id, free) VALUES (9, 0);
INSERT INTO cinema (seat_id, free) VALUES (10, 1);
INSERT INTO cinema (seat_id, free) VALUES (11, 0);
INSERT INTO cinema (seat_id, free) VALUES (12, 1);
INSERT INTO cinema (seat_id, free) VALUES (13, 0);
INSERT INTO cinema (seat_id, free) VALUES (14, 1);
INSERT INTO cinema (seat_id, free) VALUES (15, 1);
INSERT INTO cinema (seat_id, free) VALUES (16, 0);
INSERT INTO cinema (seat_id, free) VALUES (17, 1);
INSERT INTO cinema (seat_id, free) VALUES (18, 1);
INSERT INTO cinema (seat_id, free) VALUES (19, 1);
INSERT INTO cinema (seat_id, free) VALUES (20, 1);


select * from cinema;


select seat_id
from (
select *,
lead(free) over () as nxt,
lag(free) over() as prev
from cinema)X
where (prev = 1 and  free = 1) or (free = 1 and nxt = 1) or (free  =1 and prev = 1 and nxt = 1)
order by seat_id ;


-- https://www.youtube.com/watch?v=aGKzhAkkOP8
CREATE TABLE friends (
    user_id INT,
    friend_id INT
);

INSERT INTO friends VALUES
(1, 2),
(1, 3),
(1, 4),
(2, 1),
(3, 1),
(3, 4),
(4, 1),
(4, 3);

CREATE TABLE likes (
    user_id INT,
    page_id CHAR(1)
);

INSERT INTO likes VALUES
(1, 'A'),
(1, 'B'),
(1, 'C'),
(2, 'A'),
(3, 'B'),
(3, 'C'),
(4, 'B');


select * from friends;
select * from likes;

select f.user_id as f_user_id,f.friend_id,l.*
from friends f,likes l
where f.friend_id = l.user_id;


select f_user_id,page_id as friend_likes from (
select f.user_id as f_user_id,f.friend_id,l.*
from friends f,likes l
where f.friend_id = l.user_id) X
group by f_user_id,page_id ;

select Y.f_user_id,Y.friend_likes,l.page_id from (
select f_user_id,page_id as friend_likes from (
select f.user_id as f_user_id,f.friend_id,l.*
from friends f,likes l
where f.friend_id = l.user_id) X
group by f_user_id,page_id ) Y,likes l 
where Y.f_user_id = l.user_id;

select distinct f_user_id,friend_likes,page_id from (
select Y.f_user_id,Y.friend_likes,l.page_id from (
select f_user_id,page_id as friend_likes from (
select f.user_id as f_user_id,f.friend_id,l.*
from friends f,likes l
where f.friend_id = l.user_id) X
group by f_user_id,page_id ) Y,likes l 
where Y.f_user_id = l.user_id) Z
where friend_likes <> page_id
order by f_user_id,friend_likes,page_id;

select distinct f_user_id,friend_likes from (
select distinct f_user_id,friend_likes,page_id from (
select Y.f_user_id,Y.friend_likes,l.page_id from (
select f_user_id,page_id as friend_likes from (
select f.user_id as f_user_id,f.friend_id,l.*
from friends f,likes l
where f.friend_id = l.user_id) X
group by f_user_id,page_id ) Y,likes l 
where Y.f_user_id = l.user_id) Z
where friend_likes <> page_id
order by f_user_id,friend_likes,page_id ) B;

With friends_cte as ( select distinct f_user_id,friend_likes from (
select distinct f_user_id,friend_likes,page_id from (
select Y.f_user_id,Y.friend_likes,l.page_id from (
select f_user_id,page_id as friend_likes from (
select f.user_id as f_user_id,f.friend_id,l.*
from friends f,likes l
where f.friend_id = l.user_id) X
group by f_user_id,page_id ) Y,likes l 
where Y.f_user_id = l.user_id) Z
where friend_likes <> page_id
order by f_user_id,friend_likes,page_id ) B
)

select * from friends_cte;

select f_user_id,friend_likes
from friends_cte
where friend_likes not in (select distinct page_id from likes)
group by f_user_id,friend_likes;


-- https://www.youtube.com/watch?v=Jo2Ra41QQcU
CREATE TABLE swipe (
    employee_id INT,
    activity_type VARCHAR(10),
    activity_time datetime
);

INSERT INTO swipe (employee_id, activity_type, activity_time) VALUES
(1, 'login', '2024-07-23 08:00:00'),
(1, 'logout', '2024-07-23 12:00:00'),
(1, 'login', '2024-07-23 13:00:00'),
(1, 'logout', '2024-07-23 17:00:00'),
(2, 'login', '2024-07-23 09:00:00'),
(2, 'logout', '2024-07-23 11:00:00'),
(2, 'login', '2024-07-23 12:00:00'),
(2, 'logout', '2024-07-23 15:00:00'),
(1, 'login', '2024-07-24 08:30:00'),
(1, 'logout', '2024-07-24 12:30:00'),
(2, 'login', '2024-07-24 09:30:00'),
(2, 'logout', '2024-07-24 10:30:00');


select * from swipe;



select *,timestampdiff(HOUR,login_time,logout_time) as time_spent from (
select employee_id,date,min(time) as login_time,max(time) as logout_time
from (select *,date(activity_time) as date,time(activity_time) as time from swipe) M
group by employee_id,date ) X;


select employee_id,date,sum(time_spent) as productivity_hrs from (
select *,timestampdiff(hour,time,logout_time) as time_spent from (
select *,lead(time) over (partition by employee_id) logout_time from (
select * from (
select *,date(activity_time) as date,time(activity_time) as time from swipe ) X
order by employee_id,activity_time ) Y ) Z
where activity_type = 'login' ) K
group by employee_id,date;






-- https://www.youtube.com/watch?v=qyAgWL066Vo&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb

create table icc_world_cup
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);

INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','India');

select * from  icc_world_cup;

select team_1 as country,count(*) as total_matches_played from (
select team_1 from icc_world_cup union all select team_2 from icc_world_cup ) X
group by team_1;

select winner as country,count(*) as matches_won
from icc_world_cup
group by winner;


select a.country,a.total_matches_played,b.matches_won
from 
(select team_1 as country,count(*) as total_matches_played from (
select team_1 from icc_world_cup union all select team_2 from icc_world_cup ) X
group by team_1) a
left join 
(select winner as country,count(*) as matches_won
from icc_world_cup
group by winner) b
on a.country = b.country;


select *,
(total_matches_played - matches_won ) as matches_lost from (
select country,total_matches_played,
case when  matches_won is null then 0 else matches_won end as matches_won
from (
select a.country,a.total_matches_played,b.matches_won
from 
(select team_1 as country,count(*) as total_matches_played from (
select team_1 from icc_world_cup union all select team_2 from icc_world_cup ) X
group by team_1) a
left join 
(select winner as country,count(*) as matches_won
from icc_world_cup
group by winner) b
on a.country = b.country ) Z ) A;
