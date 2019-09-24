  WITH
     cdg_wide AS (
        SELECT
           patient_num,
           {{
              pivot('criteria_label',
                 get_column_values(ref('scrn_cdg_emr_latest_criteria'), 'criteria_label'),
                 agg='max', then_value='latest_date', else_value='NULL'
              )
           }}
          FROM {{ ref('scrn_cdg_emr_latest_criteria') }}
             GROUP BY patient_num
     )
SELECT *
  FROM cdg_wide
