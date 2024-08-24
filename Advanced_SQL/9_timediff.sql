select * from train_data;

create view temp_view as 
select *,lead(timings) over(partition by train_number order by timings)  time_2 from train_data;

select * from temp_view;

-- drop view temp_view;

select * ,timediff(time_2,timings) as time_diff from temp_view;