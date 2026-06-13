{% macro clean_text(col_name) %}

UPPER(TRIM({{col_name}}))

{% endmacro %}