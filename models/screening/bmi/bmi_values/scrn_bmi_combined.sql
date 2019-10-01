  WITH
      bmi_calc AS (
          SELECT
              patient_num,
              start_date,
              bmi
            FROM {{ ref('scrn_bmi_calculated_bmi') }}
      ),
      bmi_records AS (
          SELECT
              patient_num,
              start_date,
              nval AS bmi
            FROM {{ ref('scrn_bmi_records_bmi') }}
      ),
      combined AS (
          SELECT *
            FROM bmi_calc

           UNION ALL

          SELECT *
            FROM bmi_records
      )
SELECT *
  FROM combined
