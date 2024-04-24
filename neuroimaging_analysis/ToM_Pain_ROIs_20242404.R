# This R Script loads voxel locations for ToM network and Pain matrix ROIs from Richardson et al (2018). 
# The original data is stored in HDF5 files and is available at https://www.openfmri.org/dataset/ds000228/
# Each row in the matrices created in R represents a voxel in the target ROI.
# The three columns represent x, y, and z coordinates for the voxel.

# Created by Jim Treyens (jtreyens@gmail.com) on 4/24/2024

# install.packages('BiocManager')
# BiocManager::install('rhdf5')
library('BiocManager')
library('rhdf5')
ToM_RTPJ_9mm_sphere_xyz      <- h5read('/Users/jimtr/Downloads/ROIs/RTPJ_9mm_sphere_xyz.mat', 'roi_XYZ')
ToM_LTPJ_9mm_sphere_xyz      <- h5read('/Users/jimtr/Downloads/ROIs/LTPJ_9mm_sphere_xyz.mat', 'roi_XYZ')
ToM_PC_9mm_sphere_xyz        <- h5read('/Users/jimtr/Downloads/ROIs/PC_9mm_sphere_xyz.mat', 'roi_XYZ')
ToM_DMPFC_9mm_sphere_xyz     <- h5read('/Users/jimtr/Downloads/ROIs/DMPFC_9mm_sphere_xyz.mat', 'roi_XYZ')
ToM_MMPFC_9mm_sphere_xyz     <- h5read('/Users/jimtr/Downloads/ROIs/MMPFC_9mm_sphere_xyz.mat', 'roi_XYZ')
ToM_VMPFC_9mm_sphere_xyz     <- h5read('/Users/jimtr/Downloads/ROIs/VMPFC_9mm_sphere_xyz.mat', 'roi_XYZ')
Pain_RS2_9mm_sphere_xyz      <- h5read('/Users/jimtr/Downloads/ROIs/RS2_9mm_sphere_xyz.mat', 'roi_XYZ')
Pain_LS2_9mm_sphere_xyz      <- h5read('/Users/jimtr/Downloads/ROIs/LS2_9mm_sphere_xyz.mat', 'roi_XYZ')
Pain_RInsula_9mm_sphere_xyz  <- h5read('/Users/jimtr/Downloads/ROIs/RInsula_9mm_sphere_xyz.mat', 'roi_XYZ')
Pain_LInsula_9mm_sphere_xyz  <- h5read('/Users/jimtr/Downloads/ROIs/LInsula_9mm_sphere_xyz.mat', 'roi_XYZ')
Pain_RMFG_9mm_sphere_xyz     <- h5read('/Users/jimtr/Downloads/ROIs/RMFG_9mm_sphere_xyz.mat', 'roi_XYZ')
Pain_LMFG_9mm_sphere_xyz     <- h5read('/Users/jimtr/Downloads/ROIs/LMFG_9mm_sphere_xyz.mat', 'roi_XYZ')
Pain_AMCC_9mm_sphere_xyz     <- h5read('/Users/jimtr/Downloads/ROIs/AMCC_9mm_sphere_xyz.mat', 'roi_XYZ')