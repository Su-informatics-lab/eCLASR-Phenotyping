  WITH
      bmi AS (
          SELECT
              patient_num,
              start_date,
              bmi
            FROM {{ ref('scrn_bmi_combined') }}
      ),
      cutoffs AS (
          SELECT
              cutoff AS cutoff_date,
              label  AS cutoff_label
            FROM {{ ref('cutoff_dates') }}
      ),
      max_value_by_date AS (
          SELECT
              bmi.patient_num,
              cutoffs.cutoff_date,
              cutoffs.cutoff_label,
              max(CASE WHEN bmi.start_date > cutoffs.cutoff_date THEN bmi.bmi ELSE NULL END) AS max_bmi
            FROM
                bmi
                    CROSS JOIN cutoffs
           GROUP BY bmi.patient_num, cutoffs.cutoff_date, cutoffs.cutoff_label
      )
SELECT *
  FROM max_value_by_date
