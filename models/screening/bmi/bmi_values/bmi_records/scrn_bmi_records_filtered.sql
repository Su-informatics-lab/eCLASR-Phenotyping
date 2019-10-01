{% set bmi_record_phenotype_key = 'bmi' %}

-- TODO: Handle this (and the filtered vital signs tables) in a cleaner, more unified way.

  WITH
      vg AS (
          SELECT *
            FROM {{ ref('vital_guidelines_wide') }}
           WHERE
               phenotype_key = '{{ bmi_record_phenotype_key }}'
      ),
      emr_bmi AS (
          SELECT patient_num, encounter_num, start_date, concept, modifier, tval, nval
            FROM {{ ref('base_emr') }}
      ),
      joined AS (
          SELECT
                emr_bmi.*
            FROM
                emr_bmi
                    INNER JOIN vg ON (emr_bmi.concept = vg.fact_concept)
           WHERE
               emr_bmi.nval > vg.minval AND
               emr_bmi.nval < vg.maxval
      )
SELECT * FROM joined
