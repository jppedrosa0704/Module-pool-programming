*----------------------------------------------------------------------*
***INCLUDE ZMP_MULTIPLE_SUBSCREENS_F4HI01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  F4HELP  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE F4HELP INPUT.
  TYPES: BEGIN OF lty_ono,
           ono TYPE ZDEONO_28,
         END OF lty_ono.

  DATA: lt_ono TYPE TABLE OF lty_ono,
        lwa_ono TYPE lty_ono.

  SELECT ono
    FROM ZORDH_28
    INTO TABLE lt_ono.

  CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
    EXPORTING
*     DDIC_STRUCTURE         = ' '
      RETFIELD               = 'ONO'
*     PVALKEY                = ' '
     DYNPPROG               = sy-repid
     DYNPNR                 = sy-dynnr
     DYNPROFIELD            = 'LV_ONO'
*     STEPL                  = 0
*     WINDOW_TITLE           =
*     VALUE                  = ' '
     VALUE_ORG              = 'S'
*     MULTIPLE_CHOICE        = ' '
*     DISPLAY                = ' '
*     CALLBACK_PROGRAM       = ' '
*     CALLBACK_FORM          = ' '
*     CALLBACK_METHOD        =
*     MARK_TAB               =
*   IMPORTING
*     USER_RESET             =
    TABLES
      VALUE_TAB              = lt_ono
*     FIELD_TAB              =
*     RETURN_TAB             =
*     DYNPFLD_MAPPING        =
   EXCEPTIONS
     PARAMETER_ERROR        = 1
     NO_VALUES_FOUND        = 2
     OTHERS                 = 3
            .
  IF SY-SUBRC <> 0.
* Implement suitable error handling here
  ENDIF.


ENDMODULE.
