{% set support_tables = {
      'demo': 'scrn_demo',
      'encounter': 'scrn_last_encounter',
      'cdg': 'scrn_concepts_wide',
      'efi': 'scrn_efi',
      'vitals': 'scrn_vital_exclusions',
      'bmi': 'scrn_bmi_exclusions',
      'dist': 'scrn_distance_wide'
   }
%}

  WITH
     patients AS (
        SELECT patient_num FROM {{ ref('base_patients') }}
     ),
     {% for st_key, st_ref in support_tables.items() %}
        {{ st_key }} AS (
           SELECT * FROM {{ ref(st_ref) }}
        )
        {%- if not loop.last %},{% endif %}
     {% endfor %}
SELECT
   pts.patient_num,
   {% for st_key, st_ref in support_tables.items() %}
      {{ star(from=ref(st_ref), except=['patient_num']) }}
      {%- if not loop.last %},{% endif %}
   {% endfor %}
  FROM
     patients pts
        {% for st_key, st_ref in support_tables.items() %}
        LEFT OUTER JOIN {{ st_key }} ON (pts.patient_num={{ st_key }}.patient_num)
        {% endfor %}
