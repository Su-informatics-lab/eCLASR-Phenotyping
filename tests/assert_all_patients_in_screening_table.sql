-- Verifies that all of the patients in the EMR facts table are represented
-- in the final integration table.

WITH
  all_pts AS (
     SELECT patient_num
       FROM {{ ref('base_patients') }}
  ),
  scrn_pts AS (
     SELECT patient_num
       FROM {{ ref('scrn_integration') }}
  ),
  matched AS (
     SELECT
        all_pts.patient_num as all_pt_num,
        scrn_pts.patient_num as scrn_pt_num
       FROM all_pts LEFT OUTER JOIN scrn_pts ON (all_pts.patient_num=scrn_pts.patient_num)
  )
SELECT * FROM matched
WHERE scrn_pt_num IS NULL
