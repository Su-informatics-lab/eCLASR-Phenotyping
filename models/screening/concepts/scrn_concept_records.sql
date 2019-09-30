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

{{ select_cdg_emr_records('criteria_label', screening_concepts) }}
