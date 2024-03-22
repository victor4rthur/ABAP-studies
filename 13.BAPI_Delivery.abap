*&---------------------------------------------------------------------*
*& Report ZAD_CREATE_DELIVERY
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zad_create_delivery.

"Recebe o resultado que a BAPI devolve
DATA: return_log TYPE bapiret2_t,
      dates      TYPE STANDARD TABLE OF bapidlvdeadln,
      dlv_items  TYPE STANDARD TABLE OF bapidlvnorefitem,
      timestamp  TYPE timestamp,
      ls_return  TYPE bapiret2.

FIELD-SYMBOLS:
               <fs_return> TYPE bapiret2.

INSERT VALUE #( material = '521'
                dlv_qty = '1'
                sales_unit = ''
                plant = '7500' )
                INTO TABLE dlv_items.

GET TIME STAMP FIELD timestamp.

"Delivery Date
INSERT VALUE #( timetype = 'WSHDRLFDAT'
                timestamp_utc = timestamp
                timezone = sy-zonlo )
                INTO TABLE dates.

"Goods Issue Date
INSERT VALUE #( timetype = 'WSHDRWADAT'
                timestamp_utc = timestamp
                timezone = sy-zonlo
                ) INTO TABLE dates.

CALL FUNCTION 'BAPI_OUTB_DELIVERY_CREATENOREF'
  EXPORTING
    ship_point = '1710' "Shipping point
    dlv_type   = 'LO2'  "Delivery type
    salesorg   = '7500' " Sales Organization
    distr_chan = '10' " Distribution channel
    division   = '00'   " Division
    ship_to    = '1' "Customer
  TABLES
    dates      = dates "Delivery deadlines
    dlv_items  = dlv_items "Delivery items without reference
    return     = return_log.

"Salvando no BD
CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
  IMPORTING
    return = ls_return.

LOOP AT return_log ASSIGNING <fs_return> WHERE type = 'S' AND id = 'BAPI'.
  WRITE: <fs_return>-message.
  NEW-LINE.
ENDLOOP.