  WITH
     patients AS (
        SELECT DISTINCT patient_num FROM {{ ref('base_emr') }}
     ),
     cdg AS (
        SELECT * FROM {{ ref('scrn_concepts_wide') }}
     ),
     vitals AS (
        SELECT * FROM {{ ref('scrn_vital_exclusions') }}
     ),
     dist AS (
        SELECT * FROM {{ ref('scrn_distance_wide') }}
     )
SELECT
   pts.patient_num,
   {{ star(from=ref('scrn_concepts_wide'), except=['patient_num']) }},
   {{ star(from=ref('scrn_vital_exclusions'), except=['patient_num']) }},
   {{ star(from=ref('scrn_distance_wide'), except=['patient_num']) }}
  FROM
     patients pts
        LEFT OUTER JOIN cdg ON (pts.patient_num=cdg.patient_num)
        LEFT OUTER JOIN vitals ON (pts.patient_num=vitals.patient_num)
        LEFT OUTER JOIN dist ON (pts.patient_num=dist.patient_num)