# ---
# jupyter:
#   jupytext:
#     formats: ipynb,py:light
#     text_representation:
#       extension: .py
#       format_name: light
#       format_version: '1.5'
#       jupytext_version: 1.15.2
#   kernelspec:
#     display_name: fc_w_datalad
#     language: python
#     name: env
# ---

# Code repurposed from other project to download and parcellate data from a datalad dataset. 
#
# Assumes datalad dataset at defined path, and setup to run in parallel with control script and args.  

# +
import nilearn

from nilearn import datasets
from nilearn.input_data import NiftiMasker, NiftiLabelsMasker

import nibabel as nib

import argparse

import datalad.api as dl

from glob import glob

import sys
import os 
import os.path as op
# -


#to access git-annex, add env bin to $PATH
#add to jupyter kernel spec to get rid of this line
os.environ["PATH"] = "/global/homes/m/mphagen/miniconda3/envs/fc_w_datalad/bin:" + os.environ["PATH"]

# +
args = argparse.Namespace(verbose=False, verbose_1=False)

parser = argparse.ArgumentParser("extract_timeseries.py")
parser.add_argument('--subject_id',  default='sub-pixar001') 
parser.add_argument('--atlas_name', default='schaefer')
parser.add_argument('--n_rois', default=100)
parser.add_argument('--resolution_mm', default=1) #I don't remember where I got this #
parser.add_argument('--yeo_networks', default=7)

#hack argparse to be jupyter friendly AND cmdline compatible
try: 
    os.environ['_']
    args = parser.parse_args()
except KeyError: 
    args = parser.parse_args([])

subject_id = args.subject_id
atlas_name = args.atlas_name
n_rois = args.n_rois
resolution_mm = args.resolution_mm
yeo_networks = args.yeo_networks

print(args)
# +
fc_data_path = '/pscratch/sd/m/mphagen/ds000228-fmriprep/'
results_path = op.join(fc_data_path, 'derivatives', 
                       f'fc_{atlas_name}-{n_rois}_timeseries', 
                       f'{subject_id}')

os.makedirs(results_path, exist_ok=True)

rest_scans = glob(op.join(fc_data_path, 
                          subject_id, 'func', 
                          '*MNI152NLin2009cAsym_res-2_desc-preproc_bold.nii.gz'))

print(f"Found {len(rest_scans)} rest scans for subject {subject_id}") 

# +
#add elif here for other atlas choice
if atlas_name == 'schaefer': 
    schaefer = datasets.fetch_atlas_schaefer_2018(n_rois,yeo_networks,resolution_mm)
    atlas = schaefer['maps']

masker = NiftiLabelsMasker(labels_img=atlas, standardize='zscore_sample')


# -

def parcellate_data(file):     
   
    dl.get(file, dataset='/pscratch/sd/m/mphagen/ds000228-fmriprep/')
    
    data = nib.load(file)
    
    time_series = masker.fit_transform(data)
    
    dl.drop(file, dataset='/pscratch/sd/m/mphagen/ds000228-fmriprep/')
    
    os.makedirs(op.join(results_path), exist_ok=True)
    time_series.tofile(op.join(results_path, 
                               f'{subject_id}_{atlas_name}-{n_rois}_task-pixar_timeseries.csv'), 
                        sep = ',')
    return time_series


for file in rest_scans: 
    parcellate_data(file)  
