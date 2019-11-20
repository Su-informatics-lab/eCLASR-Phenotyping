-- TODO: Use the criteria table instead of hardcoding the fields to use.

{%-
   set criteria = {
      'neuro': None,
      'bpd': None,
      'dep': '2018-10-01',
   }
-%}

{%- set bmi_year = '5yrs' -%}
{%- set bmi_col =  'bmi_{}'.format(bmi_year) %}

{%- set vit_year = '5yrs' -%}
{%- set vit_col =  'vit_{}'.format(vit_year) %}

{%- set flds = criteria.keys()|list + [bmi_col, vit_col] %}

    WITH
        scrn AS (
            SELECT
                patient_num,
                {{ flds|join(', ') }}
              FROM
                  {{ ref('scrn_integration') }}
        )
        ,
        eligible AS (
            SELECT
                patient_num,
                {% for field, value in criteria.items() %}
                   {{ field }} IS NULL
                   {% if value %}
                   OR {{ field }} < '{{ value }}'
                   {% endif %} AS eligible_{{ field }},
                {% endfor %}
                coalesce({{ vit_col }}, FALSE) <> TRUE as eligible_vit,
                coalesce({{ bmi_col }}, FALSE) <> TRUE as eligible_bmi
              FROM scrn
        )
  SELECT *
    FROM eligible
