@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption to Sales Order Items'
@Metadata.ignorePropagatedAnnotations: true
define view entity zc_so_item_bm
  as projection on zr_so_item_bm
{
  key SalesOrder,
  key SalesOrderItem,
      Product,
      RequestedQuantityUnit,
      @Semantics.quantity.unitOfMeasure: 'RequestedQuantityUnit'
      RequestedQuantity,
      /* Associations */
      _so : redirected to parent zc_so_bm
}
