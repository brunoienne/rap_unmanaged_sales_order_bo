@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption to Sales Order'
@Metadata.ignorePropagatedAnnotations: true
define root view entity zc_so_bm
  provider contract transactional_query
  as projection on zr_so_bm
{
  key SalesOrder,
      SalesOrderType,
      SalesOrganization,
      DistributionChannel,
      OrganizationDivision,
      SoldToParty,
      /* Associations */
      _item : redirected to composition child zc_so_item_bm
}
