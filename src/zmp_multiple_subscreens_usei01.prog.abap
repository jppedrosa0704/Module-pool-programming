*----------------------------------------------------------------------*
***INCLUDE ZMP_MULTIPLE_SUBSCREENS_USEI01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE USER_COMMAND_0100 INPUT.
  IF SY-UCOMM = 'HEADER'.
    lv_screen = '0101'.
  ELSE.
    lv_screen = '0102'.
  ENDIF.
   SELECT ONO ODATE PM TA CURR
    FROM ZORDH_28
    INTO TABLE lt_data
    WHERE ono = lv_ono.

    IF  lt_data is NOT INITIAL.
      READ TABLE lt_data INTO lwa_data INDEX 1.
      IF  sy-subrc = 0.
        lv_odate = lwa_data-odate.
        lv_pm = lwa_data-PM.
        lv_ta = lwa_data-TA.
        lv_curr = lwa_data-curr.
      ENDIF.
        SELECT ONO OIN ODESC ICOST
          FROM ZORDI_29
          INTO TABLE lt_data1
          FOR ALL ENTRIES IN lt_data
          WHERE ono = lt_data-ono.
    ENDIF.


ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  ATIVATE  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE ATIVATE INPUT.
  SELECT ONO ODATE PM TA CURR
    FROM ZORDH_28
    INTO TABLE lt_data
    WHERE ono = lv_ono.

    IF SY-SUBRC <> 0.
      MESSAGE E000(ZMSG_78) DISPLAY LIKE 'I'.
    ENDIF.
ENDMODULE.
