  WITH
      ht AS (
          SELECT
              patient_num,
              percentile_cont(0.5) WITHIN GROUP ( ORDER BY nval ) AS median_height
            FROM {{ ref('scrn_bmi_records_height') }}
           GROUP BY patient_num
      )
SELECT *
  FROM ht
