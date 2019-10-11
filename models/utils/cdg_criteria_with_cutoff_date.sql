  WITH
      crit_norm AS (
          SELECT
              crit.*,
              coalesce(criteria_cutoff_interval::INTERVAL, INTERVAL '100 years') AS interval_value
            FROM {{ ref('cdg_criteria') }} as crit
      ),
      crit_dates AS (
          SELECT
              crit_norm.criteria_id,
              crit_norm.criteria_type,
              crit_norm.criteria_label,
              crit_norm.criteria_cutoff_interval,
              crit_norm.criteria_description,
              crit_norm.interval_value,
              '{{ var('reference_date') }}'::DATE as reference_date,
              ('{{ var('reference_date') }}'::DATE - interval_value)::DATE AS cutoff_date
            FROM
                crit_norm
      )
SELECT *
  FROM crit_dates
