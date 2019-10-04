    WITH
        last_encounter AS (
            SELECT
                be.patient_num,
                max(be.start_date)::DATE as last_encounter_date
              FROM {{ ref('base_encounters') }} be
             WHERE
                 be.start_date < '{{ var('reference_date') }}'
             GROUP BY be.patient_num
        )
  SELECT *
    FROM last_encounter
