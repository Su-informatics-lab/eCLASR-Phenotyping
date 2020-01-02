-- Only include patients that are present in both the EMR facts table
-- and the demographics table. Patients lacking either demographic or
-- fact records end up being excluded in downstream processing, and the
-- absence of data often causes interpretation obstacles: better
-- to exclude at the outset.

WITH
   emrPts AS (
      SELECT DISTINCT patient_num FROM {{ source('emr', 'emr') }}
   ),
   demoPts AS (
      SELECT DISTINCT patient_num FROM {{ source('emr', 'demo') }}
   ),
   pts AS (
      SELECT * FROM emrPts
         INTERSECT
      SELECT * FROM demoPts
   )
SELECT patient_num FROM pts
