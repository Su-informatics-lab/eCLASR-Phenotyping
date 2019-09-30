{{ config(materialized='ephemeral') }}

SELECT DISTINCT patient_num FROM {{ source('emr', 'emr') }}
