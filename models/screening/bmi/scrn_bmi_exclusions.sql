{% set cutoff_labels = get_column_values(ref('cutoff_dates'), 'label', default=[]) %}

-- TODO: Extract into a macro to be used by BMI and Vitals

SELECT
   patient_num,
   {% for cutoff_label in cutoff_labels %}
   bool_and(
       CASE
           WHEN cutoff_label = '{{ cutoff_label }}' THEN bmi_exclude
                                          ELSE NULL
       END) AS bmi_{{ cutoff_label }},
   max(
       CASE
           WHEN cutoff_label = '{{ cutoff_label }}' THEN max_bmi
                                          ELSE NULL
       END) AS max_bmi_{{ cutoff_label }}
      {%- if not loop.last -%},{% endif %}
   {% endfor %}
FROM
   {{ ref('scrn_bmi_exclusion_by_cutoff') }}
GROUP BY
   patient_num
