projection;
strict ( 2 );

define behavior for zc_so_bm //alias <alias_name>
{
  use create;
  use update;
  use delete;

  use association _item { create; }
}

define behavior for zc_so_item_bm //alias <alias_name>
{
  use update;
  use delete;

  use association _so;
}