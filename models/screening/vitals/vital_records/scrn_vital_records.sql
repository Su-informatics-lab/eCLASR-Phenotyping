WITH
   sbp AS (
      SELECT * FROM {{ ref('scrn_vital_records_sbp') }}
   ),
   hba1c AS (
      SELECT * FROM {{ ref('scrn_vital_records_glucose') }}
   ),
   chol AS (
      SELECT * FROM {{ ref('scrn_vital_records_cholesterol') }}
   ),
   joined AS (
      SELECT * FROM sbp

      UNION ALL

      SELECT * FROM hba1c

      UNION ALL

      SELECT * FROM chol
   )
SELECT
   *
FROM joined
