CREATE OR REPLACE TRIGGER BUSINESS_RULES 
BEFORE INSERT OR UPDATE OR DELETE ON PRODUCT
FOR EACH ROW
DECLARE
  -- day border
  -- Attention: Does depend on territory setting, so take care of this
  bottom_day NUMBER := 2;
  top_day NUMBER := 6;
  
  -- bottom time border
  bottom_hour NUMBER := 8;
  bottom_minute NUMBER := 0;
  
  -- top time border
  top_hour NUMBER := 17;
  top_minute NUMBER := 59;
  
  -- current values
  current_day_of_week NUMBER;
  current_hour NUMBER;
  current_minute NUMBER;
BEGIN
  -- Get current day of week
  -- It seems that in oracle this is territory depended, so will have to be changed
  -- if the database territory is supposed to be changed.
  SELECT TO_CHAR(SYSDATE,'D') INTO current_day_of_week FROM DUAL;
  
  -- check if within day borders
  IF NOT ((current_day_of_week >= bottom_day) AND (current_day_of_week <= top_day)) THEN
    raise_application_error(-20001, 'No modification is allowed today (allowed on Monday - Friday [08:00 - 17:59])');
    rollback;
  END IF;
  
  -- get current thour and time
  SELECT EXTRACT(HOUR FROM CURRENT_TIMESTAMP) INTO current_hour FROM DUAL;
  SELECT EXTRACT(MINUTE FROM CURRENT_TIMESTAMP) INTO current_minute FROM DUAL;
  
  -- check if hour and time are within borders
  IF NOT ((current_hour >= bottom_hour) AND (current_hour <= top_hour)) THEN
    raise_application_error(-20001, 'Modifications are not allowed now (allowed on Monday - Friday [08:00 - 17:59])');
    rollback;
  END IF;
  -- check within time borders
END;

/

-- Tests for trigger
-- Case 1: try update
--         This test depends on the current timestamp, so modify the trigger and redeploy if
--         you want to testt he different cases
UPDATE PRODUCT SET descrip = 'modified';
commit;