
<!-- README.md is generated from README.Rmd. Please edit that file -->

# thermos

<!-- badges: start -->
<!-- badges: end -->

thermos provides a simple way to interact with ThermoFisher’s
IonReporter API from within R.

## Installation

You can install the development version of thermos from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("KaiAragaki/thermos")
```

# Philosophy

API endpoint names have been translated to function names by converting
camelCase to snake_case, even when the original names were not so good.
I’m not particularly fond of some of the names, so I might add some
aliases later.

Here’s a decoder ring:

| API                                           | thermos                                              | Possible Alias         |
|-----------------------------------------------|------------------------------------------------------|------------------------|
| `isAnalysisRunning`                           | `is_analysis_running`                                |                        |
| `isSampleExists`                              | `is_sample_exists`                                   | `sample_exists`        |
| `downloadBam`                                 | `download_bam`                                       |                        |
| `download`                                    | `download`                                           |                        |
| `analysis`                                    | `analysis`                                           | `get_analysis`         |
| `getAssociatedBamfiles`                       | `get_associated_bamfiles`                            |                        |
| `getAvailableCancerType`                      | `get_available_cancer_type`                          |                        |
| `getAvailableStorageSpace`                    | `get_available_storage_space`                        |                        |
| `currentResultsTsv`                           | `current_results_tsv`                                |                        |
| `getDataUploadPathWithAuth`                   | `get_data_upload_path_with_auth`                     |                        |
| `finalreport`                                 | `finalreport`                                        | `get_final_report`     |
| `qcreport`                                    | `qcreport`                                           | `get_qc_report`        |
| `getUserDetails`                              | `get_user_details`                                   |                        |
| `getUserDetailsWithAuth`                      | `get_user_details_with_auth`                         |                        |
| `getvcf`                                      | `getvcf`                                             | `get_vcf`              |
| `genomeView`                                  | `genome_view`                                        |                        |
| `getWorkflowNamesWithApplicationTypeWithAuth` | `get_workflow_names_with_application_type_with_auth` | `get_workflow_names`   |
| `startAnalysis`                               | `start_analysis`                                     |                        |
| `unsharedAnalyses`                            | `unshared_analyses`                                  | `unshare_analyses`[^1] |

Whenever possible, I’ve tried to maintain similar behavior between the
API and the package, so hopefully you only have to learn one thing. In
particular, default arguments should be the same as in the API.

I *will* try my best to make the documentation a bit more detailed than
the documentation provided by ThermoFisher.

[^1]: [The
    documentation](https://ionreporter.thermofisher.com/ionreporter/help/GUID-DF029997-3B2F-44FB-8116-192689AE492D.html)
    is conflicted about the naming of this function, with the title
    saying ‘unshare’, the endpoint saying ‘unshared’, and the
    description saying ‘unshares’. The intent implies it is a verb - ‘to
    unshare’ - so this function name makes more sense.
