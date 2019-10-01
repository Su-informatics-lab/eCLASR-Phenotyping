{%
   set height_concept_values = [
      'VITAL:HT',
   ]
%}

{{ select_cdg_emr_records('fact_concept', height_concept_values, emr_table_ref='scrn_bmi_records_filtered') }}
