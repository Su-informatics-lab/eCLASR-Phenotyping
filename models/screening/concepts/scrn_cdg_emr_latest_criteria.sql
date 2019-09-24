  WITH
     cdg_emr AS (
        SELECT *
          FROM {{ ref('scrn_cdg_emr_latest_phenotype') }}
     ),
     grouped AS (
        SELECT
           patient_num,
           criteria_id,
           max(latest_date) AS latest_date
          FROM cdg_emr
         GROUP BY patient_num, criteria_id
     ),
     crit_id AS (
        SELECT criteria_id, criteria_label
          FROM {{ ref('cdg_criteria') }}
     )
SELECT
   grouped.patient_num,
   crit_id.criteria_id,
   crit_id.criteria_label,
   grouped.latest_date
  FROM
     grouped
        INNER JOIN crit_id ON (grouped.criteria_id = crit_id.criteria_id)
