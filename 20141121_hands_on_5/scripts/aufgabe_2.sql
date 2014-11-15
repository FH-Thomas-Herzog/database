CREATE OR REPLACE FUNCTION GET_PTODUCT_COUNT (cust_id IN NUMBER)
RETURN 
  NUMBER 
IS
  cnt NUMBER;
BEGIN
-- Check for existing customer 
  SELECT COUNT(*) INTO cnt FROM CUSTOMER WHERE custid = cust_id;
  IF cnt > 0 THEN
      -- Select the count of the purchased products of the customer 
      SELECT COUNT(DISTINCT p.prodid) INTO cnt FROM PRODUCT p
      INNER JOIN ITEM i ON i.prodid = p.prodid
      INNER JOIN ORD o ON o.ordid = i.ordid
      INNER JOIN CUSTOMER c ON c.custid = cust_id;
  END IF;
  
  RETURN cnt;
EXCEPTION
  WHEN OTHERS THEN 
    dbms_output.put_line('An unexpected error occurred !!! SQLCODE: ' || SQLCODE ||' | SQLMESSAGE: ' || SUBSTR(SQLERRM, 1, 200));
END GET_PTODUCT_COUNT;