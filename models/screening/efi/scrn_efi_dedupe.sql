    WITH
        dedupe AS (
            SELECT *,
                   row_number() OVER (PARTITION BY mrn ORDER BY ref_date DESC) AS row_num
              FROM {{ ref('base_efi') }}
        )
  SELECT *
    FROM dedupe
   WHERE
       row_num = 1
