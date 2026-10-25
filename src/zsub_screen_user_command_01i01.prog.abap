*----------------------------------------------------------------------*
***INCLUDE ZSUB_SCREEN_USER_COMMAND_01I01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE USER_COMMAND_0100 INPUT.
  SELECT ONO ODATE PM TA CURR
    FROM ZORDH_28
    INTO TABLE LT_DATA
    WHERE ONO = ZORDH_28-ONO.

    READ TABLE LT_DATA INTO LWA_DATA INDEX 1.
      IF LT_DATA IS NOT INITIAL.
       ZORDH_28-ODATE = LWA_DATA-ODATE.
       ZORDH_28-PM = LWA_DATA-PM.
       ZORDH_28-TA = LWA_DATA-TA.
       ZORDH_28-CURR = LWA_DATA-CURR.
      ENDIF.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  EXIT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE EXIT INPUT.
  CALL TRANSACTION 'ZPRG5'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  VALIDATE  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE VALIDATE INPUT.
   SELECT ONO ODATE PM TA CURR
    FROM ZORDH_28
    INTO TABLE LT_DATA
    WHERE ONO = ZORDH_28-ONO.

    IF SY-SUBRC <> 0.
      MESSAGE E000(ZMSG_78) DISPLAY LIKE 'I'.
    ENDIF.
ENDMODULE.
