# ---
# jupyter:
#   jupytext:
#     formats: ipynb,R:light
#     text_representation:
#       extension: .R
#       format_name: light
#       format_version: '1.5'
#       jupytext_version: 1.16.1
#   kernelspec:
#     display_name: R [conda env:r-env]
#     language: R
#     name: conda-env-r-env-r
# ---

# This script downloads our Theory of Mind behavioral dataset from OSF, and deposits in the folder ../behavioral_data. 

library(readxl)
library(dplyr) 
library(osfr)
library(tidyverse)

download_path <- '../behavioral_data'

# +
download_data <- function(osf_url, download_path) { 
    #wrapper func for downloading data from osf
    results <- osf_retrieve_file(osf_url) %>%
               osf_download(conflicts="skip", 
                       path=download_path) 

    print('Downloading data from: ') 
    print(osf_url)
    return(results)
    } 



# +
download_path <- '../behavioral_data'

book1_file <- download_data("https://osf.io/9cbty" , download_path)

boot2_file <- download_data("https://osf.io/ah258", download_path)  


# +
tom_df <- book1_file %>% pull(local_path)  %>% 
    read_excel(sheet='Data') %>%
    rename('include' ='Include?',
           'exp_error'='Exp Error?', 
           'answer'='Answer (0 /1)', 
           'concept_super'='Concept-super') %>% 
    write.csv(file.path(download_path, 'booklet_data.csv')) 

participant_df <- boot2_file %>% pull(local_path)  %>% 
    read_excel(sheet='Participant Info') %>% 
    write.csv(file.path(download_path, 'participant_info.csv')  ) 
# -


