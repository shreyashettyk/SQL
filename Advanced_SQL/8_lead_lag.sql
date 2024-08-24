use advanced_sql;

show tables;

select * from train_data;
describe train_data;
select *,lead(timings) over (partition by train_number order by timings) next_stn_timing from train_data;

select *,timediff(timings,lead(timings) over (partition by train_number order by timings)) date_time_diff from train_data;

select *,timediff(next_stn_timing,timings) as time_diff from (
select *, lead(timings) over (partition by train_number order by timings) next_stn_timing
from train_data ) X;

select *,timediff(timings,
min(timings) over (partition by train_number order by timings))  as time_between_first_stn 
from train_data;

select *,timediff(timings,min(timings)) 
from train_data
group by train_number
order by timings asc;

select *,count(*)
from train_data
group by train_number
order by timings asc;

-- drop table match_data;


select * from match_data;

select player,sum(runs) as total_runs
from match_data
group by player;

select *,sum(runs) as total_runs
from match_data
group by player;


select *,
sum(runs) over (partition by Player
order by year
rows between unbounded preceding and unbounded following) total_runs
from match_data;



select * ,(runs/total_runs)*100 as percentage from (
select *,
sum(runs) over (partition by Player
order by year
rows between unbounded preceding and unbounded following) total_runs
from match_data) X;

-- number of matches where the score in current yr better than prev yr
select *,lag(runs) over (partition by player order by year) as prev_yr from match_data;

select *,runs-prev_yr 
from (select *,lag(runs)
over (partition by player order by year) as prev_yr
from match_data) X ;

select player,count(*) as imporovement_cnt
from (
select *,runs-prev_yr 
from (select *,lag(runs)
over (partition by player order by year) as prev_yr
from match_data) X)Y
where Y.runs-prev_yr > 0
group by player;

-- count number of matches when rohit score more than Virat

select *,lead(runs) over (partition by Year order by Player ) Virat_runs from match_data;

select *,runs-Virat_runs as runn_diff from 
(
select *,lead(runs) over (partition by Year order by Player ) Virat_runs from match_data
) X;

select player,count(*) as Rohit_exceded_Virat
from 
(
select *,runs-Virat_runs as runn_diff from 
(
select *,lead(runs) over (partition by Year order by Player ) Virat_runs from match_data
) X
) Y
where runn_diff > 0 
group by player;

-- get prev and current score

select *,
lag(runs) over (partition by player order by year) prev_yr,
lead(runs) over (partition by player order by year) next_yr
from match_data;

select *, runs-prev_yr as first_check,next_yr-runs as second_check
from (
select *,
lag(runs) over (partition by player order by year) prev_yr,
lead(runs) over (partition by player order by year) next_yr
from match_data
) X;

select Player,prev_yr,runs,next_yr,year,first_check,second_check
from (
select *, runs-prev_yr as first_check,next_yr-runs as second_check
from (
select *,
lag(runs) over (partition by player order by year) prev_yr,
lead(runs) over (partition by player order by year) next_yr
from match_data
) X
) Y
where first_check > 0 and second_check > 0;
















