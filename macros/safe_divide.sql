﻿{% macro safe_divide(numerator, denominator, default=0) -%}
    case
        when {{ denominator }} is null or {{ denominator }} = 0 then {{ default }}
        else 1.0 * {{ numerator }} / {{ denominator }}
    end
{%- endmacro %}
