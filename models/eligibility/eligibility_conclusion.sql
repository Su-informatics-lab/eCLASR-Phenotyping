WITH eligible AS (
   SELECT
      patient_num,
      {{ star(from=ref('eligibility_evidence'), except=['patient_num'], separator=' AND ') }} AS eligible
   FROM {{ ref('eligibility_evidence') }}
)
SELECT * FROM eligible