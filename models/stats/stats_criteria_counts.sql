  WITH
      cdg AS (
          SELECT DISTINCT criteria_id, criteria_label, criteria_cutoff_date
            FROM {{ ref('cdg_wide') }}
      ),
      cpts AS (
          SELECT DISTINCT criteria_id, patient_num, latest_date
            FROM {{ ref('scrn_concept_records_latest_criteria') }}
      ),
      stats AS (
          SELECT
                cdg.criteria_id, cdg.criteria_label,
                count(DISTINCT cpts.patient_num) as num_pts_with_crit,
                sum(CASE WHEN cpts.latest_date >= cdg.criteria_cutoff_date THEN 1 ELSE 0 END) as num_pts_within_cutoff,
                cdg.criteria_cutoff_date
            FROM
                cdg
                    LEFT OUTER JOIN cpts ON (cdg.criteria_id = cpts.criteria_id)
          GROUP BY cdg.criteria_id, cdg.criteria_label, cdg.criteria_cutoff_date
      )
SELECT *
  FROM stats
 ORDER BY criteria_id
