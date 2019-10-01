{%
   set cholesterol_phenotype_keys = [
      'chol_ldl_lt_130'
   ]
%}

-- TODO: Extract threshold to seed data file or variable
{{ select_cdg_emr_records('phenotype_key', cholesterol_phenotype_keys) }}
   WHERE nval > 0 AND nval <= 300
