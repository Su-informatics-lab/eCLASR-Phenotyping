{% macro select_cdg_emr_records(cdg_field, cdg_values, cdg_table_ref='cdg_wide', emr_table_ref='base_emr') %}
     WITH
        CDG AS (
           SELECT criteria_id, phenotype_id, fact_concept
             FROM
                {{ ref(cdg_table_ref) }}
            WHERE {{ cdg_field }} IN ({{ quoted_join(cdg_values) }})
        ),
        EMR AS (
           SELECT patient_num, encounter_num, start_date, concept, modifier, tval, nval
             FROM {{ ref(emr_table_ref) }}
        ),
        joined AS (
           SELECT
              EMR.patient_num,
              EMR.encounter_num,
              CDG.criteria_id,
              CDG.phenotype_id,
              EMR.start_date,
              EMR.concept,
              EMR.modifier,
              EMR.tval,
              EMR.nval
             FROM
                CDG
                   INNER JOIN EMR ON CDG.fact_concept = EMR.concept
        )
   SELECT *
     FROM joined
{% endmacro %}