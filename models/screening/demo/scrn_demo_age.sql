SELECT
    patient_num,
    birth_date,
    round(extract(DAYS FROM ('{{ var('reference_date') }}' :: DATE - birth_date)) / 365.25) AS age
FROM
    {{ ref('base_demo') }}
