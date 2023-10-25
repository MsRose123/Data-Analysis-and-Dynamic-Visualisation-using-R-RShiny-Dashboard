
Folder structure :
------------------

```
├─ scripts
│  ├─ readme.md
│  ├─ scripts_hypertension
│  │  ├─ dataCleaningHypertension.R
│  │  ├─ dataTransformHypertension.R
│  │  └─ hypertensionPlots.R
│  ├─ scripts_obesity
│  │  ├─ dataCleaningObesity.R
│  │  ├─ dataTransformObesity.R
│  │  └─ obesityPlots.R

```

1. The data is first explored and cleaned using the scripts :

    - scripts/scripts_obesity/dataCleaningObesity.R and 
    - scripts/scripts_hypertension/dataCleaningHypertension.R
   
   The cleaned data is then stored to the following location :
   
      - cleanData/obesityData.csv
      - cleanData/hypertensionData.csv


2. Using the cleaned data, we run the data transfromation scripts :
    
    - scripts/scripts_obesity/dataTransformObesity.R
    - scripts/scripts_hypertension/dataTransformHypertension.R
    
    These scripts in turn generates the following csv files :
    
      - intermediates/data/obesityTransformedData.csv
      - intermediates/data/obeseProbData.csv
      - intermediates/data/obeseMaleProbData.csv
      - intermediates/data/obeseFemaleProbData.csv
      - intermediates/data/hypertensionTransformedData.csv
      - intermediates/data/hypertensionProbData.csv
      - intermediates/data/hypertensionMaleProbData.csv
      - intermediates/data/hypertensionFemaleProbData.csv
      
      
3. Using these transformed data, we generate plots by running the following scripts :

    - scripts/scripts_obesity/obesityPlots.R
    - scripts/scripts_hypertension/hypertensionPlots.R

    These scripts generates the corresponding plots and save a snapshot of the same :
    
        - results/obesity_results/fig-all.png
        - results/obesity_results/fig-male.png
        - results/obesity_results/fig-female.png
        - results/obesity_results/fig-both.png
        - results/hypertension_results/fig-all.png
        - results/hypertension_results/fig-male.png
        - results/hypertension_results/fig-female.png
        - results/hypertension_results/fig-both.png
