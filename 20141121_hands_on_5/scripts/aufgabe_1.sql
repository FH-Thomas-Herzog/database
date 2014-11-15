create or replace PROCEDURE ADD_ORDER (cust_id NUMBER, complan VARCHAR2) AS
  customer_id NUMBER;
  commission_plan_missing EXCEPTION;
BEGIN

  SELECT custid INTO customer_id FROM CUSTOMER where custid = cust_id;
  
  INSERT INTO ORD (ORDID, ORDERDATE, COMMPLAN, CUSTID)
    VALUES (ORDID.NEXTVAL, SYSDATE, complan, cust_id);
    
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    dbms_output.put_line('No customer found');
  WHEN OTHERS THEN
    dbms_output.put_line('An unexpected error occurred !!! SQLCODE: ' || SQLCODE);
    
END ADD_ORDER;
/
create or replace PROCEDURE ADD_ITEM (order_number NUMBER, product_number NUMBER, price NUMBER, amount NUMBER) AS
  cnt NUMBER;
  product_not_found EXCEPTION;
  order_not_found EXCEPTION;
  no_price EXCEPTION;
  no_amount EXCEPTION;
BEGIN
  -- Empty count indicates not order exists
  SELECT COUNT(*) INTO cnt FROM ORD where ORDID = order_number;
  IF cnt = 0 THEN
    RAISE order_not_found;
  END IF;
  
  -- Empty count indicates product not found
  SELECT COUNT(*) INTO cnt FROM PRODUCT WHERE prodid = product_number;
  IF cnt = 0 THEN
    RAISE product_not_found;
  END IF;
  
  -- Price and amount are not supposed to be empty
  IF price IS NULL THEN
    RAISE no_price;
  END IF;
  IF amount IS NULL THEN 
    RAISE no_amount;
  END IF;
  
  -- get highest item count 
  SELECT COALESCE(MAX(itemid),0) INTO cnt FROM ITEM WHERE ordid = order_number;
  
  -- Add item to order
  INSERT INTO ITEM (ORDID, ITEMID, PRODID, ACTUALPRICE, QTY, ITEMTOT)
    VALUES (order_number, (cnt + 1), product_number, price, amount, (amount * price));
  
EXCEPTION
  WHEN no_price THEN
    dbms_output.put_line('Price must be defined');
  WHEN no_amount THEN
    dbms_output.put_line('Amount must be defined');
  WHEN order_not_found THEN
    dbms_output.put_line('Order not found !!! ordid:' || order_number);
  WHEN product_not_found THEN
    dbms_output.put_line('Product not found !!! prodid:' || product_number);
  WHEN NO_DATA_FOUND THEN
    dbms_output.put_line('Order not found !!! ordId:' || order_number);
  WHEN OTHERS THEN
    dbms_output.put_line('An unexpected error occurred !!! SQLCODE: ' || SQLCODE ||' | SQLMESSAGE: ' || SUBSTR(SQLERRM, 1, 200));
END ADD_ITEM;