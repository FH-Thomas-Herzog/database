CREATE TABLE film (
  film_id   NUMBER(4) CONSTRAINT film_pk PRIMARY KEY,
  titel     VARCHAR2(20),
  jahr      NUMBER(4),
  regisseur VARCHAR2(15),
  kosten    NUMBER(12));

CREATE TABLE vorfuehrungen (
  film_id              NUMBER(4),
  film_v_id            NUMBER(4),
  staat                VARCHAR2(15),
  ort                  VARCHAR2(15),
  kino                 VARCHAR2(15),
  start_datum          DATE,
  anzahl_vorfuehrungen NUMBER(5),
  umsatz               NUMBER(12),
  CONSTRAINT vorf_pk      PRIMARY KEY(film_id, film_v_id),
  CONSTRAINT vorf_fk_film FOREIGN KEY(film_id) REFERENCES film);

CREATE TABLE schauspieler (
  schauspieler_id NUMBER(4) CONSTRAINT schauspieler_pk PRIMARY KEY,
  vorname         VARCHAR2(15),
  nachname        VARCHAR2(15),
  geburts_jahr    NUMBER(4),
  geschlecht      CHAR(1) CHECK(geschlecht IN ('M','W')),
  staat           VARCHAR2(15),
  ort             VARCHAR2(15),
  markt_wert      NUMBER(9),
  einnahmen       NUMBER(12),
  erster_film     NUMBER(7) CONSTRAINT schauspieler_fk_film REFERENCES film,
  auszeichnung    VARCHAR2(15));

CREATE TABLE rolle (
  film_id         NUMBER(4) CONSTRAINT rolle_fk_film REFERENCES film,
  schauspieler_id NUMBER(4) CONSTRAINT rolle_fk_schauspieler REFERENCES schauspieler,
  rolle           VARCHAR2(15),
  hauptrolle      CHAR(1) CHECK(hauptrolle IN ('J','N')),
  gage            NUMBER(9),
  CONSTRAINT rolle_pk PRIMARY KEY(film_id, schauspieler_id));

