REPORT ycl_ch06_itab04_2.
***************************************
* Internal Tables: APPEND, TEXT SORT **
***************************************

TYPES: name_type(25) TYPE c.
DATA: name type name_type.
DATA: names TYPE STANDARD TABLE OF name_type
        INITIAL SIZE 0.

* Otra forma de declarar un WA
* DATA name LIKE LINE OF names.

name = 'BÖLLINGER'.
APPEND name TO names.

name = 'BOLLINGER'.
APPEND name TO names.

name = 'BILLINGER'.
APPEND name TO names.

name = 'BÏLLINGER'.
APPEND name TO names.

name = 'BULLINGER'.
APPEND name TO names.

FORMAT INVERSE ON COLOR COL_TOTAL.
WRITE: /5 'Original Data:'.

LOOP AT names into name.
    WRITE :/5 name.
ENDLOOP.
