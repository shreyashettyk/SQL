create database advanced_sql;
show databases;
use advanced_sql;
show tables;
select * from rank_exercise;

select *,
rank() over ( order by sales desc) rnk,
dense_rank() over (order by sales desc) dense_rk,
row_number() over (order by sales desc) row_rk
from rank_exercise;

select * ,
rank() over (partition by department order by salary desc)
from rank_partition;
