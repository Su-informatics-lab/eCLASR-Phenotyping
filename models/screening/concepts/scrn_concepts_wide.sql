  WITH
     cdg_wide AS (
        SELECT
           patient_num,
           {{
              pivot('criteria_label',
                 get_column_values(ref('scrn_concept_records_latest_criteria'), 'criteria_label', default=[]),
                 agg='max', then_value='latest_date', else_value='NULL'
              )
           }}
          FROM {{ ref('scrn_concept_records_latest_criteria') }}
             GROUP BY patient_num
     )
SELECT *
  FROM cdg_wide
