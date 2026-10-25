*----------------------------------------------------------------------*
***INCLUDE ZMP_ROW_SELECTION_TC_USER_CI01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE USER_COMMAND_0100 INPUT.
  IF sy-ucomm = 'SUBMIT'.
    SELECT ONO ODATE PM TA CURR
      FROM ZORDH_28
      INTO TABLE lt_data
      WHERE ono = lv_ono.

    IF  lt_data is not INITIAL.
      SELECT ono oin icost
      FROM ZORDI_29
      INTO TABLE lt_data1
      FOR ALL ENTRIES IN lt_data
      WHERE ono = lt_data-ono.
    ENDIF.

    LOOP AT lt_data INTO lwa_data.
      LOOP AT lt_data1 INTO lwa_data1 WHERE ono = lwa_data-ono.
        lwa_final-ono = lwa_data-ono.
        lwa_final-odate = lwa_data-odate.
        lwa_final-pm = lwa_data-pm.
        lwa_final-ta = lwa_data-ta.
        lwa_final-curr = lwa_data-curr.
        lwa_final-oin = lwa_data1-oin.
        lwa_final-icost = lwa_data1-icost.
        APPEND lwa_final TO lt_final.
        CLEAR lwa_final.
      ENDLOOP.
    ENDLOOP.

  ENDIF.

  IF  sy-ucomm = 'PAYMENT'.
    LOOP AT lt_final INTO lwa_final.
      IF lwa_final-sel = 'X'.
        lwa_payment-ono = lwa_final-ono.
        lwa_payment-oin = lwa_final-oin.
        lwa_payment-icost = lwa_final-icost.
       APPEND lwa_payment to lt_payment.
       CLEAR: lwa_payment.
      ENDIF.
    ENDLOOP.

    IF lt_payment IS NOT INITIAL.
      INSERT ZTPAYMENT FROM TABLE lt_payment.
    ENDIF.
  ENDIF.
ENDMODULE.
