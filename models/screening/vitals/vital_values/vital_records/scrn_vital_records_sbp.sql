{%
   set sbp_phenotype_keys = [
      'bp_systolic_lt_125'
   ]
%}

-- TODO: Extract threshold to seed data file or variable
{{ select_cdg_emr_records('phenotype_key', sbp_phenotype_keys) }}
   WHERE nval > 30
