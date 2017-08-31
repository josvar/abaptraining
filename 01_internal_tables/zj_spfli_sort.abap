*&---------------------------------------------------------------------*
*& Report  ZJ_SPFLI_SORT
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zj_spfli_sort.

DATA: itab_line TYPE spfli.
DATA: itab_lines TYPE i.
DATA itab TYPE HASHED TABLE OF spfli
          WITH UNIQUE KEY carrid connid.



DESCRIBE TABLE itab LINES itab_lines.
WRITE: / itab_lines.

SELECT * FROM spfli INTO TABLE itab.

SORT itab DESCENDING AS TEXT BY airpfrom airpto.

LOOP AT itab INTO itab_line.
  WRITE: / itab_line-airpfrom, itab_line-airpto.
ENDLOOP.
