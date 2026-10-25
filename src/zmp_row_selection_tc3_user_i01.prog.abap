*----------------------------------------------------------------------*
***INCLUDE ZMP_ROW_SELECTION_TC3_USER_I01.
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
      WHERE ono = ZORDH_28-ono.

      IF lt_data IS NOT INITIAL.
        SELECT ONO OIN ICOST
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

      IF lt_final IS NOT INITIAL.
        SELECT ONO OIN
          FROM ZTPAYMENT
          INTO TABLE lt_payt
          FOR ALL ENTRIES IN lt_final
          WHERE ono = lt_final-ono AND oin = lt_final-oin.
      ENDIF.

      LOOP AT lt_final into lwa_final.
        lv_index = sy-tabix.
        READ TABLE lt_payt INTO lwa_payt WITH KEY ono = lwa_final-ono oin = lwa_final-oin.
        IF sy-subrc = 0.
*           DELETE lt_final WHERE ono = lwa_final-ono AND oin = lwa_final-oin.
          DELETE lt_final INDEX lv_index.
        ENDIF.
      ENDLOOP.
  ENDIF.




  IF sy-ucomm = 'PAYMENT'.
    LOOP AT lt_final INTO lwa_final.
      IF lwa_final-sel = 'X'.
        lwa_payment-ono = lwa_final-ono.
        lwa_payment-oin = lwa_final-oin.
        lwa_payment-icost = lwa_final-icost.
        APPEND lwa_payment TO lt_payment.
        CLEAR lwa_final.
      ENDIF.
    ENDLOOP.

    IF lt_payment IS NOT INITIAL.
      INSERT ZTPAYMENT FROM TABLE lt_payment.
      DELETE lt_final WHERE SEL = 'X'.
    ENDIF.
  ENDIF.
ENDMODULE.
