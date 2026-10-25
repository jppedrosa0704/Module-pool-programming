*----------------------------------------------------------------------*
***INCLUDE ZSTRIP_TAB_USER_COMMAND_010I01.
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
        SELECT ONO OIN  ODESC ICOST
          FROM ZORDI_29
          INTO TABLE LT_DATA1
          FOR ALL ENTRIES IN LT_DATA
          WHERE ONO = LT_DATA-ONO.
        IF sy-subrc = 0.
          ZORDH_28-ODATE = lwa_data-ODATE.
          ZORDH_28-PM = lwa_data-PM.
          ZORDH_28-TA = lwa_data-TA.
          ZORDH_28-CURR = lwa_data-CURR.

        ENDIF.

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

   IF sy-subrc <> 0.
     MESSAGE E000(ZMSG_78) DISPLAY LIKE 'I'.
   ENDIF.
ENDMODULE.
