@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order Header'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zi_so_bm
  as select from I_SalesOrder
{
  key SalesOrder,
      SalesOrderType,
      SalesOrganization,
      DistributionChannel,
      OrganizationDivision,
      SoldToParty

}
