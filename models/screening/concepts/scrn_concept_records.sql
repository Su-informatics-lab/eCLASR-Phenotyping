-- Screening concepts requiring just a simple match to a fact_concept code (e.g.
-- ICD9, CPT, RXNORM, etc.)

{%
   set screening_concepts = [
      'neuro',
      'dep',
      'bpd',
      'schizo',
      'sub_abuse',
      'cardio',
      'heart',
      'stroke_large',
      'tia',
      'lung',
      'renal',
      'bone',
      'therapy',
      'bariatric',
      'nursing_home',
      'pregnant',
      'clot',
      'cancer',
      'drugs_ad',
      'drugs_psychoactive',
      't2d_insulin'
   ]
%}

  WITH
     CDG AS (
        SELECT criteria_id, phenotype_id, fact_concept
          FROM
             {{ ref('cdg_wide') }}
        WHERE criteria_label IN ({{ quoted_join(screening_concepts) }})
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
