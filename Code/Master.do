
/* This is the master do file for the paper 
"The Role of the Commodity Price Boom in Shaping Public Social Spending: Evidence from Latin America" 

Please insert your macros paths.
*/

clear all

*** Version 
version 15 /*insert version*/

*** output on screen
set more off
set logtype text
set linesize 255 

*** Macros for paths
global datapath "INSERT/Data and analysis/Data" /*insert your path*/
global outputpath "INSERT/Data and analysis/Results" /*insert your path*/
global syntaxpath "INSERT/Data and analysis/Code" /*insert your path*/

*** Macros for file names and output paths
global dateiname "Social_spending.dta" 
global outputname "NAME" /*insert your desired output name*/

set matsize 10000
cap log close

********************************************************************************************************************
*** Aufzeichung in Protokoll starten.
log using "$outputpfad\$outputname.log", replace

********************************************************************************************************************
********************************************************************************************************************
*** I. DATA CLEANING AND DESCRIPTION
********************************************************************************************************************
********************************************************************************************************************

do "$syntaxpath/1_data_preparation.do"
do "$syntaxpath/2_spending_graphs.do"

********************************************************************************************************************
********************************************************************************************************************
*** II. VAR ESTIMATIONS
********************************************************************************************************************
********************************************************************************************************************

cap do "$syntaxpath/3_var_level_percapita.do"
cap do "$syntaxpath/4_var_level_percent.do"
cap do "$syntaxpath/5_var_countrygraphs_paper.do"

********************************************************************************************************************
********************************************************************************************************************
*** II. LP ESTIMATIONS
********************************************************************************************************************
********************************************************************************************************************

cap do "$syntaxpath/6_local_projections.do"

