*&---------------------------------------------------------------------*
*& Report ZAD_SO_CHANGE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zad_so_change.

TABLES: vbap.

DATA: ireturn            TYPE STANDARD TABLE OF bapiret2           WITH HEADER LINE,
      iorder_keys        TYPE STANDARD TABLE OF bapisdkey          WITH HEADER LINE,
      iorder_hdr_in      TYPE STANDARD TABLE OF bapisdhd1          WITH HEADER LINE,
      iorder_hdr_inx     TYPE STANDARD TABLE OF bapisdhd1x         WITH HEADER LINE,
      iorder_item_in     TYPE STANDARD TABLE OF bapisditm          WITH HEADER LINE,
      iorder_item_inx    TYPE STANDARD TABLE OF bapisditmx         WITH HEADER LINE,
      iorder_cond_in     TYPE STANDARD TABLE OF bapicond           WITH HEADER LINE,
      iorder_cond_inx    TYPE STANDARD TABLE OF bapicondx          WITH HEADER LINE,
      iorder_text        TYPE STANDARD TABLE OF bapisdtext         WITH HEADER LINE,
      commit_return      TYPE STANDARD TABLE OF bapiret2           WITH HEADER LINE,
      iorder_number      LIKE bapivbeln-vbeln,
      v_msg_txt(220),
      msg_id             LIKE sy-msgid,
      msg_no             LIKE sy-msgno,
      msg_vl             LIKE sy-msgv1,
      change_item_number LIKE vbap-posnr.

DATA: iorder_inx    TYPE bapisdh1x VALUE 'U',
      ilogic_switch TYPE bapisdls.

PARAMETERS: p_order LIKE vbak-vbeln MATCHCODE OBJECT vmva,
            p_item  LIKE vbap-posnr.

START-OF-SELECTION.

  "Encapsulamento
  PERFORM new-pricing.
  PERFORM commit_order.
  PERFORM add_new_conditions.
  PERFORM commit_order.
*&---------------------------------------------------------------------*
*&      Form  NEW-PRICING
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM new-pricing .

  SKIP.
  WRITE: / ' * * * Carry out new pricing * * * '.
  SKIP.

  SELECT SINGLE * FROM vbap WHERE vbeln = p_order
                              AND posnr = p_item.

  iorder_number = vbap-vbeln.

  CLEAR iorder_item_in.

  iorder_item_in-itm_number = vbap-posnr.
  iorder_item_in-material   = vbap-matnr.
  iorder_item_in-item_categ = vbap-pstyv.

  APPEND iorder_item_in.


  CLEAR iorder_item_inx.

  iorder_item_inx-itm_number = vbap-posnr.
  iorder_item_inx-updateflag = 'U'.
  APPEND iorder_item_inx.

  ilogic_switch-pricing = 'B'.

  CALL FUNCTION 'BAPI_SALESORDER_CHANGE'
    EXPORTING
      salesdocument     = iorder_number
      order_header_inx = iorder_inx
      logic_switch      = ilogic_switch
    TABLES
      return            = ireturn
      order_keys        = iorder_keys
      order_item_in     = iorder_item_in
      order_item_inx    = iorder_item_inx
      conditions_in        = iorder_cond_in
      conditions_inx    = iorder_cond_inx.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  COMMIT_ORDER
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM commit_order .

  WRITE: /5 'ORDER NUMBER ->', iorder_number.
  SKIP.

  LOOP AT ireturn.

    CALL FUNCTION 'MESSAGE_TEXT_BUILD'
      EXPORTING
        msgid               = ireturn-id
        msgnr               = ireturn-number
        msgv1               = ireturn-message
      IMPORTING
        message_text_output = v_msg_txt
      EXCEPTIONS
        OTHERS              = 1.

    WRITE: / v_msg_txt.

  ENDLOOP.

  CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
    IMPORTING
      return = commit_return.

  REFRESH: iorder_hdr_in, iorder_item_in, ireturn.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  ADD_NEW_CONDITIONS
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM add_new_conditions .

  SKIP.
  WRITE: / '* * * NEW PRICES * * *'.
  SKIP.

  REFRESH: ireturn, iorder_item_in, iorder_item_inx, iorder_cond_in.

  iorder_number = vbap-vbeln.

  CLEAR iorder_item_in.
  iorder_item_in-itm_number = vbap-posnr.
  iorder_item_in-material = vbap-matnr.
  iorder_item_in-item_categ = vbap-pstyv.
  APPEND iorder_item_in.

  CLEAR iorder_item_inx.
  iorder_item_inx-itm_number = vbap-posnr.
  iorder_item_inx-updateflag = 'U'.
  APPEND iorder_item_inx.

  CLEAR iorder_cond_in.
  iorder_cond_in-itm_number = vbap-vbeln.
  iorder_cond_in-cond_type =  'ZR00'.
  "Dependendo do requirement esse campo deve ser preenchido com uma condicao
  iorder_cond_in-cond_value = '175'.
  iorder_cond_in-currency = 'USD'.
  APPEND iorder_cond_in.

  CLEAR iorder_cond_inx.
  iorder_cond_inx-itm_number = vbap-posnr.
  iorder_cond_inx-cond_type = 'ZR00'.
  iorder_cond_inx-updateflag = 'I'.
  iorder_cond_inx-cond_value = 'X'.
  iorder_cond_inx-currency = 'EUR'.
  APPEND iorder_cond_inx.

  CLEAR iorder_cond_in.
  iorder_cond_in-itm_number = vbap-vbeln.
  iorder_cond_in-cond_type =  'ZN02'.
  "Dependendo do requirement esse campo deve ser preenchido com uma condicao
  iorder_cond_in-cond_value = '175'.
  iorder_cond_in-currency = 'USD'.
  APPEND iorder_cond_in.

  CLEAR iorder_cond_inx.
  iorder_cond_inx-itm_number = vbap-posnr.
  iorder_cond_inx-cond_type = 'ZN02'.
  iorder_cond_inx-updateflag = 'I'.
  iorder_cond_inx-cond_value = 'X'.
  iorder_cond_inx-currency = 'EUR'.
  APPEND iorder_cond_inx.

  CALL FUNCTION 'BAPI_SALESORDER_CHANGE'
    EXPORTING
      salesdocument     = iorder_number
      order_header_inx = iorder_inx
    TABLES
      return            = ireturn
      order_item_in     = iorder_item_in
      order_item_inx    = iorder_item_inx
      conditions_in     = iorder_cond_in
      conditions_inx    = iorder_cond_inx.

ENDFORM.