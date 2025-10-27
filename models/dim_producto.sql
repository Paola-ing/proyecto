{{ config(materialized='table', enabled=true) }}

-- Dimensión Producto desde el fact
select distinct
  category,
  sku,
  brand,
  channel,
  region
from {{ ref('fct_ventas') }};
