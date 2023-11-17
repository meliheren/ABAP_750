*&---------------------------------------------------------------------*
*& Report ZME_NEW_SYNTAX750
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zme_new_syntax750.

*INCLUDE : zme_new_syntax750_def.
*INCLUDE : zme_new_syntax750_cls.
*
*INITIALIZATION.
*  DATA(lo_main) = NEW lcl_main( ).

CONSTANTS lc_meins type meins VALUE 'ADT'.

TYPES: BEGIN OF ty_first,
         werks  TYPE werks_d,
         arbpl  TYPE arbpl,
         total  TYPE menge_d,
         meins  TYPE meins,
         result TYPE int8,
       END OF ty_first.
TYPES : tt_first TYPE TABLE OF ty_first WITH EMPTY KEY.

DATA(lt_first) = VALUE tt_first(      ( werks = '2013' arbpl = '07' total = '16'   meins = '' )
                                      ( werks = '2013' arbpl = '07' total = '32'   meins = '' )
                                      ( werks = '2015' arbpl = '09' total = '07'   meins = '' ) ).

DATA: lt_group_one TYPE tt_first.

lt_group_one = VALUE #( FOR GROUPS ls_group_list OF <ls_first> IN lt_first GROUP BY ( werks = <ls_first>-werks
                                                                                      arbpl = <ls_first>-arbpl )
              ( VALUE #( arbpl  = ls_group_list-arbpl
                         werks  = ls_group_list-werks
                         total = REDUCE netwr( INIT sum TYPE menge_d
                                                FOR ls_first IN GROUP ls_group_list
                                                NEXT sum += ls_first-total ) ) ) ).


DATA(lt_final_list) = VALUE tt_first( FOR ls_first IN lt_group_one LET lv_meins = lc_meins
                                                                       lv_multip_one = 5
                                                                       lv_multip_two = 3 IN ( meins = lv_meins
                                                                                          werks = ls_first-werks
                                                                                          arbpl = ls_first-arbpl
                                                                                          total = ls_first-total
                                                                                          result = lv_multip_one * lv_multip_two ) ).

                                                                                          cl_demo_output=>display( lt_final_list ).

BREAK meren.
