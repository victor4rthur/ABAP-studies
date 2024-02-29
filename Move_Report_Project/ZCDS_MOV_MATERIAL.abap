@AbapCatalog.sqlViewName: 'ZCDSMOVMATERIAL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS de movimento de materiais'

define view ZCDS_MOV_MATERIAL 
    as select from mseg as Material
    inner join makt  as Description on Material.matnr = Description.matnr and
     Description.spras = 'E' 
    inner join t156t as Text        on Material.bwart = Text.bwart        and 
     Material.sobkz = Text.sobkz and   Material.kzbew = Text.kzbew        and
     Material.kzzug = Text.kzzug and   Material.kzvbr = Text.kzvbr        and
     Text.spras = 'E'
    inner join mkpf  as Document    on Material.mblnr = Document.mblnr    and
     Material.mjahr = Document.mjahr
{
    key Material.mblnr as NumMatDoc,
    key Material.zeile as ItMatDoc,
    
         Material.matnr     as MatNumber,
         Description.maktx  as MatDescript,
         Material.bwart     as MovTypeInventory,
         Text.btext         as MovType,
         Material.werks     as Plant,
         Material.lgort     as StorageLocation,         
         Document.budat     as PostDate,
         Material.wempf     as Recipient,
         Material.sgtxt     as ItemText,
         Material.menge     as Quantity,
         Material.meins     as Unit,
         Material.charg     as BatchNumber,
         Material.dmbtr     as AmountLocCur,
         Material.exbwr     as ExtEntPostAmoLocCur
}