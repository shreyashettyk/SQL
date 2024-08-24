drop table if exists details;
-- create a table
CREATE TABLE details (
  custid varchar(200),
  orderid integer,
  item varchar(200),
  quantity integer 
);
-- insert some values
INSERT INTO details(custid,orderid,item,quantity) 
values ('c1',1, 'mouse', 2),
('c1',1, 'keyboard', 3),
('c1',1, 'headphone', 5),
('c1',1, 'laptop',1 ),
('c1',1, 'pendrive', 3),
('c2',1, 'tv', 2),
('c2',1, 'washing machine', 2),
('c2',1, 'mobile', 1),
('c2',1, 'earphones',3 );



select * from details;
select group_concat(item) from details;
select group_concat(item,',') from details;
select concat(item,',') from details;

select concat(item,'-',quantity) ITEM_QTY from details;

select group_concat(ITEM_QTY)
from (select concat(item,'-',quantity) ITEM_QTY from details) X;

select group_concat( item)  summary from details order by quantity  desc;

select * from details;

select custid,orderid,
concat(custid,'-',orderid) cust_order,
concat(item,'-',quantity) item_qty  from details;


select cust_order,group_concat(item_qty) as summary
from (select custid,orderid,
concat(custid,'-',orderid) cust_order,
concat(item,'-',quantity) item_qty  from details) X
group by cust_order;





