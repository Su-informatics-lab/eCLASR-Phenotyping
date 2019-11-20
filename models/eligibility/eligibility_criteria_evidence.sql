{# TODO: Add a column to the CDG to indicate whether each criterion should be active by default. Using
         hard-coded exclusions for now. #}

{% set excluded_criteria = ['drugs_ad', 'drugs_psychoactive'] %}

    WITH
        cpts AS (
            SELECT DISTINCT criteria_id, patient_num, latest_date
              FROM {{ ref('scrn_concept_records_latest_criteria') }}
        ),
        cdg AS (
            SELECT DISTINCT criteria_id, criteria_label, criteria_cutoff_date
              FROM {{ ref('cdg_wide') }}
              WHERE criteria_label NOT IN ({{ quoted_join(excluded_criteria) }})
        ),
        ecrit AS (
            SELECT
                patient_num,
                cdg.criteria_id,
                criteria_label,
                CASE
                    WHEN cpts.latest_date IS NULL                    THEN TRUE
                    WHEN cpts.latest_date < cdg.criteria_cutoff_date THEN TRUE
                                                                     ELSE FALSE
                END AS eligible,
                cpts.latest_date,
                cdg.criteria_cutoff_date
              FROM
                  cpts
                      LEFT OUTER JOIN cdg ON (cpts.criteria_id = cdg.criteria_id)
        ),
        ecrit_wide AS (
            SELECT
                patient_num,
                {{
                   pivot('criteria_label',
                      get_column_values(ref('scrn_concept_records_latest_criteria'), 'criteria_label', default=[]),
                      agg='bool_and', then_value='eligible', else_value='TRUE'
                   )
                }}
              FROM ecrit
             GROUP BY patient_num
        )
  SELECT *
    FROM ecrit_wide
