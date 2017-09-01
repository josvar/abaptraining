*&---------------------------------------------------------------------*
*& Report  ZJ_MOD_1
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zj_mod_1.

INCLUDE zj_employee_definitions.

DATA: wa TYPE line01_typ.
DATA: itab TYPE STANDARD TABLE OF line01_typ.
FIELD-SYMBOLS: <fs_wa> TYPE line01_typ.

DATA: z_field1 TYPE zjemployees-surname,
      z_field2 TYPE zjemployees-forename.

************************************************************************

z_field1 = 'ANDREWS'.
z_field2 = 'SUSAN'.

PERFORM itab_fill.
PERFORM itab_fill_again USING z_field1 z_field2.
PERFORM itab_write USING itab.
PERFORM itab_write2 TABLES itab.

ULINE.

WRITE: / z_field1, z_field2.

ULINE.


LOOP AT itab INTO wa.
  WRITE: / wa.
ENDLOOP.

LOOP AT itab ASSIGNING <fs_wa>.
  WRITE: / <fs_wa>.
ENDLOOP.


*&---------------------------------------------------------------------*
*&      Form  itab_fill
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM itab_fill .
  SELECT surname dob FROM zjemployees INTO TABLE itab.
ENDFORM.                    " itab_fill


*&---------------------------------------------------------------------*
*&      Form  itab_fill_again
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_ZFIELD1  text
*      -->P_ZFIELD2  text
*----------------------------------------------------------------------*
FORM itab_fill_again  USING    p_zsurname
                               p_zforename.

  WRITE: / p_zsurname, p_zforename.

  p_zsurname = 'abcde'.

ENDFORM.                    " itab_fill_again

*&---------------------------------------------------------------------*
*&      Form  itab_write
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_ITAB  text
*----------------------------------------------------------------------*
FORM itab_write  USING   p_itab LIKE itab.

  FIELD-SYMBOLS: <wa_tmp> LIKE LINE OF itab.

  WRITE: / 'ITAB WRITE'.
  LOOP AT p_itab ASSIGNING <wa_tmp>.
    WRITE: / <wa_tmp>-surname.
  ENDLOOP.
ENDFORM.                    "itab_write

*&---------------------------------------------------------------------*
*&      Form  itab_write2
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_ITAB  text
*----------------------------------------------------------------------*
FORM itab_write2  TABLES   p_itab.

  FIELD-SYMBOLS: <wa_tmp> LIKE LINE OF itab.

  WRITE: / 'ITAB WRITE 2'.
  LOOP AT p_itab ASSIGNING <wa_tmp>.
    WRITE: / <wa_tmp>-surname.
  ENDLOOP.

ENDFORM.                    "itab_write2
