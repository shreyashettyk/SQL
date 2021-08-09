/*Solved questions FROM case study 1 of https://8weeksqlchallenge.com/case-study-1/ */

/*1. What is the total amount each customer spent at the restaurant?*/

SELECT customer_id,product_name,SUM(price) TOTAL_PRICE 
FROM sales join menu on sales.product_id = menu.product_id 
GROUP BY sales.customer_id;

/*2. How many days has each customer visited the restaurant?*/

 SELECT customer_id,count(customer_id) VISITS FROM sales GROUP BY customer_id;
 
/*3. What was the first item FROM the menu purchased by each customer?*/

(
 (SELECT customer_id,product_id FROM sales WHERE customer_id = 'A' ORDER BY order_date asc limit 1) 
  union 
  (SELECT customer_id,product_id FROM sales WHERE customer_id = 'B' ORDER BY order_date asc limit 1)
  union 
  (SELECT customer_id,product_id FROM sales WHERE customer_id = 'C' ORDER BY order_date asc limit 1)
)

/*4. What is the most purchased item on the menu and how many times was it purchased by all customers?*/

SELECT sales.product_id,count(sales.product_id) Purchase_Count,menu.product_name  FROM sales,menu GROUP BY product_id WHERE sales.product_id = menu.product_id ORDER BY Purchase_Count desc limit 1;

 
/*5. Which item was the most popular for each customer?*/ 
(
(SELECT customer_id,product_id,count(product_id) Number_of_times_purchased 
  FROM sales WHERE customer_id = 'A' 
  GROUP BY product_id ORDER BY Number_of_times_purchased desc limit 1) 
  union 
  (SELECT customer_id,product_id,count(product_id) Number_of_times_purchased
  FROM sales WHERE customer_id = 'B' 
  GROUP BY product_id ORDER BY Number_of_times_purchased desc limit 1) 
  union 
  (SELECT customer_id,product_id,count(product_id) Number_of_times_purchased
  FROM sales WHERE customer_id = 'C' 
  GROUP BY product_id ORDER BY Number_of_times_purchased desc limit 1)
);

/*In the above query in case of customer_id B, the customer purchases all the products same number of times. So in that situation 
   the query displays only the first product FROM the resultset*/
   
 /*6.Which item was purchased first by the customer after they became a member?*/

 (
 (SELECT sales.customer_id,sales.product_id 
 FROM sales,members 
 WHERE sales.customer_id = 'A' 
 and sales.customer_id = members.customer_id  and sales.order_date>members.join_date 
 GROUP BY sales.customer_id  limit 1) 
 UNION 
 (SELECT sales.customer_id,sales.product_id 
 FROM sales,members 
 WHERE sales.customer_id = 'B' 
 and sales.customer_id = members.customer_id  and sales.order_date>members.join_date 
 GROUP BY sales.customer_id  limit 1) 
 UNION 
 (SELECT sales.customer_id,sales.product_id 
 FROM sales,members 
 WHERE sales.customer_id = 'C' 
 and sales.customer_id = members.customer_id  and sales.order_date>members.join_date 
 GROUP BY sales.customer_id  limit 1)
); 


/*7. Which item was purchased just before the customer became a member?*/
(
 (SELECT sales.customer_id,sales.product_id 
 FROM sales,members 
 WHERE sales.customer_id = 'A' 
 and sales.customer_id = members.customer_id  and sales.order_date<members.join_date 
 GROUP BY sales.customer_id  ) 
 UNION 
 (SELECT sales.customer_id,sales.product_id 
 FROM sales,members 
 WHERE sales.customer_id = 'B' 
 and sales.customer_id = members.customer_id  and sales.order_date<members.join_date 
 GROUP BY sales.customer_id  ) 
 UNION 
 (SELECT sales.customer_id,sales.product_id 
 FROM sales,members 
 WHERE sales.customer_id = 'C' 
 and sales.customer_id = members.customer_id  and sales.order_date<members.join_date 
 GROUP BY sales.customer_id  )
); 

/*8.What is the total items and amount spent for each member before they became a member?*/
(
(SELECT sales.customer_id,count(sales.product_id) TOTAL_ITEMS,sum(menu.price) AMT_SPENT
 FROM sales,members,menu
 WHERE sales.customer_id = 'A' 
 and sales.customer_id = members.customer_id  and sales.order_date<members.join_date 
 GROUP BY sales.customer_id  ) 
 UNION
 (SELECT sales.customer_id,count(sales.product_id) TOTAL_ITEMS,sum(menu.price) AMT_SPENT
 FROM sales,members,menu
 WHERE sales.customer_id = 'B' 
 and sales.customer_id = members.customer_id  and sales.order_date<members.join_date 
 GROUP BY sales.customer_id  ) 
 UNION
 (SELECT sales.customer_id,count(sales.product_id) TOTAL_ITEMS,sum(menu.price) AMT_SPENT
 FROM sales,members,menu
 WHERE sales.customer_id = 'C' 
 and sales.customer_id = members.customer_id  and sales.order_date<members.join_date 
 GROUP BY sales.customer_id  ) 
);  


Recreate the following table output using the available data:

customer_id	order_date	product_name	price	member
A	2021-01-01	curry	15	N
A	2021-01-01	sushi	10	N
A	2021-01-07	curry	15	Y
A	2021-01-10	ramen	12	Y
A	2021-01-11	ramen	12	Y
A	2021-01-11	ramen	12	Y
B	2021-01-01	curry	15	N
B	2021-01-02	curry	15	N
B	2021-01-04	sushi	10	N
B	2021-01-11	sushi	10	Y
B	2021-01-16	ramen	12	Y
B	2021-02-01	ramen	12	Y
C	2021-01-01	ramen	12	N
C	2021-01-01	ramen	12	N
C	2021-01-07	ramen	12	N

SELECT sales.customer_id,sales.order_date,menu.product_name,menu.price, if(members.customer_id = sales.customer_id,'Y','N') as col
FROM sales 
JOIN menu on sales.product_id = menu.product_id 
JOIN members on sales.customer_id = members.customer_id;

              OR
			  
 SELECT sales.customer_id,sales.order_date,menu.product_name,menu.price, 
 if(members.customer_id = sales.customer_id,'Y','N') as col 
 FROM members, sales 
 JOIN menu on sales.product_id = menu.product_id;