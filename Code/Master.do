
/* This is the master do file for the replication package of the paper 

"The Role of the Commodity Price Boom in Shaping Public Social Spending: Evidence from Latin America" 
published in World Development (2024), 182: 106717
by Svenja Flechtner and Martin Middelanis

https://www.sciencedirect.com/science/article/pii/S0305750X24001876 
*/

clear all

*** Version 
version 15 /*insert version*/

*** output on screen
set more off
set logtype text
set linesize 255 

*** Ado path
*sysdir set PERSONAL "H:\"
*mata mata mlib index

*** Macros for paths 
global datapath "INSERT" /* Please insert your macros paths corresponding to the folder structure you created (see readme file). */
global outputpath "INSERT" /* Please insert your macros paths corresponding to the folder structure you created (see readme file). */
global syntaxpath "INSERT" /* Please insert your macros paths corresponding to the folder structure you created (see readme file). */

*** Macros for file names
global dateiname "Social_spending.dta" 
global outputname "Protocole"  

set matsize 10000
cap log close

********************************************************************************************************************
*** Start log file.
log using "$outputpfad\$outputname.log", replace

********************************************************************************************************************
********************************************************************************************************************
*** I. DATA CLEANING
********************************************************************************************************************
********************************************************************************************************************

do "$syntaxpath/1_data_preparation.do"
do "$syntaxpath/2_spending_graphs.do"

********************************************************************************************************************
********************************************************************************************************************
*** II. MAIN RESULTS
********************************************************************************************************************
********************************************************************************************************************

do "$syntaxpath/var_level_percapita.do"
do "$syntaxpath/var_level_percent.do"
do "$syntaxpath/var_countrygraphs_paper.do"


********************************************************************************************************************
********************************************************************************************************************
*** III. ROBUSTNESS CHECKS
********************************************************************************************************************
********************************************************************************************************************

********************************************************************************************************************
*** III.1 BIVARIATE VARS
********************************************************************************************************************
do "$syntaxpath/7_bivariate_var.do"

********************************************************************************************************************
*** III.2 LOCAL PROJECTIONS
********************************************************************************************************************
do "$syntaxpath/6_local_projections.do"

********************************************************************************************************************
*** III.3 GDP AS CONTROL VARIABLE
********************************************************************************************************************
do "$syntaxpath/8_var_GDP.do"

********************************************************************************************************************
*** III.4 INTEREST RATE AS CONTROL VARIABLE
********************************************************************************************************************
do "$syntaxpath/9_var_interestrate.do"

********************************************************************************************************************
*** III.5 LEFT WING GOVERNMENT DUMMY
********************************************************************************************************************
do "$syntaxpath/10_var_lwg.do"


