use advanced_sql;

show tables;

select * from running_sum_state;



select *,nth_value(sales,4) over(partition by state
order by date asc) day_four_sales
from running_sum_state;

select *,ntile(3) over(partition by state
order by sales) parts
from running_sum_state;



select *,ntile(3) over(partition by state
order by sales desc) parts
from running_sum_state
where state = 'Bihar';




