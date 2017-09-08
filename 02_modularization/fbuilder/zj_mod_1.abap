*&---------------------------------------------------------------------*
*& Report  ZJ_MOD_1
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT zj_mod_1.

DATA result type SPELL.

SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(15) text-001.
PARAMETER mynum TYPE i.
SELECTION-SCREEN END OF LINE.

CALL FUNCTION 'SPELL_AMOUNT'
    EXPORTING
        AMOUNT = mynum
        CURRENCY = 'USD'
    IMPORTING
        IN_WORDS = result
.

IF sy-subrc <> 0.
  MESSAGE 'error' TYPE 'i'.
ELSE.
  write: / result-word.
ENDIF.
