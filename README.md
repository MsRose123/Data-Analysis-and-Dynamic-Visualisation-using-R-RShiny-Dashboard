## Data Analysis and Dynamic Visualisation using R and RShiny Dashboard

The aim of the project is to visualise lifestyle disease such as obesity and hypertension along with age and sex in a particular population. The population studied here is adult population from data gathered by National Health and Nutrition Examination Survey (NHANES) for the year 2005-2006. 

The NHANES is a program that studies the health and nutrition status of adults and children in the United States. The survey combines interviews and physical examinations which records demographic, socioeconomic, health related, medical, dental, psychological data as well as laboratory test data. The survey examines and records data from a sample of about 5,000 people which yearly represents the nation.

The datasets we have used in our analysis include Body Measures, Blood Pressure and Demographic Variables & Sample Weights for the year 2005-2006.

The application can be run using the shell script executable.sh
Run this on command line :

        $./executable.sh
	
RShiny Dashboard Developed:
------------------------------------
<img width="500" alt="image" src="https://github.com/MsRose123/Data-Analysis-and-Dynamic-Visualisation-using-R-and-RShiny-Dashboard/assets/19874942/7b9a0334-d87c-4a2c-8033-5add5378bc9e">

Raw Data used :
---------------
1.	Body Measures (BMX_D.csv)
2.	Blood Pressure (BPX_D.csv)
3.	Demographic Variables & Sample Weights (DEMO_D.csv)

The datasets used can be found at the following links :
1.	https://wwwn.cdc.gov/nchs/nhanes/search/datapage.aspx?Component=Examination&CycleBeginYear=2005
2.	https://wwwn.cdc.gov/nchs/nhanes/search/datapage.aspx?Component=Demographics&CycleBeginYear=2005

Steps involved in the data visualisation process :
--------------------------------------------------
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

Shiny Web Application
----------------------

I have used Shiny framework to create dynamic data visualisation of data. The coding is done in R programming language. 
The app.R file contains the code for this.

The web application is hosted on localhost with port 8888. The application takes two inputs from user :
                                                                                -------------

1.	Association between :

          Choices :
            1.	Obesity and Age
            2.	Hypertension and Age
2.   Gender :

		      Choices :
            1.	All
            2.	Male
            3.	Female
            4.	Both

Based on the inputs provided the application renders the plots and corresponding table. 


For Example, if he inputs are, 

1.	Obesity and Age
2.	All

The application loads the graph for Obesity against age for all and displays a table of values.



Directory structure before running the pipeline:
------------------------------------------------

```
AHDS_assessment2_2332635
├─ .git
├─ .gitignore
├─ .snakemake
├─ Snakefile
├─ README.md
├─ rawData
│  ├─ README.md
│  ├─ BMX_D.csv
│  ├─ BPX_D.csv
│  └─ DEMO_D.csv
├─ environment.yml
├─ app.R
├─ executable.sh
├─ scripts
│  ├─ README.md
│  ├─ scripts_hypertension
│  │  ├─ dataCleaningHypertension.R
│  │  ├─ dataTransformHypertension.R
│  │  └─ hypertensionPlots.R
│  └─ scripts_obesity
│     ├─ dataCleaningObesity.R
│     ├─ dataTransformObesity.R
│     └─ obesityPlots.R
├─ directoryStructure_before.png
├─ directoryStructure_after.png
└─ dag.png

```

Directory structure after running the pipeline:
------------------------------------------------

```
AHDS_assessment2_2332635
├─ .git
├─ .gitignore
├─ .snakemake
├─ Snakefile
├─ README.md
├─ rawData
│  ├─ README.md
│  ├─ BMX_D.csv
│  ├─ BPX_D.csv
│  └─ DEMO_D.csv
├─ cleanData
│  ├─ hypertensionData.csv
│  └─ obesityData.csv
├─ environment.yml
├─ intermediates
│  └─ data
│     ├─ hypertensionFemaleProbData.csv
│     ├─ hypertensionMaleProbData.csv
│     ├─ hypertensionProbData.csv
│     ├─ hypertensionTransformedData.csv
│     ├─ obeseFemaleProbData.csv
│     ├─ obeseMaleProbData.csv
│     ├─ obeseProbData.csv
│     └─ obesityTransformedData.csv
├─ results
│  ├─ hypertension_results
│  │  ├─ fig-all.png
│  │  ├─ fig-both.png
│  │  ├─ fig-female.png
│  │  └─ fig-male.png
│  └─ obesity_results
│     ├─ fig-all.png
│     ├─ fig-both.png
│     ├─ fig-female.png
│     └─ fig-male.png
├─ app.R
├─ executable.sh
├─ scripts
│  ├─ README.md
│  ├─ scripts_hypertension
│  │  ├─ dataCleaningHypertension.R
│  │  ├─ dataTransformHypertension.R
│  │  └─ hypertensionPlots.R
│  └─ scripts_obesity
│     ├─ dataCleaningObesity.R
│     ├─ dataTransformObesity.R
│     └─ obesityPlots.R
├─ directoryStructure_before.png
├─ directoryStructure_after.png
└─ dag.png

```

We can see that the folders cleanData, intermediates and results and its contents are created by the pipeline.

The other files in the directory :
-----------------------------------
1. The dag.png file represents the processes involved in the data visualisation process.

rawData -> cleanData -> intermediates -> results

2. environment.yml

This file contains all the dependencies and packages used in the entire project. The environment created by loading this file will act as a global environment containing all the dependecies specified.

3. This folder stores the dynamic web application created using shiny framework.

    refer to the corresponding readme.md file for further details
    
4. The project is version controlled using git and the relevant details can be found in .git file. The .gitignore file is used to specift the files that need not be tracked by git and I have included history files and session data files in this.

5. The .snakemake file contains the logs and related data about the processing of snakemake pipelines.

6. The Snakefile contains the rules to run the snakemake pipeline.

    I have added 9 rules in the snakefile for pipelining purpose.
    
        - all
        - clean_up_data_obesity
        - clean_up_data_hypertension
        - transform_obesity
        - transform_hypertension
        - plot_obesity
        - plot_hypertension
        - shiny_web_app
        - clean


Pipelining - Snakemake :
------------------------

The data visualisation process is automated using snakemake pipelines (run the commands in activated conda environments):

1. The following command is used to run the pipeline and this creates the following folders and the files contained in it :
    
    rawData -> cleanData -> intermediates -> results
    
  $ snakemake -cl


2. The clean rule is used to clean the directory of the files and folders generated by the snakemake pipeline :


  $ snakemake -cl clean

3. To run the Shiny web application for dynamic data visualisation 
  
    1. Fist run the snakemake pipeline that generateds the required files and folders 
    
          $ snakemake -cl
          
    2. Then run the snakemake rule for the web app
    
         $ snakemake -cl shiny_web_app
         
         
         
Git Version controlled 
----------------------


The following commands are used to version control using git :
(given git is already installed)

1. git init - to initialise a local git repository
2. git add . - to add all the files to be tracked by git
3. git commit -m "comments" - to commit the files and changes to staging area.
4. git push -u origin main

Increase the global Git buffer size to the largest individual file size
Optional: git config http.postBuffer 157286400 

Visual Studio Code and RStudio :
--------------------------------

Used to :

  1. create and run the scripts
  2. resolve merge conflicts
  3. revert changes whenever necessary
  

Set up Snakemake pipeline :
---------------------------------

- Install conda, python, R and snakemake

- confirm the installation from the directory AHDS_assessment2_2332635 :

    $which R 
    $which python
    $wnich conda
    
    The following commands will give the path where these are installed (if installations are run propoerly)

- conda might need to you to go to base directory (the case with me). Use the following command to open source in terminal :

      $source $HOME/miniconda3/bin/activate
      
      - or activate the conda base using :
      
          $conda activate base
      
- create environment.yml file and add the necessary dependency and sources

      $conda env create -f environment.yml

- activate the project conda environment

      $conda activate AHDS_assessment2_2332635
    
- create a file Snakemake and write the rules inside. To run the snakeamke file first install and activate snakemake in the folder :

      $conda install -c conda-forge -c bioconda snakemake
      
- to deactivate the conda environment

      $conda deactivate AHDS_assessment2_2332635

- once everything is run and the conda enironment is deactivated, you can activate the conda environment by simply running

      $conda activate AHDS_assessment2_2332635
    
All the commands given above are to be run in the terminal in the project directory.

Running Shiny Web Application
------------------------------

The following command can be use to run the app from terminal (as specified in snakefile):

    $Rscript -e 'shiny::runApp("app.R",port=8889,host="0.0.0.0")'

- Please copy and paste the listening port to browser and wait a minute for the application to fully load.
- if the Shiny Web application is not getting loaded in localhost. Please try running it in browser.

Notes and Investigations :
--------------------------

- The 8 static images can be generated by running the pipeline with command - $snakemake -cl
- The web application can be generated by running the command - $snakemake -cl shiny_web_app
- One the listening port for shiny app is pasted in browser, it is taking more than few second to load fully.

