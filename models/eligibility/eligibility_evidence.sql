-- This model combines the criteria-based evidence with BMI and vitals, and uses the full patient list to
-- ensure that all patients are represented.

{%- set bmi_year = '5yrs' -%}
{%- set bmi_col =  'bmi_{}'.format(bmi_year) %}

{%- set vit_year = '5yrs' -%}
{%- set vit_col =  'vit_{}'.format(vit_year) %}

    WITH
        pts AS (
            SELECT patient_num
              FROM {{ ref('base_patients') }}
        ),
        concepts AS (
            SELECT
                *
              FROM
                  {{ ref('eligibility_criteria_evidence') }}
        )
        ,
        bmi AS (
            SELECT
                patient_num,
                coalesce({{ bmi_col }}, FALSE) <> TRUE AS bmi
              FROM {{ ref('scrn_bmi_exclusions') }}
        ),
        vit AS (
            SELECT
                patient_num,
                coalesce({{ vit_col }}, FALSE) <> TRUE AS vit
              FROM {{ ref('scrn_vital_exclusions') }}
        ),
        eligible AS (
            SELECT
                pts.patient_num,
                {{ coalesce_star(from=ref('eligibility_criteria_evidence'), default='TRUE', relation_alias='concepts', except=['patient_num']) }},
                coalesce(bmi.bmi, TRUE) as bmi,
                coalesce(vit.vit, TRUE) as vit
              FROM
                  pts
                      LEFT OUTER JOIN concepts ON (pts.patient_num = concepts.patient_num)
                      LEFT OUTER JOIN bmi ON (pts.patient_num = bmi.patient_num)
                      LEFT OUTER JOIN vit ON (pts.patient_num = vit.patient_num)
        )
  SELECT *
    FROM eligible
