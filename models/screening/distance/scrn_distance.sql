  WITH
     fac AS (
        SELECT
           facility_type,
           facility_site,
           facility_branch,
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
           pts.patient_num,
           fac.facility_type,
           fac.facility_site,
           fac.facility_branch,
           fac.facility_id,
           {{ haversine_distance("fac.latitude", "fac.longitude", "pts.latitude", "pts.longitude") }} AS distance
          FROM
             fac
             CROSS JOIN pts
     )
SELECT *
  FROM dist
