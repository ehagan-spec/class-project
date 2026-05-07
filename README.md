# class-project
#Elizabeth Hagan

#**Overview of repository**

This repository contains information about my final-term project for the linear regression class. It contains a data package file, a codebook, an R script, plots, R outputs and a transparency plan.


#**Project description:**
The project seeks to explore whether people's perception of climate change as a serious global problem influences their adoption of pro-climate behaviours.

# **Dataset used:**

The dataset from this project was sourced from the Inter-university Consortium for Political and Social Research (ICPSR), specifically Eurobarometer 83.4: Climate Change, Biodiversity, and ICPSR 36403 Discrimination of Minority Groups, May-June 2015
https://www.icpsr.umich.edu/web/ICPSR/studies/36403/datadocumentation#


#**Variables used for this project:**

**Dependent Variables**
Perceived climate change severity, measured by QA2: "How serious a problem do you think climate change is at this moment?" rated on a 10-point scale from 1 ('not at all a serious problem') to 10 ('an extremely serious problem') and a separate code for "Don't know" (11). 

Pro-environmental behavioural adoption, operationalised using the QA6 eleven-item behavioural battery (QA6_1 to QA6_11), which are specific pro-climate actions taken. Higher scores reflect a greater breadth of self-reported pro-environmental actions.

**Independent Variables**
Political ideology self-placement (RQ1): measured by D1, a 10-point left-right scale where 1 represents the far left and 10 represents the far right. Refusals and 'Don't Know' responses are excluded from analytical models.

Perceived climate change severity variable: the outcome of RQ1 and the primary predictor in RQ2, forming a sequential predictive chain between ideology, perception, and behaviour.

Attribution of personal responsibility for climate action (RQ3) is derived from QA3, a multiple-response item in which respondents may select any combination of six actors — the EU, national governments, regional and local authorities, environmental groups, business and industry, and 'you personally.' For this study, respondents who selected 'you personally' will be coded 1, and all others, 0. 

Social class is measured using D63, which asks respondents to self-identify their social class on a five-point ordinal scale ranging from 1 (working class) to 5 (higher class). The variable is treated as continuous in the regression models, with higher values indicating higher social class. Respondents who selected "other", "refusal", or "don't know" were recoded to missing and excluded from the analysis.

Country fixed effects are captured through a set of 29 binary dummy variables, one for each country in the sample, with Belgium (country code 1) serving as the reference category. Each dummy variable takes the value of 1 if the respondent belongs to that country and 0 otherwise.


#**Repository structure**

├── data/                         # Dataset for the project
│   └── 36403-0001-Data.rda      # Eurobarometer 83.4 raw data
│
├── codebook/                    # Variable documentation
│   └── 36403-0001-Codebook.pdf  # ICPSR codebook
│
├── scripts/                     # R scripts
│
├── plots/                       # R generated plots
│
├── outputs/                     # R model outputs
│
├── README.md                    # Project overview and instructions
│
└── AI-DISCLAIMER                # AI tool usage


#**Transparency plan:**

This repository is consistent with scientific transparency and reproducibility.

1. Open Science Framework (OSF): Integrates GitHub to enhance transparency and collaboration
2. Complete Documentation: Every step of the analysis is documented. Hypothesis and assumptions are clearly stated, and the rationale for the choice of methodology is provided
3. Version Control: All changes are tracked through Git
4. Data Transparency: Data sources are clearly cited, and data analysis steps are well described
5. Data reproducibility: All codes needed to reproduce this project are included with instructions on how to run the codes.

**AI tool usage**

AI was used to help generate some of the R codes.

#**Contact**

Send questions or feedback using an issue.
