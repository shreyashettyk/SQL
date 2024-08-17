select * from tatasteel;

select *,avg(close) over (
order by date
rows between 2 preceding and current row) three_day_avg,
avg(close) over (
order by date
rows between 4 preceding and current row) five_day_avg
from tatasteel;