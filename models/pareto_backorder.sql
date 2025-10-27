{{ config(materialized="table", enabled=true) }}
{{ build_pareto(
    ref("fct_ventas"),
    "backorder_status = ''Backorder''",
    "category",
    "count(*)"
) }}
