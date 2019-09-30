  WITH
     dist AS (
        SELECT
           patient_num,
           {{ pivot('facility_id', get_column_values(ref('facilities'), 'facility_id'), agg='max', then_value='distance', else_value=0) }}
          FROM {{ ref('scrn_distance') }}
             GROUP BY patient_num
     )
SELECT *
  FROM dist
