{{ config(materialized='table', enabled=true) }}

with df_inicial as (
    select * from {{ ref('fmcg_2022_2024_999') }}
)
select
    date("date") as date,
    cast(strftime('%Y',"date") as integer) as year,
    cast(strftime('%m',"date") as integer) as month,
    sku, brand, segment, category, channel, region, pack_type,
    cast(price_unit as real) as price_unit,
    cast(promotion_flag as int) as promotion_flag,
    cast(delivery_days as int) as delivery_days,
    cast(stock_available as int) as stock_available,
    cast(delivered_qty as int) as delivered_qty,
    cast(units_sold as int) as units_sold,
    cast(delivered_qty as real) * cast(price_unit as real) as "monto de venta",
    (cast(stock_available as int) - cast(delivered_qty as int)) as difference,
    case when (cast(stock_available as int) - cast(delivered_qty as int)) < 0
         then 'Backorder' else 'No Backorder' end as backorder_status
from df_inicial;
