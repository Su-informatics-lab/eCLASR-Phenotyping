  WITH
      vital_normal AS (
          SELECT
              patient_num,
              criteria_id,
              phenotype_id,
              cutoff_label AS cutoff_date_label,
              median_is_normal,
              max_date
            FROM
                {{ ref('scrn_vital_normal') }}
      ),
      vital_normal_summary AS (
          SELECT
              patient_num,
              cutoff_date_label,
              bool_and(median_is_normal)   AS all_are_normal,
              bool_or(median_is_normal)    AS any_are_normal,
              max(max_date)                AS max_date,
              count(DISTINCT criteria_id)  AS num_criteria,
              count(DISTINCT phenotype_id) AS num_phenotypes,
              count(*)                     AS num_records
            FROM
                vital_normal
           GROUP BY patient_num, cutoff_date_label
      )
SELECT *
  FROM vital_normal_summary