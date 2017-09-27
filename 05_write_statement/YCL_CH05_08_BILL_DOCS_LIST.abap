REPORT ycl_ch05_08_bill_docs_list LINE-SIZE 135 LINE-COUNT 60
       NO STANDARD PAGE HEADING.

*******************************************************************
TABLES: ycl_ch05_vbrkkna,
        t001.

DATA: strng TYPE string,
      space_char TYPE c VALUE ' ',
      subtotal TYPE vbrk-netwr,
      total TYPE vbrk-netwr.

PARAMETERS ccode TYPE vbrk-bukrs DEFAULT 3000 VALUE CHECK.
*******************************************************************
TOP-OF-PAGE.

  WRITE: /5 strng, 129(3) sy-pagno.
  SKIP 1.
  WRITE: /5(127) sy-uline.
  WRITE: /5 text-003, 11 text-004, 22 text-005, 33 text-006, 46 text-007,
            83 text-008, 126 text-009.

  WRITE: /6 text-010, 35 text-011.
  WRITE: /5(127) sy-uline.
***********************************************************************
START-OF-SELECTION.

  SELECT SINGLE * FROM t001 WHERE bukrs = ccode.

  CONCATENATE space_char ccode '/' t001-butxt text-002 t001-waers INTO strng.
  CONCATENATE text-001 strng INTO strng SEPARATED BY space_char.

  SELECT * FROM ycl_ch05_vbrkkna WHERE bukrs = ccode.
    subtotal = 0.
    subtotal = ycl_ch05_vbrkkna-netwr * ycl_ch05_vbrkkna-kurrf.
    WRITE: /5(5) sy-dbcnt, ycl_ch05_vbrkkna-vbeln, ycl_ch05_vbrkkna-fkdat,
                 ycl_ch05_vbrkkna-kunnr, ycl_ch05_vbrkkna-name1,
                 ycl_ch05_vbrkkna-ort01, (17) ycl_ch05_vbrkkna-netwr.
    total = total + subtotal.
  ENDSELECT.

END-OF-SELECTION.
  SKIP 1.

  WRITE: /(17) total UNDER ycl_ch05_vbrkkna-netwr.