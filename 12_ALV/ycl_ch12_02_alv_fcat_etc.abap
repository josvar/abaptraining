REPORT ycl_ch12_02_alv_fcat_etc LINE-SIZE 120 LINE-COUNT 60
       NO STANDARD PAGE HEADING.

********************************************************
* Customer Wise Sales Summary of a company code using **
* COLLECT statement                                   **
********************************************************

DATA: sales_tab  TYPE ycl_ch06_sales_sum_tab, "key word TYPE only
      sales_stru LIKE LINE OF sales_tab,
      butxt    TYPE t001-butxt,
      waers    TYPE t001-waers,
      butxts   TYPE string.


DATA: ok_code  TYPE sy-ucomm,
      ccontr   TYPE REF TO cl_gui_custom_container,
      alv_grid TYPE REF TO cl_gui_alv_grid.

DATA: fcat TYPE lvc_t_fcat,
      layout TYPE lvc_s_layo,
      dvariant TYPE disvariant.

**********************************************
PARAMETERS: ccode TYPE vbrk-bukrs DEFAULT 3000.

**********************************************
START-OF-SELECTION.
  SELECT SINGLE butxt waers FROM t001 INTO (butxt, waers)
    WHERE bukrs = ccode.

  butxts = butxt. "assignment to TYPE STRING drops trailing blanks

  SELECT kunnr name1 ort01 netwr kurrf FROM ycl_ch05_vbrkkna
    INTO CORRESPONDING FIELDS OF sales_stru WHERE bukrs = ccode.

    sales_stru-netwr =  sales_stru-netwr * sales_stru-kurrf.
    sales_stru-kurrf = 0. "to prevent overflow
    COLLECT sales_stru INTO sales_tab.
  ENDSELECT.

  SORT sales_tab BY kunnr.

  CALL SCREEN 0100.     " screen 100 will be loaded

*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.

  SET PF-STATUS 'STAT1'.
  SET TITLEBAR 'TITLE1' WITH ccode butxts waers.

  perform init_container changing ccontr.
  perform init_alv using ccontr changing alv_grid.
  perform generate_catalog changing fcat.
  perform setup_alv_options changing layout dvariant.

  perform display_alv using layout dvariant sales_tab fcat.
ENDMODULE.                 " STATUS_0100  OUTPUT


*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  IF ok_code = 'BACK'.
    SET SCREEN 0.
    LEAVE SCREEN.
  ENDIF.

ENDMODULE.                 " USER_COMMAND_0100  INPUT

form init_container changing ccontr type ref to cl_gui_custom_container.
  CREATE OBJECT alv_grid
    EXPORTING
      i_parent          = ccontr
    EXCEPTIONS
      error_cntl_create = 1
      error_cntl_init   = 2
      error_cntl_link   = 3
      error_dp_create   = 4
      OTHERS            = 5.
  IF sy-subrc <> 0.
    MESSAGE
     ID sy-msgid
     TYPE sy-msgty
     NUMBER sy-msgno
     WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.
endform.

form init_alv
      using ccontr type any
      changing alv_grid type ref to cl_gui_alv_grid.

  CREATE OBJECT alv_grid
    EXPORTING
      i_parent          = ccontr
    EXCEPTIONS
      error_cntl_create = 1
      error_cntl_init   = 2
      error_cntl_link   = 3
      error_dp_create   = 4
      OTHERS            = 5.
  IF sy-subrc <> 0.
    MESSAGE
     ID sy-msgid
     TYPE sy-msgty
     NUMBER sy-msgno
     WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.
endform.

form generate_catalog changing fcat type lvc_t_fcat.
  data: fcat_line like line of fcat.
  data: clr(1) TYPE n VALUE 1.

  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'YCL_CH12_SALES_SUM_STRU'
    CHANGING
      ct_fieldcat            = fcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.

  IF sy-subrc <> 0.
    MESSAGE
      ID sy-msgid
      TYPE sy-msgty
      NUMBER sy-msgno
      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

  LOOP AT fcat into fcat_line.
    "color codes 1 2 3 4 for fields KUNNR, NAME1, ORT01 & NETWR"
    clr = clr + 1.
    CONCATENATE 'C' clr '00' INTO fcat_line-emphasize.

    "column width optimization"
    fcat_line-col_opt = 'X'.

    "output leading zeroes in KUNNR"
    IF fcat_line-fieldname = 'KUNNR'.
      "suppress execution of conversion exit routine"
      "make conversion exit routine blank"
      fcat_line-no_convext = 'X'.
      fcat_line-convexit = ' '.

      "make edit mask blank"
      fcat_line-edit_mask = ' '.
    ENDIF.
    MODIFY fcat from fcat_line.
  ENDLOOP.
endform.

form setup_alv_options
    changing
      layout TYPE lvc_s_layo
      dvariant TYPE disvariant.

  CONCATENATE text-001 ccode '/' butxts '--' text-002 waers
    INTO layout-grid_title.
  dvariant-report = 'YCL_CH12_02_ALV_FCAT_ETC'.
endform.

form display_alv using layout dvariant sales_tab fcat.
  alv_grid->set_table_for_first_display(
    EXPORTING
      is_variant = dvariant
      i_save = 'U'
      is_layout = layout
    CHANGING
      it_outtab                     = sales_tab
      it_fieldcatalog = fcat
    EXCEPTIONS
      invalid_parameter_combination = 1
      program_error                 = 2
      too_many_lines                = 3
      OTHERS                        = 4 ).

  IF sy-subrc <> 0.
    MESSAGE
      ID sy-msgid
      TYPE sy-msgty
      NUMBER sy-msgno
      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.
endform.
