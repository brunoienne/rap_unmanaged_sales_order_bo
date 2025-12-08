unmanaged implementation in class zbp_r_so_bm unique;
strict ( 2 );

define behavior for zr_so_bm //alias <alias_name>
//late numbering
lock master
authorization master ( instance )
//etag master <field_name>
{
  create;
  update;
  delete;

  field ( readonly ) SalesOrder;

  association _item { create; }
}

define behavior for zr_so_item_bm //alias <alias_name>
//late numbering
lock dependent by _so
authorization dependent by _so
//etag master <field_name>
{
  update;
  delete;
  field ( readonly ) SalesOrder, SalesOrderItem;
  association _so;
}