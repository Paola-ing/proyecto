{{ config(materialized='table', enabled=true) }}

select distinct
  date,
  year,
  month
from {{ ref('fct_ventas') }};
