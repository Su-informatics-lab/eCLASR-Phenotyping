-- Verifies that all of the vital sign guidelines is able to be linked
-- to exactly one record each in the criteria dependency graph (CDG).

  WITH
      vg AS (
          SELECT *
            FROM {{ ref('vital_guidelines') }}
      ),
      vgw AS (
          SELECT *
            FROM {{ ref('vital_guidelines_wide') }}
      ),
      joined AS (
          SELECT
              vg.phenotype_key,
              vg.fact_concept,
              count(*) AS num_records
            FROM
                vg
                    LEFT OUTER JOIN vgw ON (vg.phenotype_key = vgw.phenotype_key AND vg.fact_concept = vgw.fact_concept)
           GROUP BY vg.phenotype_key, vg.fact_concept
      )
SELECT *
  FROM joined
 WHERE
     num_records <> 1
