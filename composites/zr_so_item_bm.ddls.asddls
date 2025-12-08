@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Composite Sales Order Items'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zr_so_item_bm
  as select from zi_so_item_bm
  association to parent zr_so_bm as _so on _so.SalesOrder = $projection.SalesOrder
{
  key SalesOrder,
  key SalesOrderItem,
      Product,
      RequestedQuantityUnit,
      @Semantics.quantity.unitOfMeasure: 'RequestedQuantityUnit'
      RequestedQuantity,
      _so
}
