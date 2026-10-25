*----------------------------------------------------------------------*
***INCLUDE ZMP_MULTIPLE_SUBSCREENS_F1HI01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  F1HELP  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE F1HELP INPUT.

*  DATA: lt_links TYPE TABLE OF TLINE.

  CALL FUNCTION 'HELP_OBJECT_SHOW'
    EXPORTING
      DOKCLASS                            = 'TX'
*     DOKLANGU                            = SY-LANGU
      DOKNAME                             = 'ZONO'
*     DOKTITLE                            = ' '
*     CALLED_BY_PROGRAM                   = ' '
*     CALLED_BY_DYNP                      = ' '
*     CALLED_FOR_TAB                      = ' '
*     CALLED_FOR_FIELD                    = ' '
*     CALLED_FOR_TAB_FLD_BTCH_INPUT       = ' '
*     MSG_VAR_1                           = ' '
*     MSG_VAR_2                           = ' '
*     MSG_VAR_3                           = ' '
*     MSG_VAR_4                           = ' '
*     CALLED_BY_CUAPROG                   = ' '
*     CALLED_BY_CUASTAT                   =
*     SHORT_TEXT                          = ' '
*     CLASSIC_SAPSCRIPT                   = ' '
*   TABLES
*      LINKS                               = lt_links
   EXCEPTIONS
     OBJECT_NOT_FOUND                    = 1
     SAPSCRIPT_ERROR                     = 2
     OTHERS                              = 3
            .
  IF SY-SUBRC <> 0.
* Implement suitable error handling here
  ENDIF.

ENDMODULE.
