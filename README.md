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


## License

The most appropriate open source license for this project has not yet been determined.

Until a license decision has been made, the authors retain exclusive copyright to this software.
