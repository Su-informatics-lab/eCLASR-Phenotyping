{# Extracted from dbt-utils: https://github.com/fishtown-analytics/dbt-utils #}

{% macro _is_relation(obj, macro) %}
    {%- if not (obj is mapping and obj.get('metadata', {}).get('type', '').endswith('Relation')) -%}
        {%- do exceptions.raise_compiler_error("Macro " ~ macro ~ " expected a Relation but received the value: " ~ obj) -%}
    {%- endif -%}
{% endmacro %}

{% macro identifier(value) %}
   "{{ value }}"
{% endmacro %}


{% macro star(from, relation_alias=False, except=[], separator=',') -%}

    {%- do _is_relation(from, 'star') -%}

    {#-- Prevent querying of db in parsing mode. This works because this macro does not create any new refs. #}
    {%- if not execute -%}
        {{ return('') }}
    {% endif %}

    {%- set include_cols = [] %}
    {%- set cols = adapter.get_columns_in_relation(from) -%}
    {%- for col in cols -%}

        {%- if col.column not in except -%}
            {% set _ = include_cols.append(col.column) %}

        {%- endif %}
    {%- endfor %}

    {%- for col in include_cols|sort %}

        {% if relation_alias %} {{ relation_alias }}.{% endif %} {{ identifier(col) }} {% if not loop.last %}{{ separator }}
        {% endif %}

    {%- endfor -%}
{%- endmacro %}