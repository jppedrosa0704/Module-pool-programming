*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZTSTATE_CITY....................................*
DATA:  BEGIN OF STATUS_ZTSTATE_CITY                  .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZTSTATE_CITY                  .
CONTROLS: TCTRL_ZTSTATE_CITY
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZTSTATE_CITY                  .
TABLES: ZTSTATE_CITY                   .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
