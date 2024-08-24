drop table if exists department;
CREATE TABLE department(Dept VARCHAR(200)); 

 INSERT INTO department(Dept) 
 VALUES('Engineering'),
('Marketing'),
('Legal'),
('Finance'),
('HR');

drop table if exists shift;
CREATE TABLE shift(Id VARCHAR(200)); 

 INSERT INTO shift(Id) 
 VALUES('Day'),
('AfterNoon'),
('Night');


drop table if exists country;
CREATE TABLE country(Name VARCHAR(200)); 

 INSERT INTO country(Name) 
 VALUES('India'),
('US');



select * from country;
select * from department;
select * from shift;



select d.*,c.*,s.*
from country c,department d,shift s ;

select X.*,case
 when X.Id = 'Day' then '7:00 a.m. to 3:00 p.m'
 when X.Id = 'Afternoon' then '3:00 p.m. to 11:00 p.m.'
 else '11:00 p.m to 7:00 a.m'
end Timings
from (
select d.*,c.*,s.*
from country c,department d,shift s ) X;

select * from emp_data;

select e1.ID,e1.name,e1.salaray
from emp_data e1 ,emp_data e2
where e1.Mgr_ID = e2.ID
and e1.salaray > e2.salaray ; 
