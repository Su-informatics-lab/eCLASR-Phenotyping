{% macro quoted_join(values, separator=',', quote_char="'") %}
   {%- for value in values -%}
      {{- quote_char -}}
      {{- value -}}
      {{- quote_char -}}
      {%- if not loop.last -%}{{ separator }} {% endif -%}
   {%- endfor -%}
{% endmacro %}