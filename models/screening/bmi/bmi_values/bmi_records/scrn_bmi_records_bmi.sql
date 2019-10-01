{%
   set bmi_concept_values = [
      'VITAL:ORIGINAL_BMI',
      'ECHO:BMI'
   ]
%}

{{ select_cdg_emr_records('fact_concept', bmi_concept_values) }}
