@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Composite Sales Order'
@Metadata.ignorePropagatedAnnotations: true
define root view entity zr_so_bm
  as select from zi_so_bm
  composition [0..*] of zr_so_item_bm as _item
{
  key SalesOrder,
      SalesOrderType,
      SalesOrganization,
      DistributionChannel,
      OrganizationDivision,
      SoldToParty,
      _item
}
