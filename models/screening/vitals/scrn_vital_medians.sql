  WITH
      cutoffs AS (
          SELECT
              cutoff AS cutoff_date,
              label  AS cutoff_label
            FROM {{ ref('cutoff_dates') }}
      ),
      emr AS (
          SELECT
              patient_num,
              criteria_id,
              phenotype_id,
              start_date,
              concept,
              nval
            FROM
                {{ ref('scrn_vital_records') }}
      ),
      medians AS (
          SELECT
              emr.patient_num,
              emr.criteria_id,
              emr.phenotype_id,
              cutoffs.cutoff_date,
              cutoffs.cutoff_label,
              percentile_cont(0.5) WITHIN GROUP (
                  ORDER BY CASE WHEN emr.start_date > cutoffs.cutoff_date THEN emr.nval ELSE NULL END ) AS median_value,
              sum(CASE WHEN emr.start_date > cutoffs.cutoff_date THEN 1 ELSE 0 END)                     AS num_records,
              max(CASE WHEN emr.start_date > cutoffs.cutoff_date THEN emr.start_date ELSE NULL END)     AS max_date
            FROM
                emr
                    CROSS JOIN cutoffs
           GROUP BY emr.patient_num, emr.criteria_id, emr.phenotype_id, cutoffs.cutoff_date, cutoffs.cutoff_label
      )
SELECT *
  FROM
      medians