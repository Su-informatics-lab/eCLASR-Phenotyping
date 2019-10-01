{% set cutoff_labels = get_column_values(ref('cutoff_dates'), 'label', default=[]) %}

SELECT
   patient_num,
   {% for cutoff_label in cutoff_labels %}
   bool_and(
       CASE
           WHEN cutoff_date_label = '{{ cutoff_label }}' THEN all_are_normal
                                          ELSE NULL
       END) AS vit_{{ cutoff_label }},
   max(
       CASE
           WHEN cutoff_date_label = '{{ cutoff_label }}' THEN max_date
                                          ELSE NULL
       END) AS vit_{{ cutoff_label }}_date
      {%- if not loop.last -%},{% endif %}
   {% endfor %}
FROM
   {{ ref('scrn_vital_normal_by_cutoff') }}
GROUP BY
   patient_num
