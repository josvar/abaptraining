REPORT ycl_ch12_01_simple_alv LINE-SIZE 120 LINE-COUNT 60
       NO STANDARD PAGE HEADING.

********************************************************
* Customer Wise Sales Summary of a company code using **
* COLLECT statement                                   **
********************************************************

DATA: sales_tab  TYPE ycl_ch06_sales_sum_tab, "key word TYPE only
      sales_stru LIKE LINE OF sales_tab, " declare structure by
                                         " referring to internal
                                         " table

      total    TYPE vbrk-netwr,
      butxt    TYPE t001-butxt,
      waers    TYPE t001-waers,
      butxts   TYPE string.

DATA: ok_code  TYPE sy-ucomm,
      ccontr   TYPE REF TO cl_gui_custom_container,
      alv_grid TYPE REF TO cl_gui_alv_grid.

**********************************************
PARAMETERS: ccode TYPE vbrk-bukrs DEFAULT 3000.

**********************************************
START-OF-SELECTION.

SELECT SINGLE butxt waers FROM t001 INTO (butxt, waers) WHERE
       bukrs = ccode.

butxts = butxt. "assignment to TYPE STRING drops trailing blanks

SELECT kunnr name1 ort01 netwr kurrf FROM ycl_ch05_vbrkkna INTO
  CORRESPONDING FIELDS OF sales_stru WHERE bukrs = ccode.

 sales_stru-netwr =  sales_stru-netwr * sales_stru-kurrf.
 sales_stru-kurrf = 0. "to prevent overflow
 COLLECT sales_stru INTO sales_tab.
ENDSELECT.

SORT sales_tab BY kunnr.

CALL SCREEN 0100.     " screen 100 will be loaded


*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
SET PF-STATUS 'STAT1'.
SET TITLEBAR 'TITLE1' WITH ccode butxt waers.

CREATE OBJECT ccontr
  EXPORTING
*    parent                      =
    container_name              = 'CUST_CONTT'
*    style                       =
*    lifetime                    = lifetime_default
*    repid                       =
*    dynnr                       =
*    no_autodef_progid_dynnr     =
  EXCEPTIONS
    cntl_error                  = 1
    cntl_system_error           = 2
    create_error                = 3
    lifetime_error              = 4
    lifetime_dynpro_dynpro_link = 5
    OTHERS                      = 6
    .
IF sy-subrc <> 0.
 MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
ENDIF.

CREATE OBJECT alv_grid
  EXPORTING
*    i_shellstyle      = 0
*    i_lifetime        =
    i_parent          = ccontr
*    i_appl_events     = space
*    i_parentdbg       =
*    i_applogparent    =
*    i_graphicsparent  =
*    i_name            =
*    i_fcat_complete   = SPACE
 EXCEPTIONS
    error_cntl_create = 1
    error_cntl_init   = 2
    error_cntl_link   = 3
    error_dp_create   = 4
    OTHERS            = 5
    .
IF sy-subrc <> 0.
 MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
ENDIF.

CALL METHOD alv_grid->set_table_for_first_display
  EXPORTING
*    i_buffer_active               =
*    i_bypassing_buffer            =
*    i_consistency_check           =
    i_structure_name              = 'YCL_CH12_SALES_SUM_STRU'
*    is_variant                    =
*    i_save                        =
*    i_default                     = 'X'
*    is_layout                     =
*    is_print                      =
*    it_special_groups             =
*    it_toolbar_excluding          =
*    it_hyperlink                  =
*    it_alv_graphics               =
*    it_except_qinfo               =
*    ir_salv_adapter               =
  CHANGING
    it_outtab                     = sales_tab
*    it_fieldcatalog               =
*    it_sort                       =
*    it_filter                     =
 EXCEPTIONS
   invalid_parameter_combination = 1
   program_error                 = 2
   too_many_lines                = 3
   others                        = 4
        .
IF sy-subrc <> 0.
MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
           WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
ENDIF.

ENDMODULE.                 " STATUS_0100  OUTPUT


*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

IF ok_code = 'BACK'.
  SET SCREEN 0.
  LEAVE SCREEN.
ENDIF.

ENDMODULE.                 " USER_COMMAND_0100  INPUT
