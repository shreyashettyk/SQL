select * from running_sum_state;

-- alternate to first_value 

select state,min(date) as first_date,sales
from running_sum_state
group by state;


select *, first_value(sales)  over (
partition by state
order by date 
) FIRST_DAY_SALES
from running_sum_state;

select *, last_value(sales)  over (
partition by state
order by date 
rows between unbounded preceding and unbounded following 
) LAST_DAY_SALES
from running_sum_state;


select state, nth_value(sales,5)  over (
partition by state
order by date 
) fifth_DAY_SALES
from running_sum_state;
