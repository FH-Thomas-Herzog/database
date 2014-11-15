SELECT custid AS customer_id FROM CUSTOMER where custid = -14;
select * from customer;
select * from ord order by ordid desc;
select * from item order by ordid, itemid desc;
SELECT COUNT(*) AS cnt FROM ORD where ORDID = -666;

-- ordid: 626
-- prodid: 100860

EXEC DBMS_OUTPUT.PUT_LINE(GET_PTODUCT_COUNT(100));

select GET_PTODUCT_COUNT(106) from customer;

  SELECT COUNT(DISTINCT p.prodid) FROM PRODUCT p
  INNER JOIN ITEM i ON i.prodid = p.prodid
  INNER JOIN ORD o ON o.ordid = i.ordid
  INNER JOIN CUSTOMER c ON c.custid in (select custid from customer);
  
  SELECT COUNT(*) FROM CUSTOMER WHERE custid = 15445645;
  
  ALTER TABLE customer
ADD (creditlimit_indicate VARCHAR2(3) DEFAULT 'NO'
CONSTRAINT customer_creditlimit_ck CHECK
(creditlimit_indicate IN ('YES', 'NO')));


      UPDATE CUSTOMER SET CREDITLIMIT_INDICATE='YES' WHERE custid = 1000;