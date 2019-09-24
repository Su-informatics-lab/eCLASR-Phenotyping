SELECT
   crit.criteria_id, crit.criteria_type, crit.criteria_label, crit.criteria_description,
   phen.phenotype_id, phen.phenotype_label,
   facts.fact_concept
  FROM
     {{ ref('cdg_criteria') }} crit
        INNER JOIN {{ ref('cdg_criteria_phenotype_mapping') }} cpm ON (crit.criteria_id = cpm.criteria_id)
        INNER JOIN {{ ref('cdg_phenotypes') }} phen ON (cpm.phenotype_id = phen.phenotype_id)
        INNER JOIN {{ ref('cdg_phenotype_fact_mapping') }} cpfm ON cpm.phenotype_id = cpfm.phenotype_id
        INNER JOIN {{ ref('cdg_facts') }} facts ON cpfm.fact_concept = facts.fact_concept
