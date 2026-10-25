*----------------------------------------------------------------------*
***INCLUDE ZDIALOG_BOX_USER_COMMAND_01I01.
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

    READ TABLE lt_data INTO lwa_data INDEX 1.
    IF sy-subrc = 0.
      ZORDH_28-ODATE  = lwa_data-ODATE.
      ZORDH_28-PM = lwa_data-PM.
      ZORDH_28-TA = LWA_DATA-TA.
      ZORDH_28-CURR = LWA_DATA-CURR.
    ENDIF.

    CALL SCREEN '0200' STARTING AT 10 20
    ENDING AT 50 60.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE USER_COMMAND_0200 INPUT.
  LEAVE TO SCREEN 0.
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
