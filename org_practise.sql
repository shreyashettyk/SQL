CREATE database org;
use org;
source  org.sql;


/*Q-1. Write an SQL query to fetch “FIRST_NAME” FROM Worker TABLE using the alias name as <WORKER_NAME>.*/

SELECT FIRST_NAME AS WORKER_NAME FROM worker;

/*2. Write an SQL query to fetch “FIRST_NAME” FROM Worker TABLE in upper case.*/

SELECT upper(FIRST_NAME) AS WORKER_NAME FROM worker;

/*3. Write an SQL query to fetch unique values of DEPARTMENT FROM Worker TABLE.*/

SELECT distinct DEPARTMENT FROM worker;

/*4. Write an SQL query to print the first three characters of  FIRST_NAME FROM Worker TABLE.*/

SELECT substring(FIRST_NAME,1,3) FROM worker;

/*5. Write an SQL query to find the position of the alphabet (‘a’) in the first name column ‘Amitabh’ FROM Worker TABLE.*/

SELECT position('a' in FIRST_NAME) AS CHAR_POSITION FROM worker WHERE FIRST_NAME = 'Amitabh';

/*6. Write an SQL query to print the FIRST_NAME FROM Worker TABLE after removing white spaces FROM the right side.*/

SELECT RTRIM(FIRST_NAME) FROM worker;

/*7. Write an SQL query to print the DEPARTMENT FROM Worker TABLE after removing white spaces FROM the left side.*/

SELECT ltrim(DEPARTMENT) FROM worker;


/*8. Write an SQL query that fetches the unique values of DEPARTMENT FROM Worker TABLE and prints its length.*/
SELECT  distinct LENGTH(DEPARTMENT) as NUMBER_OF_CHARACTERS FROM worker;


/*9. Write an SQL query to print the FIRST_NAME FROM Worker table after replacing ‘a’ with ‘A’.*/

SELECT REPLACE(FIRST_NAME,'a','A') as REPLACED_STRING FROM worker;

/*10. Write an SQL query to print the FIRST_NAME and LAST_NAME FROM Worker table into a single column COMPLETE_NAME. 
A space char should separate them.*/
SELECT concat_ws(' ',FIRST_NAME,LAST_NAME) as FULL_NAME FROM worker;


/*11. Write an SQL query to print all Worker details FROM the Worker table ORDER BY FIRST_NAME Ascending.*/

SELECT * 
FROM worker
ORDER BY FIRST_NAME ASC;

/*12. Write an SQL query to print all Worker details FROM the Worker table ORDER BY FIRST_NAME Ascending and DEPARTMENT Descending.*/

SELECT * 
FROM worker
ORDER BY FIRST_NAME ASC,DEPARTMENT DESC;

/*13. Write an SQL query to print details for Workers with the first name as “Vipul” and “Satish” FROM Worker table.*/

SELECT * FROM WORKER
WHERE FIRST_NAME in ('Vipul','Satish');

/*Write an SQL query to print details of workers excluding first names, “Vipul” and “Satish” FROM Worker table.*/

SELECT * 
FROM WORKER
WHERE FIRST_NAME NOT IN ('Vipul','Satish');

/*15. Write an SQL query to print details of Workers with DEPARTMENT name as “Admin”.*/

SELECT * 
FROM WORKER 
WHERE DEPARTMENT = 'Admin';

/*16.Write an SQL query to print details of the Workers whose FIRST_NAME contains ‘a’*/

SELECT * 
FROM worker 
WHERE FIRST_NAME LIKE '%a%';

/*17. Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘a’*/

SELECT * 
FROM worker 
WHERE FIRST_NAME LIKE '%a';

/*18. Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘h’ and contains six alphabets.*/

SELECT * FROM WORKER 
WHERE FIRST_NAME LIKE '_____h';

/*19. Write an SQL query to print details of the Workers whose SALARY lies between 100000 and 500000.*/

SELECT * FROM WORKER 
WHERE SALARY BETWEEN 100000 AND 500000;

/*20. Write an SQL query to print details of the Workers who have joined in Feb’2014.*/

SELECT * FROM WORKER 
WHERE JOINING_DATE 
LIKE '2014-02-%';

/*21. Write an SQL query to fetch the count of employees working in the department ‘Admin’.*/

SELECT COUNT(*) AS ADMIN_CNT 
FROM WORKER 
WHERE DEPARTMENT='Admin';

/*22. Write an SQL query to fetch worker names with salaries >= 50000 and <= 100000.*/
 
SELECT concat_ws(' ',FIRST_NAME,LAST_NAME) AS NAMES 
FROM WORKER 
WHERE SALARY >= 50000 AND SALARY<=100000;


/*23. Write an SQL query to fetch the no. of workers for each department in the descending order.*/

SELECT distinct DEPARTMENT , COUNT(*)  PER_DEPARTMENT_EMP_COUNT 
FROM WORKER 
GROUP BY department 
ORDER BY PER_DEPARTMENT_EMP_COUNT;


/*24. Write an SQL query to print details of the Workers who are also Managers.*/

SELECT * 
FROM WORKER 
WHERE WORKER_ID IN 
(SELECT  WORKER_REF_ID 
FROM TITLE WHERE 
WORKER_TITLE = 'MANAGER');

/*25. Write an SQL query to fetch duplicate records having matching data in some fields of a table.*/

/*26. Write an SQL query to show only odd rows FROM a table.*/
select * 
FROM worker
WHERE MOD(worker_id,2) <> 0;

/*27. Write an SQL query to show only even rows FROM a table.*/
select *
FROM worker 
WHERE MOD(worker_id,2) = 0;

/*28. Write an SQL query to clone a new TABLE FROM another TABLE.*/
CREATE TABLE workerclone as SELECT * FROM worker;

/*29. Write an SQL query to fetch intersecting records of two tables.*/
-- (select worker_id 
 -- FROM worker
 -- WHERE first_name like '%a%')
 -- INTERSECT
 -- (select worker_ref_id 
  -- FROM title
  -- WHERE worker_title='lead');
  
/*30. Write an SQL query to show records FROM one table that another table does not have.*/

/*31. Write an SQL query to show the current date and time.*/
SELECT CURDATE() 
SELECT NOW()

/*32. Write an SQL query to show the top n (say 10) records of a table.*/

SELECT * FROM WORKER LIMIT 2;

/*33. Write an SQL query to determine the nth (say n=5) highest salary FROM a table.*/

SELECT WORKER_ID,concat_ws(' ',first_name,last_name) as FULL_NAME FROM WORKER ORDER BY SALARY DESC limit 1 offset 4;

/*34. Write an SQL query to determine the 5th highest salary without using TOP or limit method.*/
SELECT WORKER_ID,CONCAT_WS(' ',FIRST_NAME,LAST_NAME) AS FULLNAME FROM WORKER 

SELECT  max(SALARY) from worker order by SALARY 

/*one way is to run two seperate queries . The second outcome will 
be run based on the output seen FROM the first query*/
SELECT worker_id FROM worker ORDER BY salary desc;
SELECT worker_id, first_name , salary FROM worker WHERE worker_id = 1;


/*35. Write an SQL query to fetch the list of employees with the same salary.*/

SELECT w.worker_id,w.salary,w.first_name FROM worker w, worker w1 WHERE w.salary=w1.salary and w.worker_id <> w1.worker_id;

/*36. Write an SQL query to show the second highest salary FROM a TABLE.*/
SELECT max(salary) FROM worker WHERE salary < (SELECT max(salary) FROM worker);

/*39. Write an SQL query to fetch the first 50% records FROM a TABLE. */
SELECT * FROM worker WHERE worker_id <= (SELECT count(worker.worker_id)/2 FROM worker);

/**/

/*40. Write an SQL query to fetch the departments that have less than five people in it.*/
SELECT worker.department FROM worker GROUP BY(department) having count(*) < 5;

/*41. Write an SQL query to show all departments along with the number of people in there.*/

SELECT department,count(worker_id) as NUM_OF_EMP FROM worker GROUP BY department

/*42. Write an SQL query to show the last record FROM a table.*/
SELECT * FROM worker ORDER BY worker_id desc limit 1;

/*43. Write an SQL query to fetch the first row of a table.*/
SELECT * FROM worker ORDER BY worker_id asc limit 1;

/*44. Write an SQL query to fetch the last five records FROM a table.*/

SELECT * from worker order by worker_id desc limit 5;

/*Write an SQL query to print the name of employees having the highest salary in each department.*/
select first_name,salary,department from worker where salary in (select max(salary) from worker group by department);

