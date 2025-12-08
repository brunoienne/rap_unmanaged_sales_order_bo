CLASS lhc_zr_so_bm DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zr_so_bm RESULT result.

*    METHODS create FOR MODIFY
*      IMPORTING entities FOR CREATE zr_so_bm.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE zr_so_bm.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE zr_so_bm.

    METHODS read FOR READ
      IMPORTING keys FOR READ zr_so_bm RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK zr_so_bm.

    METHODS rba_Item FOR READ
      IMPORTING keys_rba FOR READ zr_so_bm\_Item FULL result_requested RESULT result LINK association_links.

    METHODS deep_create FOR MODIFY
      IMPORTING entities_header FOR CREATE zr_so_bm
                entities_item   FOR CREATE zr_so_bm\_item.


*    METHODS cba_Item FOR MODIFY
*      IMPORTING entities_cba FOR CREATE zr_so_bm\_Item.

ENDCLASS.

CLASS lhc_zr_so_bm IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

*  METHOD create.
*  ENDMETHOD.

  METHOD update.

    DATA: lt_so TYPE TABLE FOR UPDATE i_salesordertp.

    lt_so = VALUE #( FOR ls_entities IN entities ( CORRESPONDING #( ls_entities ) ) ).

    MODIFY ENTITIES OF i_salesordertp
    ENTITY SalesOrder
    UPDATE FIELDS ( SoldToParty ) WITH lt_so
    MAPPED DATA(lt_mapped)
    FAILED DATA(lt_failed)
    REPORTED DATA(lt_reported).

    IF lt_mapped IS NOT INITIAL.
      mapped-zr_so_bm = VALUE #( FOR ls_mapped IN lt_mapped-salesorder ( CORRESPONDING #( ls_mapped ) ) ).
    ENDIF.

    IF lt_failed IS NOT INITIAL.
      failed-zr_so_bm = VALUE #( FOR ls_failed IN lt_failed-salesorder ( CORRESPONDING #( ls_failed ) ) ).
    ENDIF.

    IF lt_reported IS NOT INITIAL.
      reported-zr_so_bm = VALUE #( FOR ls_reported IN lt_reported-salesorder ( CORRESPONDING #( ls_reported ) ) ).
    ENDIF.

  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

  METHOD rba_Item.
  ENDMETHOD.

*  METHOD cba_Item.
*  ENDMETHOD.

  METHOD deep_create.

    DATA: lt_header    TYPE TABLE FOR CREATE i_salesordertp,
          lt_items     TYPE TABLE FOR CREATE i_salesordertp\_Item,
          lv_next_so   TYPE i_salesordertp-SalesOrder,
          ls_mapped_so LIKE LINE OF mapped-zr_so_bm,
          ls_mapped_it LIKE LINE OF mapped-zr_so_item_bm.

    lt_header = VALUE #( FOR ls_header IN entities_header ( %key     = ls_header-%key "Internal keys
                                                            %cid     = ls_header-%cid "RAP keys
                                                            %control = ls_header-%control "Control of filled fields
                                                            %data    = CORRESPONDING #( ls_header-%data ) ) ). "Data

    lt_items = VALUE #( FOR ls_item IN entities_item ( %key     = ls_item-%key
                                                       %cid_ref = ls_item-%cid_ref
                                                       %target  = CORRESPONDING #( ls_item-%target ) ) ).


    MODIFY ENTITIES OF i_salesordertp
    ENTITY SalesOrder
    CREATE FIELDS ( SalesOrderType
                    SalesOrganization
                    DistributionChannel
                    OrganizationDivision
                    SoldToParty ) WITH lt_header
    CREATE BY \_Item
    FIELDS ( Product
             RequestedQuantity ) WITH lt_items
    MAPPED DATA(lt_mapped)
    FAILED DATA(lt_failed)
    REPORTED DATA(lt_reported).

    SELECT MAX( salesorder ) FROM zi_so_bm
    INTO @DATA(lv_last_so) WHERE SalesOrderType = 'TA'.

    IF lt_mapped IS NOT INITIAL.
      lv_next_so = lv_last_so + 1.

      LOOP AT lt_mapped-salesorder INTO DATA(ls_mapped).
        ls_mapped_so = CORRESPONDING #( ls_mapped ).
        ls_mapped_so-SalesOrder = lv_next_so.
        APPEND ls_mapped_so TO mapped-zr_so_bm.
      ENDLOOP.

      LOOP AT lt_mapped-salesorderitem INTO DATA(ls_mapped2).
        ls_mapped_it = CORRESPONDING #( ls_mapped2 ).
        ls_mapped_it-SalesOrder = lv_next_so.
        APPEND ls_mapped_it TO mapped-zr_so_item_bm.
      ENDLOOP.

    ENDIF.

    IF lt_failed IS NOT INITIAL.
      failed-zr_so_bm     = VALUE #( FOR ls_failed_so IN lt_failed-salesorder ( CORRESPONDING #( ls_failed_so ) ) ).
      failed-zr_so_item_bm = VALUE #( FOR ls_failed_it IN lt_failed-salesorderitem ( CORRESPONDING #( ls_failed_it ) ) ).
    ENDIF.

    IF lt_reported IS NOT INITIAL.
      reported-zr_so_bm     = VALUE #( FOR ls_reported_po IN lt_reported-salesorder ( CORRESPONDING #( ls_reported_po ) ) ).
      reported-zr_so_item_bm = VALUE #( FOR ls_reported_it IN lt_reported-salesorderitem ( CORRESPONDING #( ls_reported_it ) ) ).
    ENDIF.

  ENDMETHOD.

ENDCLASS.

CLASS lhc_zr_so_item_bm DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE zr_so_item_bm.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE zr_so_item_bm.

    METHODS read FOR READ
      IMPORTING keys FOR READ zr_so_item_bm RESULT result.

    METHODS rba_So FOR READ
      IMPORTING keys_rba FOR READ zr_so_item_bm\_So FULL result_requested RESULT result LINK association_links.

ENDCLASS.

CLASS lhc_zr_so_item_bm IMPLEMENTATION.

  METHOD update.

    DATA: lt_so_item TYPE TABLE FOR UPDATE i_salesordertp\\SalesOrderItem.

    lt_so_item = VALUE #( FOR ls_entities IN entities ( CORRESPONDING #( ls_entities ) ) ).

    MODIFY ENTITIES OF i_salesordertp
    ENTITY SalesOrderItem
    UPDATE FIELDS ( RequestedQuantity ) WITH lt_so_item
    MAPPED DATA(lt_mapped)
    FAILED DATA(lt_failed)
    REPORTED DATA(lt_reported).

    IF lt_mapped IS NOT INITIAL.
      mapped-zr_so_bm = VALUE #( FOR ls_mapped IN lt_mapped-salesorder ( CORRESPONDING #( ls_mapped ) ) ).
    ENDIF.

    IF lt_failed IS NOT INITIAL.
      failed-zr_so_bm = VALUE #( FOR ls_failed IN lt_failed-salesorder ( CORRESPONDING #( ls_failed ) ) ).
    ENDIF.

    IF lt_reported IS NOT INITIAL.
      reported-zr_so_bm = VALUE #( FOR ls_reported IN lt_reported-salesorder ( CORRESPONDING #( ls_reported ) ) ).
    ENDIF.

  ENDMETHOD.

  METHOD delete.

    DATA: lt_items TYPE TABLE FOR DELETE I_SalesOrderTP\\SalesOrderItem.

    lt_items = VALUE #( FOR ls_keys IN keys ( CORRESPONDING #( ls_keys ) ) ).

    MODIFY ENTITIES OF i_salesordertp
    ENTITY SalesOrderItem
    DELETE FROM lt_items
    MAPPED DATA(lt_mapped)
    FAILED DATA(lt_failed)
    REPORTED DATA(lt_reported).

    IF lt_mapped IS NOT INITIAL.
      mapped-zr_so_item_bm = VALUE #( FOR ls_mapped_it IN lt_mapped-salesorderitem ( CORRESPONDING #( ls_mapped_it ) ) ).
    ENDIF.

    LOOP AT lt_failed-salesorderitem INTO DATA(ls_failed).
      APPEND VALUE #( %tky-SalesOrder     = ls_failed-%tky-SalesOrder
                      %tky-SalesOrderItem = ls_failed-%tky-SalesOrderItem ) TO failed-zr_so_item_bm.
      APPEND VALUE #( %tky-SalesOrder     = ls_failed-%tky-SalesOrder
                      %tky-SalesOrderItem = ls_failed-%tky-SalesOrderItem
                      %msg = new_message( id = 'Z001'
                                      number = 01
                                      v1     = 'SO item not found'
                                      severity = if_abap_behv_message=>severity-error ) ) TO reported-zr_so_item_bm.
    ENDLOOP.

  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD rba_So.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZR_SO_BM DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZR_SO_BM IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.