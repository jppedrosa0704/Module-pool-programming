PROGRAM ZDROP_LIST_DOWN.

TABLES: ZTSTATE_CITY.

TYPES: BEGIN OF lty_data,
        CITY  TYPE ZDECITY,
       END OF lty_data.

DATA: lt_data TYPE TABLE OF lty_data,
      lwa_data TYPE lty_data.

INCLUDE zdrop_list_down_user_commani01.
