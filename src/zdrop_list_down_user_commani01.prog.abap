*----------------------------------------------------------------------*
***INCLUDE ZDROP_LIST_DOWN_USER_COMMANI01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE USER_COMMAND_0100 INPUT.
  SELECT CITY
    FROM ZTSTATE_CITY
    INTO TABLE LT_DATA
    WHERE STATE = ZTSTATE_CITY-STATE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE STATUS_0100 OUTPUT.
  DATA: lt_values TYPE VRM_VALUES.
  DATA: lwa_values TYPE VRM_VALUE.

*  SET PF-STATUS 'xxxxxxxx'.
*  SET TITLEBAR 'xxx'.

REFRESH: LT_VALUES.
IF ZTSTATE_CITY-STATE IS NOT INITIAL.
  REFRESH: LT_VALUES.
  LOOP AT lt_data INTO lwa_data.
    lwa_values-key = lwa_data-city.
    lwa_values-text = lwa_data-city.
    APPEND lwa_values to lt_values.
    CLEAR: lwa_values.
  ENDLOOP.
    CLEAR: ZTSTATE_CITY-CITY.
  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      ID                    = 'ZTSTATE_CITY-CITY'
      VALUES                = lt_values
   EXCEPTIONS
     ID_ILLEGAL_NAME       = 1
     OTHERS                = 2
            .
  IF SY-SUBRC <> 0.
* Implement suitable error handling here
  ENDIF.


ENDIF.
ENDMODULE.
