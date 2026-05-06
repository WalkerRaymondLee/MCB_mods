# MCB_mods
Repository of different versions of MCB (marine cloud brightening) mods for CESM2

This repository contains Fortran code to implement marine cloud brightening in CESM2. The appropriate set of mods are placed in the directory <case>/SourceMods/src.cam before running case.build. Each set of mods contains the following five files:

cam_diagnostics.F90
MCB_mask.F90
micro_mg2_0.F90
micro_mg_cam.F90
microp_driver.F90

The original versions of these mods were written by Jack Chen for the study "Climate Impact of Marine Cloud Brightening Solar Climate Intervention Under a Susceptibility‐Based Strategy Simulated by CESM2". Since then, several updates have been implemented, including: the capacity to modify the strategy mid-run using the namelist, a patch for a bug which caused some atmospheric columns to be excluded from the brightening routine, and a diagnostic that prints the seeding mask used each timestep as model output.

In this repository, v1 denotes the original code, and v2 denotes the code with the bug fix. Versions labeled "a" include the namelist modification, and versions labeled "b" include the diagnostic.
