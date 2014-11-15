CREATE OR REPLACE PROCEDURE CHECK_CREDITLIMIT AS
  customer_id CUSTOMER.custid%TYPE;
  customer_limit CUSTOMER.creditlimit%TYPE;
  limit_indicator CUSTOMER.creditlimit_indicate%TYPE;
  tot NUMBER;
  CURSOR cr IS SELECT custid, creditlimit INTO customer_id, customer_limit FROM CUSTOMER;
BEGIN
  OPEN cr;
  
  LOOP
    FETCH custid into customerId;
    EXIT WHEN customer_id%NOTFOUND;
    
    SELECT MAX(total) INTO tot FROM ORD WHERE custId = customer_id;
    IF(tot > customer_limit) THEN
      limit_indicator := 'YES';
    ELSE
      limit_indicator := 'NO';
    END IF;
      UPDATE CUSTOMER SET creditlimit_indicate=limit_indicator WHERE custid = customer_id;
  END LOOP;
END CHECK_CREDITLIMIT;