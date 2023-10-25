#!/bin/bash

#source $HOME/miniconda3/bin/activate

# Enter the base conda environment and make sure it is up to date
conda activate base
conda update -n base -c defaults conda

# Create the conda environment
conda env create -f environment.yml

# To activate the conda environment
conda activate AHDS_assessment2_2332635

#clean the pipeline
snakemake -c1 clean

# pipeline for static data visualisatin
snakemake -c1

# pipeline for dynamic data visualisatin
snakemake -c1 shiny_web_app
