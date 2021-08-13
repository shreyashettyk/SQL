
/*1. How many pizzas were ordered? */
 SELECT count(*) as NUMBER_PIZZA_ORDERED 
 FROM customer_orders,runner_orders  
 WHERE customer_orders.order_id = runner_orders.order_id;
 
/* 2. */

/* 3. How many successful orders were delivered by each runner? */ 
  SELECT runner_id,count(runner_id) as SUCCESSFUL_DELIVERIES
  FROM runner_orders 
  WHERE cancellation<>'Restaurant Cancellation' 
  or cancellation<>'Customer Cancellation' 
  GROUP BY(runner_id);
  
/*4. How many of each type of pizza was delivered? */ 
create view distinct_customer_orders as 
SELECT distinct * FROM customer_orders; /*get all unique orders and avoid duplicates*/

SELECT  * FROM distinct_customer_orders;

SELECT pizza_id,count(pizza_id) as NUMBER_SOLD FROM distinct_customer_orders GROUP BY(pizza_id) ;


 