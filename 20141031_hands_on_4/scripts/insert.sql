-- 1. Add some movies
INSERT INTO film VALUES (1, 'STAR WARS 1', 2000, 'George Lucas', 700000);

INSERT INTO film VALUES (2, 'Terminator 3', 2000, 'Michael Bay', 1000000.00);

INSERT INTO film VALUES (3, 'Trainspoting', 1999, 'Hugo OBss', 457896.00);

INSERT INTO film VALUES (4, 'Training Day', 2010, 'Michael Bay', 850000000.00);

INSERT INTO film VALUES (5, 'Galaxy Quest', 2005, 'Michael Bay', 25000);

-- 2. Add some actors
INSERT INTO schauspieler VALUES (1, 'Ewan', 'McGregor', 1971, 'M', 'England', 'Grieff', 2000000, 45000000, 1, NULL);

INSERT INTO schauspieler VALUES (2, 'Arnold', 'Schwarzenegger', 1950, 'M', 'US', 'Los Angeles', 100000, 100000, 2, 'OSCAR');

INSERT INTO schauspieler VALUES (3, 'Denzel', 'Washington', 1960, 'M', 'US', 'New York', 500000.00, 700000.00, 2, 'OSCAR');

INSERT INTO schauspieler VALUES (4, 'Maria', 'Bloom', 1950, 'W', 'DE', 'Berlin', 60000.00, 80000.00, NULL, 'OSCAR');

INSERT INTO schauspieler VALUES (5, 'Greg', 'Newmann', 1970, 'M', 'AT', 'Wien', 60000.00, 3000.00, NULL, 'OSCAR');

-- 3. Add some roles
INSERT INTO rolle VALUES (1, 1, 'Obi-Wan Kenobi', 'N', 1800000);

INSERT INTO rolle VALUES (2, 2, 'Terminator', 'J', 100000000.00); -- Arny is terminator

INSERT INTO rolle VALUES (2, 4, 'Some woman', 'N', 200000000); -- Arny is terminator

INSERT INTO rolle VALUES (4, 3, 'Bad Cop', 'J', 200000000); -- Denzel is bad cop

-- 4. Add some presentations
-- star wars viewings
INSERT INTO vorfuehrungen VALUES (1, 1, 'AT', 'Linz', 'MegaPlexx', TO_DATE('10-JAN-2001', 'DD-MON-YYYY'), 500, 5000);

INSERT INTO vorfuehrungen VALUES (1, 2, 'AT', 'Wien', 'MegaPlexx', TO_DATE('10-JAN-2001', 'DD-MON-YYYY'), 500, 5000);

INSERT INTO vorfuehrungen VALUES (1, 3, 'AT', 'Graz', 'MegaPlexx', TO_DATE('10-JAN-2001', 'DD-MON-YYYY'), 500, 5000);

-- Terminator viewings
INSERT INTO vorfuehrungen VALUES (2, 1, 'AT', 'Linz', 'MegaPlexx', TO_DATE('10-JAN-2001', 'DD-MON-YYYY'), 500, 5000);

INSERT INTO vorfuehrungen VALUES (2, 2, 'AT', 'Wien', 'MegaPlexx', TO_DATE('10-JAN-2001', 'DD-MON-YYYY'), 500, 5000);

INSERT INTO vorfuehrungen VALUES (2, 3, 'AT', 'Graz', 'MegaPlexx', TO_DATE('10-JAN-2001', 'DD-MON-YYYY'), 500, 5000);

-- training day viewings
INSERT INTO vorfuehrungen VALUES (4, 1, 'AT', 'Linz', 'MegaPlexx', TO_DATE('10-JAN-2001', 'DD-MON-YYYY'), 100, 100);

INSERT INTO vorfuehrungen VALUES (4, 2, 'AT', 'Wien', 'MegaPlexx', TO_DATE('10-JAN-2001', 'DD-MON-YYYY'), 100, 200);

INSERT INTO vorfuehrungen VALUES (4, 3, 'AT', 'Graz', 'MegaPlexx', TO_DATE('10-JAN-2001', 'DD-MON-YYYY'), 100, 300);

-- galaxy quest viewings
INSERT INTO vorfuehrungen VALUES (5, 1, 'AT', 'Linz', 'MegaPlexx', TO_DATE('10-JAN-2001', 'DD-MON-YYYY'), 1000, 10000);

INSERT INTO vorfuehrungen VALUES (5, 2, 'AT', 'Wien', 'MegaPlexx', TO_DATE('10-JAN-2001', 'DD-MON-YYYY'), 1000, 10000);

INSERT INTO vorfuehrungen VALUES (5, 3, 'AT', 'Graz', 'MegaPlexx', TO_DATE('10-JAN-2001', 'DD-MON-YYYY'), 1000, 10000);

commit;