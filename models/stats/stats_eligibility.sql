    WITH
        ec AS (
            SELECT patient_num, eligible
              FROM {{ ref('eligibility_conclusion') }}
        ),
        ptct AS (
            SELECT
                count(*)                                      AS num_patients,
                sum(CASE WHEN eligible THEN 1 ELSE 0 END)     AS num_eligible,
                sum(CASE WHEN NOT eligible THEN 1 ELSE 0 END) AS num_ineligible
              FROM ec
        )
  SELECT *
    FROM ptct
