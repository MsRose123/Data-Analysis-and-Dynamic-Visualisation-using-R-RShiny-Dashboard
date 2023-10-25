rule all:
    "The default rule"
    input:
        "results/obesity_results/fig-both.png",
        "results/hypertension_results/fig-both.png"

rule clean_up_data_obesity:
    "clean up raw data"
    input:
        "rawData/BMX_D.csv",
        "rawData/DEMO_D.csv"
    output: "cleanData/obesityData.csv"
    shell: """
    mkdir -p cleanData
    Rscript scripts/scripts_obesity/dataCleaningObesity.R
    """

rule clean_up_data_hypertension:
    "clean up raw data"
    input:
        "rawData/BPX_D.csv",
        "rawData/DEMO_D.csv"
    output: "cleanData/hypertensionData.csv"
    shell: """
    Rscript scripts/scripts_hypertension/dataCleaningHypertension.R
    """

rule transform_obesity:
    "Transform obesityData"
    input:
        "cleanData/obesityData.csv"
    output: 
        "intermediates/data/obesityTransformedData.csv",
        "intermediates/data/obeseProbData.csv",
        "intermediates/data/obeseMaleProbData.csv",
        "intermediates/data/obeseFemaleProbData.csv"
    shell: """
    mkdir -p intermediates/data
    Rscript scripts/scripts_obesity/dataTransformObesity.R
    """
rule transform_hypertension:
    "Transform hypertensionData"
    input:
        "cleanData/hypertensionData.csv"
    output: 
        "intermediates/data/hypertensionTransformedData.csv",
        "intermediates/data/hypertensionProbData.csv",
        "intermediates/data/hypertensionMaleProbData.csv",
        "intermediates/data/hypertensionFemaleProbData.csv"
    shell: """
    Rscript scripts/scripts_hypertension/dataTransformHypertension.R
    """

rule plot_obesity:
    "Make simple plots"
    input:
        "intermediates/data/obeseProbData.csv",
        "intermediates/data/obeseMaleProbData.csv",
        "intermediates/data/obeseFemaleProbData.csv"
    output: 
        "results/obesity_results/fig-all.png",
        "results/obesity_results/fig-male.png",
        "results/obesity_results/fig-female.png",
        "results/obesity_results/fig-both.png"
    shell: """
    mkdir -p results/obesity_results
    Rscript scripts/scripts_obesity/obesityPlots.R
    """
rule plot_hypertension:
    "Make simple plots"
    input:
        "intermediates/data/hypertensionProbData.csv",
        "intermediates/data/hypertensionMaleProbData.csv",
        "intermediates/data/hypertensionFemaleProbData.csv"
    output: "results/hypertension_results/fig-all.png",
            "results/hypertension_results/fig-male.png",
            "results/hypertension_results/fig-female.png",
            "results/hypertension_results/fig-both.png"
    shell: """
    mkdir -p results/hypertension_results
    Rscript scripts/scripts_hypertension/hypertensionPlots.R
    """

rule shiny_web_app:
    "Visualisation using shiny web app"
    input:
        "intermediates/data/obesityTransformedData.csv",
        "intermediates/data/obeseProbData.csv",
        "intermediates/data/obeseMaleProbData.csv",
        "intermediates/data/obeseFemaleProbData.csv",
        "intermediates/data/hypertensionTransformedData.csv",
        "intermediates/data/hypertensionProbData.csv",
        "intermediates/data/hypertensionMaleProbData.csv",
        "intermediates/data/hypertensionFemaleProbData.csv"

    shell: """
    Rscript -e 'shiny::runApp("app.R",port=8889,host="0.0.0.0")'
    """

rule clean:
    "Clean up"
    shell: """
    if [ -d cleanData ]; then
      rm -r cleanData
    else
      echo directory cleanData does not exist
    fi
    if [ -d intermediates ]; then
      rm -r intermediates
    else
      echo directory intermediates does not exist
    fi
    if [ -d results ]; then
      rm -r results
    else
      echo directory results does not exist
    fi
    """
