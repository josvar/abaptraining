REPORT ycl_ch06_itab04.
***************************************
* Internal Tables: APPEND, TEXT SORT **
***************************************

TYPES: name_type(25) TYPE c.
DATA: names TYPE STANDARD TABLE OF name_type
        WITH HEADER LINE
        INITIAL SIZE 0.

names = 'BÖLLINGER'.
APPEND names TO names.

names = 'BOLLINGER'.
APPEND names TO names.

names = 'BILLINGER'.
APPEND names TO names.

names = 'BÏLLINGER'.
APPEND names TO names.

names = 'BULLINGER'.
APPEND names TO names.

FORMAT INVERSE ON COLOR COL_TOTAL.
WRITE: /5 'Original Data:'.

LOOP AT names.
    WRITE :/5 names.
ENDLOOP.

sort names.
skip.
FORMAT INVERSE ON COLOR col_key.
write: /5 'Ordinary Sort:'.
loop at names.
    write :/5 names.
endloop.

sort names as text.
skip.
FORMAT INVERSE ON COLOR col_positive.
write: /5 'Text Sort:'.
loop at names.
    write :/5 names.
endloop.
