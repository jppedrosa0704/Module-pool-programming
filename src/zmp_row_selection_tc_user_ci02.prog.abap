MODULE USER_COMMAND_0100 INPUT.

  "===========================
  " SUBMIT
  "===========================
  IF sy-ucomm = 'SUBMIT'.

    "Valida se a ordem já está carregada na lt_final
    READ TABLE lt_final WITH KEY ono = lv_ono TRANSPORTING NO FIELDS.
    IF sy-subrc = 0.
      MESSAGE 'Ordem já carregada.' TYPE 'I'.
      RETURN.
    ENDIF.

    "Carrega cabeçalho
    SELECT ono, odate, pm, ta, curr
      FROM zordh_28
      INTO TABLE @lt_data
      WHERE ono = @lv_ono.

    "Carrega itens
    IF lt_data IS NOT INITIAL.
      SELECT ono, oin, icost
        FROM zordi_29
        INTO TABLE @lt_data1
        FOR ALL ENTRIES IN @lt_data
        WHERE ono = @lt_data-ono.
    ENDIF.

    "Limpa tabela final antes de montar
    CLEAR lt_final.

    LOOP AT lt_data INTO lwa_data.
      LOOP AT lt_data1 INTO lwa_data1 WHERE ono = lwa_data-ono.
        lwa_final-ono   = lwa_data-ono.
        lwa_final-odate = lwa_data-odate.
        lwa_final-pm   = lwa_data-pm.
        lwa_final-ta    = lwa_data-ta.
        lwa_final-curr  = lwa_data-curr.
        lwa_final-oin   = lwa_data1-oin.
        lwa_final-icost = lwa_data1-icost.
        APPEND lwa_final TO lt_final.
        CLEAR lwa_final.
      ENDLOOP.
    ENDLOOP.

    "Remove itens já pagos
    IF lt_final IS NOT INITIAL.
      SELECT ono, oin
        FROM ztpayment
        INTO TABLE @lt_payt
        FOR ALL ENTRIES IN @lt_final
        WHERE ono = @lt_final-ono
          AND oin = @lt_final-oin.
    ENDIF.

    LOOP AT lt_final INTO lwa_final.
      READ TABLE lt_payt INTO lwa_payt WITH KEY ono = lwa_final-ono oin = lwa_final-oin.
      IF sy-subrc = 0.
        DELETE lt_final WHERE ono = lwa_final-ono AND oin = lwa_final-oin.
      ENDIF.
    ENDLOOP.

  ENDIF.


  "===========================
  " PAYMENT
  "===========================
  IF sy-ucomm = 'PAYMENT'.

    "Coleta itens selecionados
    LOOP AT lt_final INTO lwa_final.
      IF lwa_final-sel = 'X'.
        lwa_payment-ono   = lwa_final-ono.
        lwa_payment-oin   = lwa_final-oin.
        lwa_payment-icost = lwa_final-icost.
        APPEND lwa_payment TO lt_payment.
        CLEAR lwa_payment.
      ENDIF.
    ENDLOOP.

    "Declara variável para SELECT SINGLE
    DATA ls_exists TYPE ztpayment.

    "Valida duplicação antes do INSERT
    LOOP AT lt_payment INTO lwa_payment.

      SELECT SINGLE ono, oin
        FROM ztpayment
        WHERE ono = @lwa_payment-ono
          AND oin = @lwa_payment-oin
        INTO @ls_exists.

      IF sy-subrc = 0.
        MESSAGE |Pagamento já registrado para OIN { lwa_payment-oin }.| TYPE 'I'.
        DELETE lt_payment WHERE ono = lwa_payment-ono AND oin = lwa_payment-oin.
      ENDIF.

    ENDLOOP.

    "Insere somente o que sobrou
    IF lt_payment IS NOT INITIAL.
      INSERT ztpayment FROM TABLE lt_payment.
      DELETE lt_final WHERE sel = 'X'.
    ENDIF.

  ENDIF.

ENDMODULE.
