  WITH
     fac AS (
        SELECT
           facility_id,
           latitude,
           longitude
          FROM {{ ref('facilities') }}
     ),
     pts AS (
        SELECT
           patient_num,
           latitude,
           longitude
          FROM {{ ref('base_census') }}
     ),
     dist AS (
        SELECT
           fac.facility_id,
           pts.patient_num,
           {{ haversine_distance("fac.latitude", "fac.longitude", "pts.latitude", "pts.longitude") }} AS distance
          FROM
             fac
             CROSS JOIN pts
     )
SELECT *
  FROM dist
