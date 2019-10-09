  WITH
      cdg AS (
          SELECT DISTINCT criteria_id, criteria_label, phenotype_id, phenotype_key, phenotype_label
            FROM {{ ref('cdg_wide') }}
      ),
      cpts AS (
          SELECT DISTINCT criteria_id, phenotype_id, patient_num
            FROM {{ ref('scrn_concept_records_latest_phenotype') }}
      ),
      stats AS (
          SELECT
              cdg.criteria_id,
              cdg.phenotype_id,
              cdg.criteria_label,
              cdg.phenotype_label,
              count(DISTINCT cpts.patient_num) AS num_pts
            FROM
                cdg
                    LEFT OUTER JOIN cpts
                                    ON (cdg.criteria_id = cpts.criteria_id AND cdg.phenotype_id = cpts.phenotype_id)
           GROUP BY cdg.criteria_id, cdg.phenotype_id, cdg.criteria_label, cdg.phenotype_label
      )
SELECT *
  FROM stats
 ORDER BY criteria_id
