{%
   set glucose_phenotype_keys = [
      'glucose_hba1c_lt_6'
   ]
%}

-- TODO: Extract threshold to seed data file or variable
{{ select_cdg_emr_records('phenotype_key', glucose_phenotype_keys) }}
   WHERE nval <= 20
