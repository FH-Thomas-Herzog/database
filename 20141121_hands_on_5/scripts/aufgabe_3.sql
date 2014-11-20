-- Checks the credit limit of the customers and sets a flag if insufficent deposit
CREATE OR REPLACE PROCEDURE CHECK_CREDITLIMIT AS
  total NUMBER;
  limit_indicator VARCHAR(3);
  CURSOR customerCursor IS SELECT custid, creditlimit, creditlimit_indicate FROM CUSTOMER;
  tuple customerCursor%ROWTYPE;
BEGIN
  -- Open the cursor
  OPEN customerCursor;
  
  -- Iterate over the results
  LOOP
    -- Get the result tuple 
    FETCH customerCursor into tuple;
    EXIT WHEN customerCursor%NOTFOUND;
    -- Get the current credit of the current customer
    SELECT SUM(total) INTO total FROM ORD WHERE custId = tuple.custid;
    
    -- Check the credit limit for the current customer and set or reset the flag
    IF (total IS NOT NULL) AND (total > tuple.creditlimit) THEN
      limit_indicator := 'YES';
    ELSE
      limit_indicator := 'NO';
    END IF;
    
    -- Check if the flag has changed, if yes perform update otherwise do nothing 
    IF limit_indicator <> tuple.creditlimit_indicate THEN
      UPDATE CUSTOMER SET creditlimit_indicate=limit_indicator WHERE custid = tuple.custid;
    END IF;
    
  END LOOP;
  
  -- Close the cursor
  CLOSE customerCursor;
  
END CHECK_CREDITLIMIT;

/ 

begin
CHECK_CREDITLIMIT();
end;