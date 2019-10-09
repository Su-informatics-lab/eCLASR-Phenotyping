  WITH
      cdg AS (
          SELECT DISTINCT criteria_id, criteria_label
            FROM {{ ref('cdg_wide') }}
      ),
      cpts AS (
          SELECT DISTINCT criteria_id, patient_num
            FROM {{ ref('scrn_concept_records_latest_criteria') }}
      ),
      stats AS (
          SELECT
                cdg.criteria_id, cdg.criteria_label,
                count(DISTINCT cpts.patient_num) as num_pts
            FROM
                cdg
                    LEFT OUTER JOIN cpts ON (cdg.criteria_id = cpts.criteria_id)
          GROUP BY cdg.criteria_id, cdg.criteria_label
      )
SELECT *
  FROM stats
 ORDER BY criteria_id
