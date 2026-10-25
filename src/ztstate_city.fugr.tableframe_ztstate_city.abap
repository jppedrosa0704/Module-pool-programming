*---------------------------------------------------------------------*
*    program for:   TABLEFRAME_ZTSTATE_CITY
*---------------------------------------------------------------------*
FUNCTION TABLEFRAME_ZTSTATE_CITY       .

  PERFORM TABLEFRAME TABLES X_HEADER X_NAMTAB DBA_SELLIST DPL_SELLIST
                            EXCL_CUA_FUNCT
                     USING  CORR_NUMBER VIEW_ACTION VIEW_NAME.

ENDFUNCTION.
