-- Audits the table EMP by logging the access and modified values sal, deptno in separate tables.
CREATE OR REPLACE TRIGGER AUDIT_EMPLOYEE
BEFORE INSERT OR UPDATE OR DELETE ON EMP
REFERENCING OLD AS old_entry NEW AS new_entry
FOR EACH ROW
DECLARE
  dml_type VARCHAR(10);
  emp_no NUMBER;
  sal_differ NUMBER := 0;
  deptno_differ NUMBER := 0;
  position NUMBER := 0;
  new_val NUMBER := 0;
  old_val NUMBER := 0;
BEGIN

  -- In case of insert
  IF INSERTING THEN 
    dml_type := 'INSERT';
    emp_no := :new_entry.empno;
  END IF;
  
  -- In case of insert
  IF DELETING THEN 
    dml_type := 'DELETE';
    emp_no := :old_entry.empno;
  END IF;
  
  -- In case of insert
  IF UPDATING THEN 
    dml_type := 'UPDATE';
    emp_no := :old_entry.empno;
    IF :old_entry.sal <> :new_entry.sal THEN 
      sal_differ := 1;
    END IF;
    IF :old_entry.deptno <> :new_entry.deptno THEN 
      deptno_differ := 1;
    END IF;
  END IF;
  
  -- Insert audit entry
  INSERT INTO AUDIT_TABLE_EMP(ID, MOD_USR, MOD_DAT, ACCESS_TYPE, EMPNO) VALUES (SEQ_AUTID_TABLE_EMPT.NEXTVAL, USER, CURRENT_TIMESTAMP, dml_type, emp_no);

  -- check if sal differs
  IF sal_differ = 1 THEN
    position := position + 1;
    INSERT INTO AUDIT_TABLE_EMP_VALUES(ATE_ID, POSITION, ATTRIBUTE_NAME, ATTRIBUTE_OLD, ATTRIBUTE_NEW) VALUES (SEQ_AUTID_TABLE_EMPT.CURRVAL, position, 'SAL', :old_entry.sal, :new_entry.sal);
  END IF;
  IF deptno_differ = 1 THEN
    position := position + 1;
    INSERT INTO AUDIT_TABLE_EMP_VALUES(ATE_ID, POSITION, ATTRIBUTE_NAME, ATTRIBUTE_OLD, ATTRIBUTE_NEW) VALUES (SEQ_AUTID_TABLE_EMPT.CURRVAL, position, 'DEPTNO', :old_entry.deptno, :new_entry.deptno);
  END IF;
END;

/

-- Tests for trigger
SELECT * FROM EMP;
SELECT * FROM AUDIT_TABLE_EMP;
SELECT * FROM AUDIT_TABLE_EMP_VALUES;
UPDATE EMP SET sal = 1234.0;
commit;
UPDATE EMP SET deptno = 10;
commit;

-- Display logs
SELECT * FROM AUDIT_TABLE_EMP;
SELECT * FROM AUDIT_TABLE_EMP_VALUES;
-- Clear logs
DELETE FROM AUDIT_TABLE_EMP_VALUES;
DELETE FROM AUDIT_TABLE_EMP;