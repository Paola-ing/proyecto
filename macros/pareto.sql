{% macro build_pareto(table_ref, where_clause, group_col, measure_expr) -%}
with base as (
    select
        {{ group_col }} as grp,
        {{ measure_expr }} as qty
    from {{ table_ref }}
    {%- if where_clause %} where {{ where_clause }} {%- endif %}
    group by {{ group_col }}
),
tot as (
    select sum(qty) as total from base
)
select
    grp as {{ group_col }},
    qty as Cantidad,
    {{ safe_divide('qty','tot.total','0') }} as "%",
    sum({{ safe_divide('qty','tot.total','0') }}) over (order by qty desc) as Acumulado
from base
cross join tot
order by qty desc
{%- endmacro %}
