*----------------------------------------------------------------------*
***INCLUDE ZINTEGRATION_PROGRAM_USER_CI01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE USER_COMMAND_0100 INPUT.
  IF R1 = 'X'.
    LEAVE TO TRANSACTION  'ZPRG_001'.
  ELSEIF R2 = 'X'.
    LEAVE TO TRANSACTION 'ZPRG2'.
  ELSEIF R3 = 'X'.
    LEAVE TO TRANSACTION 'ZPRG3'.
  ELSEIF R4 = 'X'.
    LEAVE TO TRANSACTION 'ZPRG4'.
  ENDIF.
ENDMODULE.
