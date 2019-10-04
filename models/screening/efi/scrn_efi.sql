    WITH
        efi AS (
            SELECT mrn, phys_disability, frailty_status
              FROM {{ ref('scrn_efi_dedupe') }}
        ),
        ptmrn AS (
            SELECT patient_num, mrn
              FROM {{ ref('base_demo') }}
        ),
        joined AS(
            SELECT
                ptmrn.patient_num,
                efi.phys_disability,
                efi.frailty_status
              FROM efi INNER JOIN ptmrn ON (efi.mrn=ptmrn.mrn)
        )
  SELECT *
    FROM joined
