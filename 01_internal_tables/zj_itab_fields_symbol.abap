REPORT zj_itab_field_symbols .

DATA wa TYPE spfli.
DATA itab LIKE STANDARD TABLE OF wa.
FIELD-SYMBOLS: <fs_wa> LIKE spfli.

SELECT * FROM spfli INTO TABLE itab.

LOOP AT itab ASSIGNING <fs_wa>.
  WRITE: / <fs_wa>-carrid, <fs_wa>-connid.
ENDLOOP.
