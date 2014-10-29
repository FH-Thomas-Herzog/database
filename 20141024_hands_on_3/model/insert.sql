INSERT INTO BESTELLPOLITIK (BESTELL_ART) VALUES ('online');
INSERT INTO BESTELLPOLITIK (BESTELL_ART) VALUES ('EU-only');
INSERT INTO BESTELLPOLITIK (BESTELL_ART) VALUES ('Skonto-only');

-- dependencies for eigenteil 
INSERT INTO TEIL (TNR, BEZEICHNUNG, TEIL_ART, LAGERBESTAND, MENGENEINHEIT)
VALUES (1, 'Dichtung f�r Zulauf/R�cklauf', 'F', 100, 'Stk');

INSERT INTO TEIL (TNR, BEZEICHNUNG, TEIL_ART, LAGERBESTAND, MENGENEINHEIT)
VALUES (2, 'Schraube f�r Assembly', 'F', 100, 'Stk');

INSERT INTO TEIL (TNR, BEZEICHNUNG, TEIL_ART, LAGERBESTAND, MENGENEINHEIT)
VALUES (3, 'Geh�use', 'E', 1000, 'Stk');

INSERT INTO TEIL (TNR, BEZEICHNUNG, TEIL_ART, LAGERBESTAND, MENGENEINHEIT)
VALUES (4, 'Pumpe', 'E', 96, 'Stk');

-- article to sell
INSERT INTO TEIL (TNR, BEZEICHNUNG, TEIL_ART, LAGERBESTAND, MENGENEINHEIT)
VALUES (5, 'Brunnenpumpe', 'A', 120, 'Stk');

-- assemble dependecies
INSERT INTO STRUKTUR (OBER_TNR_ID, UNTER_TNR_ID, MENGE) VALUES (5, 1, 10);
INSERT INTO STRUKTUR (OBER_TNR_ID, UNTER_TNR_ID, MENGE) VALUES (5, 2, 50);
INSERT INTO STRUKTUR (OBER_TNR_ID, UNTER_TNR_ID, MENGE) VALUES (5, 3, 1);
INSERT INTO STRUKTUR (OBER_TNR_ID, UNTER_TNR_ID, MENGE) VALUES (5, 4, 1);

-- work plan
INSERT INTO ARBEITSPLAN (APNR, ERSTELLER, ERSTELLUNGS_DATUM, TNR_ID)
VALUES (1, 'Ing. Thomas Herzog', CURRENT_TIMESTAMP, 5);

-- technices
INSERT INTO TECHNISCHES_VERFAHREN (VNR, BEZEICHNUNG)
VALUES (1, 'Leitung mit Dichtung verbinden');

INSERT INTO TECHNISCHES_VERFAHREN (VNR, BEZEICHNUNG)
VALUES (2, 'Geh�use schweisen');

INSERT INTO TECHNISCHES_VERFAHREN (VNR, BEZEICHNUNG)
VALUES (3, 'Dichtschrauben');

-- work steps
INSERT INTO ARBEITSGANG (APNR_ID, AGNR, VNR_ID)
VALUES(1, 1, 1);

INSERT INTO ARBEITSGANG (APNR_ID, AGNR, VNR_ID)
VALUES(1, 2, 2);

INSERT INTO ARBEITSGANG (APNR_ID, AGNR, VNR_ID)
VALUES(1, 3, 3);

-- used tools
INSERT INTO BETRIEBSMITTEL (BMNR, BEZEICHNUNG, WARTUNG)
VALUES (1, 'Schraubenzieher', CURRENT_TIMESTAMP);

INSERT INTO BETRIEBSMITTEL (BMNR, BEZEICHNUNG, WARTUNG)
VALUES (2, 'Schweisger�t', CURRENT_TIMESTAMP);

INSERT INTO BETRIEBSMITTEL (BMNR, BEZEICHNUNG, WARTUNG)
VALUES (3, 'Dichtungsmittelspritze', CURRENT_TIMESTAMP);

-- tools work step assignment
INSERT INTO AG_BM_ZUORDNUNG (APNR_ID, AGNR_ID, BMNR_ID, RUESTZEIT, ARBEITSZEIT)
VALUES (1, 1, 3, 60, 200);

INSERT INTO AG_BM_ZUORDNUNG (APNR_ID, AGNR_ID, BMNR_ID, RUESTZEIT, ARBEITSZEIT)
VALUES (1, 1, 2, 500, 2000);

INSERT INTO AG_BM_ZUORDNUNG (APNR_ID, AGNR_ID, BMNR_ID, RUESTZEIT, ARBEITSZEIT)
VALUES (1, 1, 1, 10, 1560);

-- compononent assignment
INSERT INTO AG_KOMP_ZUORDNUNG (APNR_ID, AGNR_ID, TNR_ID, MENGE)
VALUES (1, 1, 1, 20);

INSERT INTO AG_KOMP_ZUORDNUNG (APNR_ID, AGNR_ID, TNR_ID, MENGE)
VALUES (1, 1, 4, 1);

INSERT INTO AG_KOMP_ZUORDNUNG (APNR_ID, AGNR_ID, TNR_ID, MENGE)
VALUES (1, 2, 3, 1);

INSERT INTO AG_KOMP_ZUORDNUNG (APNR_ID, AGNR_ID, TNR_ID, MENGE)
VALUES (1, 2, 4, 1);

INSERT INTO AG_KOMP_ZUORDNUNG (APNR_ID, AGNR_ID, TNR_ID, MENGE)
VALUES (1, 3, 3, 1);

INSERT INTO AG_KOMP_ZUORDNUNG (APNR_ID, AGNR_ID, TNR_ID, MENGE)
VALUES (1, 3, 2, 50);

commit;