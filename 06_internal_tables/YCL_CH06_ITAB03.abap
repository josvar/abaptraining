REPORT ycl_ch06_itab03.
****************************************************************
* Internal Tables - Split a String & Get Words Into itab Rows **
****************************************************************
DATA word(15) TYPE c.

* unstructured internal table
DATA words_tab LIKE STANDARD TABLE OF word.

PARAMETERS: istring(50) TYPE c DEFAULT
            'ONCE UPON A TIME THERE LIVED A GENIUS'.
****************************************************************
START-OF-SELECTION.

SPLIT istring AT ' ' INTO TABLE words_tab.

LOOP AT words_tab INTO word.
  WRITE: /5 word.
ENDLOOP.