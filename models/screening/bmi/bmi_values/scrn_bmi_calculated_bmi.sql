  WITH
      ht AS (
          SELECT *
            FROM {{ ref('scrn_bmi_median_height') }}
      ),
      wt AS (
          SELECT *
            FROM {{ ref('scrn_bmi_records_weight') }}
      ),
      bmi AS (
          SELECT
              wt.patient_num,
              wt.start_date,
              wt.nval                                             AS weight,
              ht.median_height,
              wt.nval / ht.median_height / ht.median_height * 703 AS bmi
            FROM
                ht
                    INNER JOIN wt ON (ht.patient_num = wt.patient_num)
      )
SELECT *
  FROM bmi
