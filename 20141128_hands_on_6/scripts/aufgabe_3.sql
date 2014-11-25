-- This trigger checks if item can be inserted, updated or deleted depending on the shipdate value
-- Is not null shipdate then no insert, update, delete is allowed to be performed on the ITEM table
CREATE OR REPLACE TRIGGER ITEM_ORDER_SHIPPED
BEFORE INSERT OR UPDATE OR DELETE ON ITEM
REFERENCING OLD AS old_entry NEW AS new_entry
FOR EACH ROW
DECLARE 
  ord_id NUMBER := 0;
  item_id NUMBER := 0;
  cnt NUMBER := 0;
BEGIN

  -- get releated ordid value from either old or new entry
  IF INSERTING THEN
    item_id := :new_entry.itemid;
    ord_id := :new_entry.ordid;
  END IF;
  IF UPDATING OR DELETING THEN
    item_id := :old_entry.itemid;
    ord_id := :new_entry.ordid;
  END IF;
  
  -- check if order is already shipped
  SELECT COUNT(*) INTO cnt FROM ORD
  WHERE
      ordid = ord_id
  AND
      shipdate IS NULL;
  
  IF cnt = 0 THEN
    raise_application_error(-20001, 'Order already shipped therefore no changes on releated items are allowed to be performed');
    rollback;
  END IF;
END;
   
/

-- Checks if ORD table rows are allowed to be updated´or deleted depending on the shipdate value
-- If not null shipdate this trigger wil take place and raise an application error
CREATE OR REPLACE TRIGGER ORD_ORDER_SHIPPED
BEFORE UPDATE OR DELETE ON ORD
REFERENCING OLD AS old_entry NEW AS new_entry
FOR EACH ROW WHEN (old_entry.SHIPDATE IS NOT NULL)

BEGIN
    raise_application_error(-20001, 'Order already shipped therefore no changes on Order table are allowed to be performed');
    rollback;
END;

/

-- Trigger tests
SELECT * FROM ord WHERE ordid = 622;
-- Case 1: failed because already shipped
--         No need to check for update of other columns because trigger does not check for this
--         Trigger just checks for not null shipdate.
--         If not null shipdate present it will raise an application exception
UPDATE ord SET custid = 101 WHERE ordid = 622;

SELECT * FROM ITEM WHERE ordid = 622;
-- Case 2: failed because related order already shipped
INSERT INTO ITEM VALUES(622, 101, 100860, 100.0, 10.0, 1000.0);
-- Case 2: failed because related order already shipped
--         No need for checking for updates on other columns
--         Because trigger checks for not null shipdate on related ord
--         no matter what column gets updated
UPDATE ITEM SET ordid = 621 WHERE ordid = 622;
