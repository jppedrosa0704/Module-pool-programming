*----------------------------------------------------------------------*
***INCLUDE ZTABLE_CONTROL_USER_COMMANDI01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE USER_COMMAND_0100 INPUT.
  IF SY-UCOMM = 'DISPLAY'.
    SELECT ONO ODATE PM TA CURR
    FROM ZORDH_28
    INTO TABLE LT_DATA
    WHERE ONO = ZORDH_28-ONO.
   IF LT_DATA IS NOT INITIAL.
     SELECT ONO OIN ODESC ICOST
       FROM ZORDI_29
       INTO TABLE LT_DATA1
       FOR ALL ENTRIES IN LT_DATA
       WHERE ONO = LT_DATA-ONO.
*   ELSE.
*     MESSAGE E000(ZMSG_78) DISPLAY LIKE 'I'.

   ENDIF.
    IF  SY-SUBRC = 0.
      READ TABLE LT_DATA INTO LWA_DATA INDEX 1.
*        ZORDH_28-ONO = LWA_DATA-ONO.
        ZORDH_28-ODATE = LWA_DATA-ODATE.
        ZORDH_28-PM = LWA_DATA-PM.
        ZORDH_28-TA = LWA_DATA-TA.
        ZORDH_28-CURR = LWA_DATA-CURR.
    ENDIF.
  ENDIF.
    IF SY-UCOMM = 'HEADER'.
      CALL SCREEN '0200'.
    ENDIF.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE USER_COMMAND_0200 INPUT.
CALL SCREEN '0100'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  EXIT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE EXIT INPUT.
  LEAVE TO TRANSACTION 'ZPRG5'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  VALIDADE  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE VALIDADE INPUT.
  SELECT ONO ODATE PM TA CURR
    FROM ZORDH_28
    INTO TABLE LT_DATA
    WHERE ONO = ZORDH_28-ONO.
  IF sy-subrc <> 0.
    MESSAGE E000(ZMSG_78) DISPLAY LIKE 'I'.
  ENDIF.

ENDMODULE.
