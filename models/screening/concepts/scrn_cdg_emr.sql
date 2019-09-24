  WITH
     CDG AS (
        SELECT criteria_id, phenotype_id, fact_concept
          FROM
             {{ ref('cdg') }}
     ),
     EMR AS (
        SELECT patient_num, encounter_num, start_date, concept, modifier, tval, nval
          FROM {{ ref('base_emr') }}
     ),
     joined AS (
        SELECT
           EMR.patient_num,
           EMR.encounter_num,
           CDG.criteria_id,
           CDG.phenotype_id,
           EMR.start_date,
           EMR.concept,
           EMR.modifier,
           EMR.tval,
           EMR.nval
          FROM
             CDG
                INNER JOIN EMR ON CDG.fact_concept = EMR.concept
     )
SELECT *
  FROM joined
