{%
   set weight_concept_values = [
      'VITAL:WT',
   ]
%}

{{ select_cdg_emr_records('fact_concept', weight_concept_values) }}
