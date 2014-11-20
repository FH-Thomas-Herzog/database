-- Gets the product count of a customer
CREATE OR REPLACE FUNCTION GET_PTODUCT_COUNT (cust_id IN NUMBER)
RETURN 
  NUMBER 
IS
  cnt NUMBER;
  no_customer EXCEPTION;
BEGIN
  -- Count of 0 indicates no customer found 
  SELECT COUNT(*) INTO cnt FROM CUSTOMER WHERE custid = cust_id;
  IF cnt = 0 THEN
    RAISE no_customer;
  END IF;
  
  -- Select the count of the purchased products of the customer 
  cnt := 0;
  SELECT 
      COUNT(DISTINCT p.prodid) INTO cnt FROM PRODUCT p
  INNER JOIN 
      ITEM i ON i.prodid = p.prodid
  INNER JOIN 
      ORD o ON o.ordid = i.ordid
  INNER JOIN 
      CUSTOMER c ON (o.custid = c.custid) 
  WHERE
      c.custid = cust_id;
  
  RETURN cnt;
  
-- Handle exceptions
EXCEPTION
  WHEN no_customer THEN
    dbms_output.put_line('Customer could not be found');
    RETURN NULL;
  WHEN OTHERS THEN 
    dbms_output.put_line('An unexpected error occurred !!! SQLCODE: ' || SQLCODE ||' | SQLMESSAGE: ' || SUBSTR(SQLERRM, 1, 200));
    RETURN NULL;
END GET_PTODUCT_COUNT;

/ 

-- Test
select custid, GET_PTODUCT_COUNT(custid) fROM Customer;