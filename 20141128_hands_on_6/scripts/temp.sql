  SELECT EXTRACT(HOUR FROM CURRENT_TIMESTAMP)  FROM DUAL;
  SELECT EXTRACT(MINUTE FROM CURRENT_TIMESTAMP) FROM DUAL;
  SELECT TO_CHAR(SYSDATE,'D') FROM DUAL;
  
update product set descrip = 'not allowed';
update emp set deptno = 20;
commit;

select * from AUDIT_TABLE_EMP;
select * from AUDIT_TABLE_EMP_VALUES;


SELECT * FROM item WHERE ordid = 622;
SELECT * FROM ord WHERE ordid = 622;
UPDATE item
SET qty = 10
WHERE ordid = 622 AND prodid = 100870;
UPDATE ord
SET custid = 101
WHERE ordid = 622;
UPDATE ord
SET shipdate = SYSDATE
WHERE ordid = 622;
UPDATE item
SET qty = 100
WHERE ordid = 622 AND prodid = 100870;
UPDATE ord
SET custid = 102
WHERE ordid = 622;

select * from item order by itemid desc
INSERT INTO ITEM VALUES(622, 101, 100860, 100.0, 10.0, 1000.0);

  SELECT COUNT(DISTINCT i.itemid) INTO cnt FROM ITEM i
  INNER JOIN
      ORD o ON (o.ordid = i.ordid) AND (o.shipdate is null)
  WHERE
      i.itemid = itemid;
      
      
      
