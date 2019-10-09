  WITH
      demo AS (
          SELECT
              patient_num,
              coalesce(sex, '?') AS sex,
              coalesce(race, 'U') AS race,
              coalesce(ethnicity, 'U') AS ethnicity,
              vital_status
            FROM {{ ref('base_demo') }}
      ),
      age AS (
          SELECT
              patient_num,
              birth_date::date,
              age
            FROM {{ ref('scrn_demo_age') }}
      ),
      joined AS (
          SELECT
              demo.patient_num,
              demo.sex,
              demo.race,
              demo.ethnicity,
              demo.vital_status,
              age.birth_date,
              age.age
            FROM
                demo
                    INNER JOIN age ON (demo.patient_num = age.patient_num)
      )

SELECT *
  FROM joined
