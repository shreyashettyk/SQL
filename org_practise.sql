create database org;
use org;
source  org.sql;


/*Q-1. Write an SQL query to fetch “FIRST_NAME” from Worker table using the alias name as <WORKER_NAME>.*/

SELECT FIRST_NAME AS WORKER_NAME FROM worker;

/*2. Write an SQL query to fetch “FIRST_NAME” from Worker table in upper case.*/

SELECT upper(FIRST_NAME) AS WORKER_NAME FROM worker;

/*3. Write an SQL query to fetch unique values of DEPARTMENT from Worker table.*/

SELECT distinct DEPARTMENT FROM worker;

/*4. Write an SQL query to print the first three characters of  FIRST_NAME from Worker table.*/

SELECT substring(FIRST_NAME,1,3) FROM worker;

/*5. Write an SQL query to find the position of the alphabet (‘a’) in the first name column ‘Amitabh’ from Worker table.*/

SELECT position('a' in FIRST_NAME) AS CHAR_POSITION FROM worker where FIRST_NAME = 'Amitabh';

/*6. Write an SQL query to print the FIRST_NAME from Worker table after removing white spaces from the right side.*/

SELECT RTRIM(FIRST_NAME) FROM worker;

/*7. Write an SQL query to print the DEPARTMENT from Worker table after removing white spaces from the left side.*/

select ltrim(DEPARTMENT) from worker;


/*8. Write an SQL query that fetches the unique values of DEPARTMENT from Worker table and prints its length.*/
select  distinct LENGTH(DEPARTMENT) as NUMBER_OF_CHARACTERS FROM worker;


/*9. Write an SQL query to print the FIRST_NAME from Worker table after replacing ‘a’ with ‘A’.*/

select REPLACE(FIRST_NAME,'a','A') as REPLACED_STRING FROM worker;

/*10. Write an SQL query to print the FIRST_NAME and LAST_NAME from Worker table into a single column COMPLETE_NAME. 
A space char should separate them.*/
select concat_ws(' ',FIRST_NAME,LAST_NAME) as FULL_NAME FROM worker;
