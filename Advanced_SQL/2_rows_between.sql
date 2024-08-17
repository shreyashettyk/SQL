
show databases;
use advanced_sql;

select * from rank_exercise order by date;

select *, sum(Sales) over (order by Date rows between  1 preceding and 1 following) row_btwn
from rank_exercise;

select *, sum(Sales) over (order by Date rows between  unbounded preceding and  current row) row_btwn
from rank_exercise;

select * from running_sum_state;

select distinct state from running_sum_state;

select *, sum(sales) over(partition by state
 order by date  
 rows between unbounded preceding and current row) cum_sum
 from running_sum_state;
 
 select X.state,max(X.cum_sum) as max_sales from (
 select *, sum(sales) over(partition by state
 order by date  
 rows between unbounded preceding and current row) cum_sum
 from running_sum_state) X
 group by X.state;



