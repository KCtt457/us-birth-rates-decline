# Declining Birth rates in the US: An Analysis of Potential Factors

This repo contains the code and data to produce 1) a paper which is a reproduction of [Kearney, Levine and Pardue (2022) 's paper, "The Puzzle of Falling US Birth Rates since the Great Recession"](https://www.aeaweb.org/articles?id=10.1257/jep.36.1.151) and 2) replications of the figures 1, 2a, 2b, 2d, 2e and 5 of this paper. 

It is organised as follows:

inputs
- data - contains all the data files to be used for analysis and in the tables and figures.
  - agecomp-seer.dta - data for figure 5 
  - fig_1.csv - data for figure 1
  - figs_1_2_3.csv - data for figures 1, 2a, 2b, 2d, 2e
  - figs_2a_2b.csv - data for figures 2a and 2b
  - nchs_cohort_analysis.dta. - data for figure 5
- literature
  - jep.36.1.151.pdf - the original paper of which we make a reproduction.

outputs
- paper
  - paper.pdf - the reproduction paper
  - paper.Rmd - R markdown file to produce paper.pdf
  - references.bib - reference list for paper.pdf

replication
- plots - stores the replicated figures.
  - figure1.png
  - figure2a.png
  - figure2b.png
  - figure2d.png
  - figure2e.png
  - figure5.png
- scripts - stores the code to replicate each of the figures.
  - fig1_replication.R
  - fig2a_replication.R
  - fig2b_replication.R
  - fig2d_replication.R
  - fig2e_replication.R
  - fig5_replication.R

To reproduce the paper, knit to pdf paper.Rmd found at outputs/paper/paper.Rmd.

To replicate a figure, run the corresponding R file stored in replication/scripts/fig{number}\_replication.R. The output will be saved as an image in replication/plots/figure{number}.png .

The replication on the Social Science Reproduction Platform can be found at https://doi.org/10.48152/ssrp-srs6-t802 .

