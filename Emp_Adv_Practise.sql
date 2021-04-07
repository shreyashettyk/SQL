CREATE database Emp_Adv
use Emp_Adv
source <path of Emp_Adv.sql>

/*#1 CREATE a query that displays EMPFNAME, EMPLNAME, DEPTCODE, DEPTNAME, LOCATION FROM EMPLOYEE, and DEPARTMENT tables. 
Make sure the results are in the ascending order based on the EMPFNAME and LOCATION of the department.*/

SELECT e.empfname,e.emplname,d.deptcode,d.deptname,d.location 
FROM employee e,department d
WHERE e.deptcode=d.deptcode
ORDER BY e.empfname asc,d.location asc;

/*#2 Display EMPFNAME and “TOTAL SALARY” for each employee*/
SELECT e.empfname,e.salary+e.commission as TOTAL_COMMISSION
FROM employee e
ORDER BY TOTAL_COMMISSION;

/*Display MAX and 2nd MAX SALARY FROM the EMPLOYEE table.*/

SELECT MAX(E.SALARY) AS MAX_SAL,
(SELECT MAX(SALARY) 
FROM EMPLOYEE 
WHERE SALARY <(SELECT MAX(SALARY) FROM EMPLOYEE)) AS SECOND_MAX 
FROM EMPLOYEE E;

/*#4 Display the TOTAL SALARY drawn by an analyst working in dept no 20*/

SELECT salary+commission as  TOTAL_COMMISSION
FROM employee 
WHERE deptcode=20 and job='analyst';

/*#5 Compute average, minimum and maximum salaries of the group of employees having the job of ANALYST.*/

SELECT avg(salary),min(salary),max(salary) 
FROM employee
WHERE job = 'analyst'
GROUP BY job;