  WITH
     cdg_emr AS (
        SELECT *
          FROM {{ ref('scrn_cdg_emr') }}
     ),
     grouped AS (
        SELECT
           patient_num,
           criteria_id,
           phenotype_id,
           max(start_date) as latest_date
          FROM cdg_emr
         GROUP BY patient_num, criteria_id, phenotype_id
     )
SELECT *
  FROM grouped