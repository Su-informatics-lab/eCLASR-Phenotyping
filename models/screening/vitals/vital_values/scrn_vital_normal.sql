  WITH
      vgw AS (
          SELECT
              criteria_id,
              phenotype_id,
              minval AS min_guideline_value,
              maxval AS max_guideline_value
            FROM {{ ref('vital_guidelines_wide') }}
      ),
      vital_medians AS (
          SELECT
              patient_num,
              criteria_id,
              phenotype_id,
              cutoff_date,
              cutoff_label,
              max_date,
              median_value
            FROM {{ ref('scrn_vital_medians') }}
      ),
      normal AS (
          SELECT
              vm.patient_num,
              vm.criteria_id,
              vm.phenotype_id,
              vm.cutoff_date,
              vm.cutoff_label,
              vm.median_value,
              vgw.max_guideline_value,
              CASE
                  WHEN vm.median_value < vgw.max_guideline_value THEN TRUE
                  WHEN vm.median_value IS NULL                   THEN NULL
                                                                 ELSE FALSE
              END AS median_is_normal,
              vm.max_date
            FROM
                vital_medians vm
                    INNER JOIN vgw
                               ON (vm.criteria_id = vgw.criteria_id AND vm.phenotype_id = vgw.phenotype_id)
      )
SELECT *
  FROM normal
