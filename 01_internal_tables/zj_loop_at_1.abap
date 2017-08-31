*&---------------------------------------------------------------------*
*& Report  ZJ_LOOP_AT_1
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zj_loop_at_1.

DATA: BEGIN OF wa_2,
       carrid   TYPE scarr-carrid,
       currcode TYPE scarr-currcode,
     END OF wa_2.

DATA itab2 LIKE STANDARD TABLE OF wa_2.

DATA wa TYPE scarr.
DATA wa_3 LIKE wa_2.
DATA itab3 LIKE STANDARD TABLE OF wa_3.
DATA itab TYPE SORTED TABLE OF scarr
          WITH UNIQUE KEY carrid.


SELECT carrid currcode FROM scarr INTO CORRESPONDING FIELDS OF TABLE itab2.
SELECT * FROM scarr INTO TABLE itab.

DATA: foobar TYPE string.
SORT itab2 BY currcode.
LOOP AT itab2 INTO wa_2.
  AT FIRST.
    CONCATENATE wa_2-currcode ' gg' INTO foobar.
    WRITE: / 'first line', foobar.
    ULINE.
  ENDAT.
  AT NEW currcode.
    IF wa_2-currcode = 'USD'.
      APPEND wa_2 TO itab3.
    ENDIF.
    WRITE: / 'at new', wa_2-currcode.
  ENDAT.
ENDLOOP.
ULINE.
LOOP AT itab3 INTO wa_3.
  WRITE: / wa_3.
ENDLOOP.
