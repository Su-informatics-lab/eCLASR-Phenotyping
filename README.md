# eCLASR™: Phenotyping

Each candidate in the Screening Cohort is phenotyped according to his or her
EMR stored in the Screening Data Warehouse, phenotypes relevant to the
study's recruitment criteria, and corresponding phenotyping algorithms. The
results are stored in the EMR Evidence Data Warehouse, following the Common
Phenotype Model and the Common Data Warehouse Schema.

Key data elements
stored in the EMR Evidence DW are the dictation of a phenotype, the EMR
facts supporting the dictation, the dates of such facts, and the
corresponding protocol criteria associated with the phenotype. The date
information is important for candidate screening, as criteria often include requirements of
time ranges, such as “no history of `CONDITION` within the last 6 months”.

The phenotyping conclusion is exported to a standardized, text-based spreadsheet, which is used as
the input for
[Revealing Snow](https://github.com/Su-informatics-lab/eCLASR-RevealingSnow).

## US POINTER Protocol - Known Issues

The criteria dependency graph (CDG), reference data, and models are based on
**version 2.0** of the US POINTER Protocol. However, there are a number of
inconsistencies between the current implementation and an ideal,
perfect implementation of the protocol. 

The following are the known limitations/discrepancies:

* The TIA criterion is split into two parts with different cutoff dates. The CDG only maps this
 to a single phenotype.
* The therapy and nursing home criteria are exclusionary if the patient is "currently" receiving
 physical therapy. The correct interpretation of a corresponding cutoff date is unclear; it is currently
 set to three months.
* No clinician review of the CDG has been performed since the March 2019 review based on Protocol v1.3.
* There are phenotypes with no fact correspondence in the CDG. This means that patients are *not*
  excluded for any of the following:
    * Opiate analgesics
    * Medications with significant central anticholinergic activity
    * Q waves or ST-segment depressions (>3 mm) on ECG
    * Small vessel stroke
    * Chronic obstructive pulmonary disease (COPD)
    * Assisted living facility
    * Hospice care
    * Fasting glucose > 100mg/dL
    * Narcotics
* The psychoactive drugs criterion received a major update in v1.4. We don't have a current
  decision of how best to update the CDG to reflect that update.
* The Type II diabetes criteria and phenotypes need to be reviewed for completeness and accuracy.
* Use of systemic corticosteroids is included in the CDG without accommodation for
  excluding only *daily* use.
* There are some non-exclusionary EMR facts associated with heart-related conditions
    that are currently exclusionary (e.g. 2nd degree heart block). These mappings
    may need clinician review.
* The list of allowed phenotypes associated with lung disease has expanded in v2.0, but
  the phenotype-fact mapping has not been modified accordingly.
  


## License

The most appropriate open source license for this project has not yet been determined.

Until a license decision has been made, the authors retain exclusive copyright to this software.
