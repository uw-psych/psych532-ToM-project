# psych532-ToM-project

## This repository contains the code for PSYCH532 2024 project.
#### Group members: Ziqi Guo, McKenzie Hagen, Jim Treyens, Carol Lu, and Lydia Zhang

Final Paper: https://docs.google.com/document/d/1mkGuuGTrHH3jCldSWTKPC__d6-hZR_dNgtwaCimyERw/edit?usp=sharing

Our project was divided into two arms: a behavioral analysis of gender differences in a novel Theory of Mind (ToM) task, and an analysis of associated functional MRI (fMRI) data from the same participants. 

**Behavioral Analysis**

Data located in `psych532-ToM-project/behavioral_data`

  'ToMBooklet1_gender.csv' contains unique subject identifiers and the participant's gender for participants who received ToM Booklet 1.
  
  'ToMBooklet1-Data.csv' contains unique subject identifiers and all of the participant's answers for each of the questions of ToM Booklet 1.
  
  'ToMBooklet2_gender.csv' contains unique subject identifiers and the participant's gender for participants who received ToM Booklet 2.
  
  'ToMBooklet2-Data.csv' contains unique subject identifiers and all of the participant's answers for each of the questions of ToM Booklet 2.

Analyses located in `psych532-ToM-project/behavioral_analysis`

  '00_download_booklet.R' contains code to download the data directly from Open Science Framework (OSF).
  
  '02_behavioral_differences.Rmd' contains code to analyze Booklet 2 data by individual question and question cluster. Summary statistics and gender differences are calculated. Group-level visualizations are created here.
  
  'forloop_TOM_gender.rmd' contains code to analyze gender differences for each specific age.
  
  'tom_bk1_analysis.rmd' contains all of the relevant code for analyzing Booklet 1, including group-level summary statistics and gender differences (for both individual questions and question clusters), as well as summary statistics and gender differences for each individual age. Age-specific visualizations are created here.
  
  'tom_bk2_analysis.rmd' contains all of the relevant code for analyzing Booklet 2, including group-level summary statistics and gender differences (for both individual questions and question clusters), as well as summary statistics and gender differences for each individual age. Age-specific visualizations are created here.

Additional information about the analyses conducted can be found in the comments of each .Rmd script.

**Neuroimaging Analysis**
Replication analysis located in `psych532-ToM-project/neuroimaging_replication`
Extension analysis located in `psych532-ToM-project/neuroimaging_extension` 

Data located: TODO

Analysis specific READMEs can be found in each folder. 
