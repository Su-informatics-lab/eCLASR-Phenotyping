  WITH
      vg AS (
          SELECT
              phenotype_key,
              fact_concept,
              minval,
              maxval
            FROM {{ ref('vital_guidelines') }}
      ),
      cdg AS (
          SELECT
              criteria_id,
              criteria_label,
              phenotype_id,
              phenotype_key,
              fact_concept
            FROM {{ ref('cdg_wide') }}
      ),
      vg_cdg AS (
          SELECT DISTINCT
              cdg.criteria_id,
              cdg.phenotype_id,
              vg.phenotype_key,
              vg.fact_concept,
              vg.minval,
              vg.maxval
            FROM
                vg
                    INNER JOIN cdg ON (vg.phenotype_key = cdg.phenotype_key)
           WHERE
               vg.fact_concept IS NULL OR
               vg.fact_concept = cdg.fact_concept
      )
SELECT *
  FROM vg_cdg
