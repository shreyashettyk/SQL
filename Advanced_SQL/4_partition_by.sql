use advanced_sql;

select * from partition_by_clause;

select * from partition_by_clause where country = 'India';

select * ,sum(runs) over( partition by  Stadium_Name
 order by year
 rows between unbounded preceding and unbounded following) std_details
from partition_by_clause where country = 'India';

select * ,sum(runs) over( partition by  Stadium_Name,year
 order by year
 rows between unbounded preceding and unbounded following) std_details
from partition_by_clause where country = 'India';

select *,dense_rank() over(partition by stadium_name order by runs desc) run_rnk from partition_by_clause;

select *,dense_rank() over(partition by stadium_name order by runs desc) run_rnk
from partition_by_clause
where country = "India";


select *,dense_rank() over(partition by stadium_name,year order by runs desc) run_rnk
from partition_by_clause;


select * from (
select *,dense_rank() over(partition by stadium_name,year order by runs desc) run_rnk
from partition_by_clause) X
where run_rnk = 1;

select *,first_value(player_name) over (partition by stadium_name
order by runs desc) top_scorer
from partition_by_clause
where country = 'India'

select *,first_value(player_name) over (partition by stadium_name,year
order by runs desc) top_scorer
from partition_by_clause
where country = 'India';

select *,last_value(player_name) over (partition by stadium_name,year
order by runs desc
rows between unbounded preceding and unbounded following) lowest_scorer
from partition_by_clause
where country = 'India';

-- diff between top scorer and other player
select *,first_value(runs) over (partition by stadium_name
order by runs desc)  - runs as   diff_runs
from partition_by_clause
where country = 'India';



































































drop table partition_by_clause;