-- TODO: Extract the cutoff value into a reference table.
{% set bmi_exclusion_cutoff = 40 %}

  WITH
      bmi AS (
          SELECT
              patient_num,
              cutoff_date,
              cutoff_label,
              max_bmi
            FROM {{ ref('scrn_bmi_value_by_cutoff') }}
      ),
      excluded AS (
          SELECT
              patient_num,
              cutoff_date,
              cutoff_label,
              max_bmi,
              max_bmi >= {{ bmi_exclusion_cutoff }} AS bmi_exclude
            FROM bmi
      )
SELECT *
  FROM excluded
