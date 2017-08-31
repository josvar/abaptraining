*&---------------------------------------------------------------------*
*& Report  ZJ_SPFLI_SORT_2
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zj_spfli_sort_2.

DATA: begin of wa_itab,
        carrid type spfli-carrid,
        connid type spfli-connid,
        airpfrom type spfli-airpfrom,
        airpto type spfli-airpto,
      end of wa_itab.

DATA itab LIKE HASHED TABLE OF wa_itab
          WITH UNIQUE KEY carrid connid.

SELECT carrid connid airpfrom airpto FROM spfli INTO TABLE itab.

sort itab as text by carrid airpfrom airpto.

LOOP AT itab INTO wa_itab.
  WRITE: / wa_itab-carrid, wa_itab-connid, wa_itab-airpfrom, wa_itab-airpto.
ENDLOOP.
