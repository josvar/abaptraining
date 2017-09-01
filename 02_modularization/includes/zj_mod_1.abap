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
FIELD-SYMBOLS: <fs-wa> TYPE line01_typ.

SELECT surname dob FROM zjemployees INTO TABLE itab.

LOOP AT itab INTO wa.
  WRITE: / wa.
ENDLOOP.

LOOP AT itab ASSIGNING <fs-wa>.
  WRITE: / <fs-wa>.
ENDLOOP.
