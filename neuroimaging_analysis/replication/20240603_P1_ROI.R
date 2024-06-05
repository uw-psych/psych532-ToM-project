# Created by Jim Treyens (jim.treyens@gmail.com) on 6/3/2024

# Introduction

# This R Script creates a dataframe for a particular participant (in this case Participant 1) containing 
#   bold data for each voxel in a specified ROI.

# The original bold data is stored in NIfTI files and is available at 
#   https://www.openfmri.org/dataset/ds000228/

# Section 1 of the script produces a four-dimensional array in R from  nii files where the first 
#   3 dimensions represent X, Y, and Z coordinates and the fourth dimension represents 168 time 
#   repetitions.  The data in the array represent intensity levels in an fMRI image
#   for each voxel location. The images contain 510340 voxel locations (79x95x68). The array
#   created contains 85737120 elements (510340 x 168 time repetions). The bold data for
#   participant 1 in this script is called P1_bold.

# Section 2 of the script produces a matrix where each row represents a voxel location
#   for a particular ROI.  Richardson et al. (2018) define multiple ROIs associated with a Theory
#   of Mind (ToM) network and with processing Pain. The ROIs are defined by collections of 
#   of contiguous voxels which are stored in HDF5 files that are available at 
#   https://www.openfmri.org/dataset/ds000228/
#   Each row in the matrix created in this section of the script represents a voxel in the target 
#   ROI. The three columns represent x, y, and z coordinates for the voxel.

# Section 3 of the script produces a matrix representing data for an ROI 
#   where each row consists of a voxel location and the 158 intensity levels associated with 
#   that location for each time repetition 11 - 168.  The first 3 columns represent the X, Y, and Z 
#   coodinates of the voxel, and then next 158 columns represent intensity levels for that
#   voxel at each of the time repetions.

# Section 4 calculates means for each TR, creates a dataframe for plotting ROIs over 
#   TRs 11-158, and creates a plot.

# Section 5 creates a dataframe for calculating correlations 
#   between ROIs, calculates correlations and p-values, then creates a plot 
#   which graphically displays correlations and p-values



# Created by Jim Treyens (jim.treyens@gmail.com) on 5/14/2024

# install.packages('BiocManager')
# BiocManager::install('rhdf5')
# install.packages("oro.nifti")
# install.packages("neurobase")
# install.packages("tidyr")
# install.packages("ggplot2")
# install.packages("Hmisc")
# install.packages("stringi", repos="http://cran.rstudio.com/", dependencies=TRUE)
# install.packages("corrplot")

library('BiocManager')
library('rhdf5')
library("oro.nifti")
library("neurobase")
library("tidyr")
library(ggplot2)
library(reshape)
library(dplyr)
library("Hmisc")
library(corrplot)

set.seed(20161007)

# SECTION 1: This sections creates a 4-dimensional array showing intensity for each voxel location
#  for 168 time repetitions as described in the introduction above.

P1_oro <- readNIfTI("/Users/jimtr/Downloads/Participant_fMRI/sub-pixar001_task-pixar_run-001_swrf_bold.nii")
class(P1_oro)
P1_bold <- slot(P1_oro, ".Data")
class(P1_bold)
dim(P1_bold)

# SECTION 2: The following section creates matrices where each row represents a voxel location associated 
#   with an ROI as described in the introduction above.  There are 6 ToM ROIs and 7 Pain Matix ROIs.
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

# SECTION 3: This section creates a subset of the full array of bold data for each ROI
# For example, the code applies the [ operator (subsetting) to the fourth dimension 
# of the P1_bold object using the indices or subset specified by ToM_RTPJ_9mm_sphere_xyz.
# TRs 1-10 are removed since during these times only title / copyright information for the film was shown.

RTPJ_b <- apply(P1_bold, 4, `[`, ToM_RTPJ_9mm_sphere_xyz)
dim(RTPJ_b)
RTPJ_b <- RTPJ_b[, -1:-10]

LTPJ_b <- apply(P1_bold, 4, `[`, ToM_LTPJ_9mm_sphere_xyz)
dim(LTPJ_b)
LTPJ_b <- LTPJ_b[, -1:-10]

PC_b <- apply(P1_bold, 4, `[`, ToM_PC_9mm_sphere_xyz)
PC_b <- PC_b[, -1:-10]
dim(PC_b)

DMPFC_b <- apply(P1_bold, 4, `[`, ToM_DMPFC_9mm_sphere_xyz)
DMPFC_b <- DMPFC_b[, -1:-10]
dim(DMPFC_b)

MMPFC_b <- apply(P1_bold, 4, `[`, ToM_MMPFC_9mm_sphere_xyz)
MMPFC_b <- MMPFC_b[, -1:-10]
dim(MMPFC_b)

VMPFC_b <- apply(P1_bold, 4, `[`, ToM_VMPFC_9mm_sphere_xyz)
VMPFC_b <- VMPFC_b[, -1:-10]
dim(VMPFC_b)

RS2_b <- apply(P1_bold, 4, `[`, Pain_RS2_9mm_sphere_xyz)
RS2_b <- RS2_b[, -1:-10]
dim(RS2_b)

LS2_b <- apply(P1_bold, 4, `[`, Pain_LS2_9mm_sphere_xyz)
LS2_b <- LS2_b[, -1:-10]
dim(LS2_b)

RInsula_b <- apply(P1_bold, 4, `[`, Pain_RInsula_9mm_sphere_xyz)
RInsula_b <- RInsula_b[, -1:-10]
dim(RInsula_b)

LInsula_b <- apply(P1_bold, 4, `[`, Pain_LInsula_9mm_sphere_xyz)
LInsula_b <- LInsula_b[, -1:-10]
dim(LInsula_b)

RMFG_b <- apply(P1_bold, 4, `[`, Pain_RMFG_9mm_sphere_xyz)
RMFG_b <- RMFG_b[, -1:-10]
dim(RMFG_b)

LMFG_b <- apply(P1_bold, 4, `[`, Pain_LMFG_9mm_sphere_xyz)
LMFG_b <- LMFG_b[, -1:-10]
dim(LMFG_b)

AMCC_b <- apply(P1_bold, 4, `[`, Pain_AMCC_9mm_sphere_xyz)
AMCC_b <- AMCC_b[, -1:-10]
dim(AMCC_b)

# SECTION 4: This section calculates means for each TR, creates a dataframe for plotting ROIs over 
#   TRs 11-158, and creates a plot

RTPJ_b_Means <- colMeans(RTPJ_b)
LTPJ_b_Means <- colMeans(LTPJ_b)
PC_b_Means <- colMeans(PC_b)
DMPFC_b_Means <- colMeans(DMPFC_b)
MMPFC_b_Means <- colMeans(MMPFC_b)
VMPFC_b_Means <- colMeans(VMPFC_b)
RS2_b_Means <- colMeans(RS2_b)
LS2_b_Means <- colMeans(LS2_b)
RInsula_b_Means <- colMeans(RInsula_b)
LInsula_b_Means <- colMeans(LInsula_b)
RMFG_b_Means <- colMeans(RMFG_b)
LMFG_b_Means <- colMeans(LMFG_b)
AMCC_b_Means <- colMeans(AMCC_b)

vecnum <- rep(1:158, times = 13)

vecROIs <- c(rep("RTPJ",158), rep("LTPJ",158), rep("PC",158), 
             rep("DMPFC",158), rep("MMPFC",158), rep("VMPFC",158),
             rep("RS2",158), rep("LS2",158), rep("RInsula",158), 
             rep("LInsula",158), rep("RMFG",158), rep("LMFG",158), 
             rep("AMCC",158))

vecROI_Means <- c(RTPJ_b_Means, LTPJ_b_Means, PC_b_Means, 
                  DMPFC_b_Means, MMPFC_b_Means, VMPFC_b_Means, 
                  RS2_b_Means, LS2_b_Means, RInsula_b_Means, 
                  LInsula_b_Means, RMFG_b_Means, LMFG_b_Means, 
    
              AMCC_b_Means)

ROI_TR <- data.frame(vecROIs, vecnum, vecROI_Means)

colnames(ROI_TR) <- c("ROIs","TR", "Activation")

ggplot(ROI_TR, aes(x=TR, y=Activation, group = ROIs, color=ROIs)) +
  geom_line(size=1)


# SECTION 5: This section creates a dataframe for calculating correlations 
#   between ROIs, calculates correlations and p-values, then creates a plot 
#   which graphically displays correlations and p-values

ROI_TR_for_cor <- data.frame(RTPJ_b_Means, LTPJ_b_Means, PC_b_Means, DMPFC_b_Means, MMPFC_b_Means, VMPFC_b_Means,
                          RS2_b_Means, LS2_b_Means, RInsula_b_Means, LInsula_b_Means, RMFG_b_Means, LMFG_b_Means, 
                          AMCC_b_Means)

colnames(ROI_TR_for_cor) <- c("RTPJ", "LTPJ", "TPC", "DMPFC", "MMPFC", "VMPFC",
                           "RS2", "LS2", "RInsula", "LInsula", "RMFG", "LMFG", 
                           "AMCC")

res2 <- rcorr(as.matrix(ROI_TR_for_cor))
res2

corrplot(res2$r, type="upper", order="original",
         p.mat = res2$P, sig.level = 0.01, insig = "blank",
         tl.col = "black", tl.srt=45, number.cex = 0.5)

