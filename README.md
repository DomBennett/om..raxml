
<!--
The README should be used to describe the program. It acts like the homepage of
your module.

Edit README.Rmd not README.md. The .Rmd file can be knitted to parse real-code
examples and show their output in the .md file.

To knit, use devtools::build_readme() or outsider.devtools::build()

Edit the template to describe your program: how to install, import and run;
run exemplary, small demonstrations; present key arguments; provide links and
references to the program that the module wraps.

Learn more about markdown and Rmarkdown:
https://daringfireball.net/projects/markdown/syntax
https://rmarkdown.rstudio.com/
-->

# Run [`raxml`](https://cme.h-its.org/exelixis/web/software/raxml/index.html) through `outsider` in R

[![Build
Status](https://travis-ci.org/DomBennett/om..raxml.svg?branch=master)](https://travis-ci.org/DomBennett/om..raxml)

> Randomized Axelerated Maximum Likelihood (RAxML): Phylogenetic
> Analysis and Post-Analysis of Large Phylogenies

<!-- Install information -->

## Install and look up help

``` r
library(outsider)
#> ----------------
#> outsider v 0.1.0
#> ----------------
#> - Security notice: be sure of which modules you install
module_install(repo = "dombennett/om..raxml")
#> -----------------------------------------------------
#> Warning: You are about to install an outsider module!
#> -----------------------------------------------------
#> Outsider modules install and run external programs
#> via Docker <https://www.docker.com>. These external
#> programs may communicate with the internet and could
#> potentially be malicious.
#> 
#> Be sure to know the module you are about to install:
#> Is it from a trusted developer? Are colleagues using
#> it? Is it supposed to download lots of data? Is it
#> well used (e.g. check number of stars on GitHub)?
#> -----------------------------------------------------
#>  Module information
#> -----------------------------------------------------
#> program: RAxML
#> details: Randomized Axelerated Maximum Likelihood (8.2.12 HPC PTHREADS SSE3) for inferring phylogenies
#> docker: dombennett
#> github: dombennett
#> url: https://github.com/DomBennett/om..raxml
#> image: dombennett/om_raxml
#> container: om_raxml
#> package: om..raxml
#> Travis CI: Failing/Erroring
#> -----------------------------------------------------
#> Enter any key to continue or press Esc to quit
#module_help(repo = "dombennett/om..raxml")
```

<!-- Detailed examples -->

## Partitioned DNA analysis

> All demonstrations are taken from the [RAxML
> “hands-on”](https://cme.h-its.org/exelixis/web/software/raxml/hands_on.html)

``` r

# ----
# Data
# ----
# example DNA
dna_phy <- "10 60
Cow       ATGGCATATCCCATACAACTAGGATTCCAAGATGCAACATCACCAATCATAGAAGAACTA
Carp      ATGGCACACCCAACGCAACTAGGTTTCAAGGACGCGGCCATACCCGTTATAGAGGAACTT
Chicken   ATGGCCAACCACTCCCAACTAGGCTTTCAAGACGCCTCATCCCCCATCATAGAAGAGCTC
Human     ATGGCACATGCAGCGCAAGTAGGTCTACAAGACGCTACTTCCCCTATCATAGAAGAGCTT
Loach     ATGGCACATCCCACACAATTAGGATTCCAAGACGCGGCCTCACCCGTAATAGAAGAACTT
Mouse     ATGGCCTACCCATTCCAACTTGGTCTACAAGACGCCACATCCCCTATTATAGAAGAGCTA
Rat       ATGGCTTACCCATTTCAACTTGGCTTACAAGACGCTACATCACCTATCATAGAAGAACTT
Seal      ATGGCATACCCCCTACAAATAGGCCTACAAGATGCAACCTCTCCCATTATAGAGGAGTTA
Whale     ATGGCATATCCATTCCAACTAGGTTTCCAAGATGCAGCATCACCCATCATAGAAGAGCTC
Frog      ATGGCACACCCATCACAATTAGGTTTTCAAGACGCAGCCTCTCCAATTATAGAAGAATTA"
# example partition
simpleDNApartition <- "DNA, p1=1-30
DNA, p2=31-60"
# Save as binary files
input_file <- file.path(tempdir(), 'dna.phy')
input_connection <- file(input_file, 'wb')
write(file = input_connection, x = dna_phy)
close(input_connection)
partition_file <- file.path(tempdir(), 'simpleDNApartition.txt')
partition_connection <- file(partition_file, 'wb')
write(file = partition_connection, x = simpleDNApartition)
close(partition_connection)


# -----
# RAxML
# -----
library(outsider)
# import function
raxml <- module_import(fname = 'raxml', repo = "dombennett/om..raxml")
# create folder to host results
results_dir <- file.path(tempdir(), 'raxml_example')
dir.create(results_dir)
# run raxml
# arglist = command arguments that would have been passed to command-line
# program.
# Note: R objects are allowed in the arglist, e.g. input_file
raxml(arglist = c('-m', 'GTRGAMMA', '-p', '12345', '-q', partition_file,
                  '-s', input_file, '-n', 'T21'), outdir = results_dir)
#> 
#> WARNING: The number of threads is currently set to 0
#> You can specify the number of threads to run via -T numberOfThreads
#> NumberOfThreads must be set to an integer value greater than 1
#> 
#> RAxML, will now set the number of threads automatically to 2 !
#> 
#> 
#> This is the RAxML Master Pthread
#> 
#> This is RAxML Worker Pthread Number: 1
#> 
#> 
#> This is RAxML version 8.2.12 released by Alexandros Stamatakis on May 2018.
#> 
#> With greatly appreciated code contributions by:
#> Andre Aberer      (HITS)
#> Simon Berger      (HITS)
#> Alexey Kozlov     (HITS)
#> Kassian Kobert    (HITS)
#> David Dao         (KIT and HITS)
#> Sarah Lutteropp   (KIT and HITS)
#> Nick Pattengale   (Sandia)
#> Wayne Pfeiffer    (SDSC)
#> Akifumi S. Tanabe (NRIFS)
#> Charlie Taylor    (UF)
#> 
#> 
#> Alignment has 38 distinct alignment patterns
#> 
#> Proportion of gaps and completely undetermined characters in this alignment: 0.00%
#> 
#> RAxML rapid hill-climbing mode
#> 
#> Using 2 distinct models/data partitions with joint branch length optimization
#> 
#> 
#> Executing 1 inferences on the original alignment using 1 distinct randomized MP trees
#> 
#> All free model parameters will be estimated by RAxML
#> GAMMA model of rate heterogeneity, ML estimate of alpha-parameter
#> 
#> GAMMA Model parameters will be estimated up to an accuracy of 0.1000000000 Log Likelihood units
#> 
#> Partition: 0
#> Alignment Patterns: 20
#> Name: p1
#> DataType: DNA
#> Substitution Matrix: GTR
#> 
#> 
#> 
#> Partition: 1
#> Alignment Patterns: 18
#> Name: p2
#> DataType: DNA
#> Substitution Matrix: GTR
#> 
#> 
#> 
#> 
#> RAxML was called as follows:
#> 
#> raxmlHPC-PTHREADS-SSE3 -m GTRGAMMA -p 12345 -q simpleDNApartition.txt -s dna.phy -n T21 
#> 
#> 
#> Partition: 0 with name: p1
#> Base frequencies: 0.323 0.293 0.153 0.230 
#> 
#> Partition: 1 with name: p2
#> Base frequencies: 0.327 0.283 0.183 0.207 
#> 
#> Inference[0]: Time 0.098335 GAMMA-based likelihood -377.005373, best rearrangement setting 5
#> 
#> 
#> Conducting final model optimizations on all 1 trees under GAMMA-based models ....
#> 
#> Inference[0] final GAMMA-based Likelihood: -375.308100 tree written to file /working_dir/RAxML_result.T21
#> 
#> 
#> Starting final GAMMA-based thorough Optimization on tree 0 likelihood -375.308100 .... 
#> 
#> Final GAMMA-based Score of best tree -375.308100
#> 
#> Program execution info written to /working_dir/RAxML_info.T21
#> Best-scoring ML tree written to: /working_dir/RAxML_bestTree.T21
#> 
#> Overall execution time: 0.147280 secs or 0.000041 hours or 0.000002 days
```

### Key arguments

Some key arguments for running the RAxMl program.

| Argument | Usage    | Description                           |
| -------- | -------- | ------------------------------------- |
| m        | \-m      | Model to run, e.g. GTRGAMMA or GTRCAT |
| p        | \-p \#   | Specify seed \#                       |
| s        | \-s file | Specify input file                    |
| \#       | \-\# \#  | Specify \# iterations                 |
| n        | \-n name | Specify name of analysis              |
| q        | \-q file | Specify partition file                |

Additionally, the R interface allows a user to specify an `outdir` where
all the resulting files should be saved. By default, the `outdir` is the
current working directory.

#### Other examples: from command-line to R

##### ML

``` bash
# command line
raxmlHPC -m BINGAMMA -p 12345 -s binary.phy -# 20 -n T5
```

``` r
# R
raxml(arglist = c('-m', 'BINGAMMA', '-p', '12345', '-s', 'binary.phy', '-#',
'20', '-n', 'T5'))
```

##### Ordered morphological character matrix

``` bash
# command line
raxmlHPC -p 12345 -m MULTIGAMMA -s  multiState.phy -K ORDERED -n T12
```

``` r
# R
raxml(arglist = c('-p', '12345', '-m', 'MULTIGAMMA', '-s', 'multiState.phy',
'-K', 'ORDERED', '-n', 'T12'))
```

##### Bootstrap

``` bash
# command line
raxmlHPC -m GTRCAT -p 12345 -f b -t RAxML_bestTree.T13 -z RAxML_bootstrap.T14 \
-n T15
```

``` r
# R
raxml(arglist = c('-m', 'GTRCAT', '-p', '12345', '-f', 'b', '-t',
'RAxML_bestTree.T13', '-z', 'RAxML_bootstrap.T14', '-n', 'T15'))
```

## Links

Find out more by visiting the [RAxML’s
homepage](https://cme.h-its.org/exelixis/web/software/raxml/index.html)

## Please cite

  - A. Stamatakis: “RAxML Version 8: A tool for Phylogenetic Analysis
    and Post-Analysis of Large Phylogenies”. In Bioinformatics, 2014,
    open access.
  - Bennett et al. (2020). outsider: Install and run programs, outside
    of R, inside of R. *Journal of Open Source Software*, In
review

## <!-- Footer -->

<img align="left" width="120" height="125" src="https://raw.githubusercontent.com/AntonelliLab/outsider/master/logo.png">

**An `outsider` module**

Learn more at [outsider
website](https://antonellilab.github.io/outsider/). Want to build your
own module? Check out [`outsider.devtools`
website](https://antonellilab.github.io/outsider.devtools/).
