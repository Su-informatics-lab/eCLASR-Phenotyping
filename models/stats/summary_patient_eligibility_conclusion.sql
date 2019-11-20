WITH eligible AS (
   SELECT
      patient_num,
      {{ star(from=ref('summary_patient_eligibility_evidence'), except=['patient_num'], separator=' AND ') }} AS eligible
   FROM {{ ref('summary_patient_eligibility_evidence') }}
)
SELECT * FROM eligible