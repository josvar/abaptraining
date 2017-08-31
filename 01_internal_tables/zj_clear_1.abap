*&---------------------------------------------------------------------*
*& Report  ZJ_CLEAR_1
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zj_clear_1.

DATA: cnt TYPE i.

DATA: BEGIN OF wa_itab,
        carrid TYPE spfli-carrid,
        connid TYPE spfli-connid,
        airpfrom TYPE spfli-airpfrom,
        airpto TYPE spfli-airpto,
      END OF wa_itab.

DATA itab LIKE HASHED TABLE OF wa_itab
          WITH UNIQUE KEY carrid connid.

SELECT carrid connid airpfrom airpto FROM spfli INTO TABLE itab.
DESCRIBE TABLE itab LINES cnt.
WRITE: / cnt.
LOOP AT itab INTO wa_itab WHERE carrid = 'AA'.
  WRITE: / wa_itab-carrid, wa_itab-connid, wa_itab-airpfrom, wa_itab-airpto.
ENDLOOP.

CLEAR itab.
DESCRIBE TABLE itab LINES cnt.
WRITE: / cnt.
LOOP AT itab INTO wa_itab.
  WRITE: / wa_itab-carrid, wa_itab-connid, wa_itab-airpfrom, wa_itab-airpto.
ENDLOOP.
