********************************************************************************
*************************** ARGENTINA ******************************************
********************************************************************************

/*******************************************************************************
**  LP per capita estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==1
keep if year <= 2019
tsset year
gen t = _n

summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percapita_education_NFPS)
gen sp2 = log(percapita_health_NFPS)
gen sp3 = log(percapita_socialprot_NFPS)


foreach var in cp1 sp1 sp2 sp3 { 

  quietly gen b`var' = .
  quietly gen up95b`var' = .
  quietly gen lo95b`var' = .
  
} 

gen h = t-1   /* h is the horizon for the IRFs */

local p = 1
local q = 1  /* q = 0 corresponds to recursiveness assumption, q = 1 is less restrictive */


global shock cp1 

 forvalues i = 0/12 {

 foreach var in sp1 sp2 sp3 {

     newey F`i'.`var' L(0/`p').$shock  L(`q'/`p').sp1 L(`q'/`p').sp2 L(`q'/`p').sp3, lag(`=`i' + 1')

     gen b`var'h`i' = _b[$shock] 
	 
	 boottest $shock, boottype(wild) stat(t) l(90) reps(500) seed(100) nograph  //r

     matrix se`var'h`i' = r(CI) 
  
     quietly replace b`var' = b`var'h`i' if h==`i' 
     quietly replace up95b`var' = se`var'h`i'[1,2] if h==`i' 
	 quietly replace lo95b`var' = se`var'h`i'[1,1] if h==`i' 
	
  } 
}

/*
set graphics off
foreach var in sp1 sp2 sp3 { 
local labtext : variable label `var'
tw (rarea up95b`var' lo95b`var' h, bcolor(gs14) clw(medthin medthin)) ///
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=10, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
 }
set graphics on
*/


forval i=1/1{
local p = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
}

foreach var in sp1{
tw (rarea up95b`var' lo95b`var' h, bcolor(gs14) clw(medthin medthin)) ///
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=10, graphregion(color(white)) ///
  xtitle("") ytitle(`labtext') xtitle("Time horizon (years)") subtitle("Education - Per capita, USD", nobox) legend(off) 
  graph save "$outputpath/LP_Graphs/`label'_LP_pc_education.gph", replace
}

foreach var in sp2{
tw (rarea up95b`var' lo95b`var' h, bcolor(gs14) clw(medthin medthin)) ///
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=10, graphregion(color(white)) ///
  xtitle("") ytitle(`labtext') xtitle("Time horizon (years)") subtitle("Health - Per capita, USD", nobox) legend(off) 
  graph save "$outputpath/LP_Graphs/`label'_LP_pc_health.gph", replace
}

foreach var in sp3{
tw (rarea up95b`var' lo95b`var' h, bcolor(gs14) clw(medthin medthin)) ///
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=10, graphregion(color(white)) ///
  xtitle("") ytitle(`labtext') xtitle("Time horizon (years)") subtitle("Social Protection - Per capita, USD", nobox) legend(off) 
  graph save "$outputpath/LP_Graphs/`label'_LP_pc_socialprot.gph", replace
}

/*
graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Argentina levels pc")  name(ramey, replace) ///
note("Upper Left: Education, NFPS; Upper right: Health, NFPS; Lower left: Social Protection, NFPS.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Argentina_PC_lv_l1_l1.pdf", name(ramey) replace
*/

/*******************************************************************************
**  LP percentage of GDP estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==1
keep if year <= 2019
tsset year
gen t = _n

summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percent_education_NFPS)
gen sp2 = log(percent_health_NFPS)
gen sp3 = log(percent_socialprot_NFPS)


foreach var in cp1 sp1 sp2 sp3 { 

  quietly gen b`var' = .
  quietly gen up95b`var' = .
  quietly gen lo95b`var' = .
  
} 

gen h = t-1   /* h is the horizon for the IRFs */


local p = 1
local q = 1  /* q = 0 corresponds to recursiveness assumption, q = 1 is less restrictive */


global shock cp1 

 forvalues i = 0/12 {

 foreach var in sp1 sp2 sp3 {

     newey F`i'.`var' L(0/`p').$shock  L(`q'/`p').sp1 L(`q'/`p').sp2 L(`q'/`p').sp3, lag(`=`i' + 1')

     gen b`var'h`i' = _b[$shock] 
	 
	 boottest $shock, boottype(wild) stat(t) l(90) reps(500) seed(100) nograph  //r

     matrix se`var'h`i' = r(CI) 
  
     quietly replace b`var' = b`var'h`i' if h==`i' 
     quietly replace up95b`var' = se`var'h`i'[1,2] if h==`i' 
	 quietly replace lo95b`var' = se`var'h`i'[1,1] if h==`i' 
	
  } 
}

forval i=1/1{
local p = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
}

foreach var in sp1{
tw (rarea up95b`var' lo95b`var' h, bcolor(gs14) clw(medthin medthin)) ///
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=10, graphregion(color(white)) ///
  xtitle("") ytitle(`labtext') xtitle("Time horizon (years)") subtitle("Education - % of GDP", nobox) legend(off) 
  graph save "$outputpath/LP_Graphs/`label'_LP_percent_education.gph", replace
}

foreach var in sp2{
tw (rarea up95b`var' lo95b`var' h, bcolor(gs14) clw(medthin medthin)) ///
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=10, graphregion(color(white)) ///
  xtitle("") ytitle(`labtext') xtitle("Time horizon (years)") subtitle("Health - % of GDP", nobox) legend(off) 
  graph save "$outputpath/LP_Graphs/`label'_LP_percent_health.gph", replace
}

foreach var in sp3{
tw (rarea up95b`var' lo95b`var' h, bcolor(gs14) clw(medthin medthin)) ///
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=10, graphregion(color(white)) ///
  xtitle("") ytitle(`labtext') xtitle("Time horizon (years)") subtitle("Social Protection - % of GDP", nobox) legend(off) 
  graph save "$outputpath/LP_Graphs/`label'_LP_percent_socialprot.gph", replace
}

/*
set graphics off
foreach var in sp1 sp2 sp3 { 
local labtext : variable label `var'
tw (rarea up95b`var' lo95b`var' h, bcolor(gs14) clw(medthin medthin)) ///
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=10, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Argentina Level %")  name(ramey, replace) ///
note("Upper Left: Education, NFPS; Upper right: Health, NFPS; Lower left: Social Protection, NFPS.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Argentina_Ptg_lv_l1.pdf", name(ramey) replace
*/

********************************************************************************
***************************** BOLIVIA ******************************************
********************************************************************************

/*******************************************************************************
**  LP per capita estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==2
keep if year <= 2019
tsset year
gen t = _n

summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percapita_education_CG)
gen sp2 = log(percapita_health_CG)
gen sp3 = log(percapita_socialprot_CG)


foreach var in cp1 sp1 sp2 sp3 { 

  quietly gen b`var' = .
  quietly gen up95b`var' = .
  quietly gen lo95b`var' = .
  
} 

gen h = t-1   /* h is the horizon for the IRFs */


local p = 1
local q = 1  /* q = 0 corresponds to recursiveness assumption, q = 1 is less restrictive */


global shock cp1 

 forvalues i = 0/12 {

 foreach var in sp1 sp2 sp3 {

     newey F`i'.`var' L(0/`p').$shock  L(`q'/`p').sp1 L(`q'/`p').sp2 L(`q'/`p').sp3, lag(`=`i' + 1')

     gen b`var'h`i' = _b[$shock] 
	 
	 boottest $shock, boottype(wild) stat(t) l(90) reps(500) seed(100) nograph  //r

     matrix se`var'h`i' = r(CI) 
  
     quietly replace b`var' = b`var'h`i' if h==`i' 
     quietly replace up95b`var' = se`var'h`i'[1,2] if h==`i' 
	 quietly replace lo95b`var' = se`var'h`i'[1,1] if h==`i' 
	
  } 
}

forval i=2/2{
local p = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
}

foreach var in sp1{
tw (rarea up95b`var' lo95b`var' h, bcolor(gs14) clw(medthin medthin)) ///
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=10, graphregion(color(white)) ///
  xtitle("") ytitle(`labtext') xtitle("Time horizon (years)") subtitle("Education - Per capita, USD", nobox) legend(off) 
  graph save "$outputpath/LP_Graphs/`label'_LP_pc_education.gph", replace
}

foreach var in sp2{
tw (rarea up95b`var' lo95b`var' h, bcolor(gs14) clw(medthin medthin)) ///
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=10, graphregion(color(white)) ///
  xtitle("") ytitle(`labtext') xtitle("Time horizon (years)") subtitle("Health - Per capita, USD", nobox) legend(off) 
  graph save "$outputpath/LP_Graphs/`label'_LP_pc_health.gph", replace
}

foreach var in sp3{
tw (rarea up95b`var' lo95b`var' h, bcolor(gs14) clw(medthin medthin)) ///
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=10, graphregion(color(white)) ///
  xtitle("") ytitle(`labtext') xtitle("Time horizon (years)") subtitle("Social Protection - Per capita, USD", nobox) legend(off) 
  graph save "$outputpath/LP_Graphs/`label'_LP_pc_socialprot.gph", replace
}

/*
set graphics off
foreach var in sp1 sp2 sp3 { 
local labtext : variable label `var'
tw (rarea up95b`var' lo95b`var' h, bcolor(gs14) clw(medthin medthin)) ///
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=10, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Bolivia levels pc")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Bolivia_PC_lv_l1.pdf", name(ramey) replace
*/

/*******************************************************************************
**  LP percentage of GDP estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==2
keep if year <= 2019
tsset year
gen t = _n

summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percent_education_CG)
gen sp2 = log(percent_health_CG)
gen sp3 = log(percent_socialprot_CG)


foreach var in cp1 sp1 sp2 sp3 { 

  quietly gen b`var' = .
  quietly gen up95b`var' = .
  quietly gen lo95b`var' = .
  
} 

gen h = t-1   /* h is the horizon for the IRFs */


local p = 1
local q = 1  /* q = 0 corresponds to recursiveness assumption, q = 1 is less restrictive */


global shock cp1 

 forvalues i = 0/12 {

 foreach var in sp1 sp2 sp3 {

     newey F`i'.`var' L(0/`p').$shock  L(`q'/`p').sp1 L(`q'/`p').sp2 L(`q'/`p').sp3, lag(`=`i' + 1')

     gen b`var'h`i' = _b[$shock] 
	 
	 boottest $shock, boottype(wild) stat(t) l(90) reps(500) seed(100) nograph  //r

     matrix se`var'h`i' = r(CI) 
  
     quietly replace b`var' = b`var'h`i' if h==`i' 
     quietly replace up95b`var' = se`var'h`i'[1,2] if h==`i' 
	 quietly replace lo95b`var' = se`var'h`i'[1,1] if h==`i' 
	
  } 
}

forval i=2/2{
local p = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
}

foreach var in sp1{
tw (rarea up95b`var' lo95b`var' h, bcolor(gs14) clw(medthin medthin)) ///
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=10, graphregion(color(white)) ///
  xtitle("") ytitle(`labtext') xtitle("Time horizon (years)") subtitle("Education - % of GDP", nobox) legend(off) 
  graph save "$outputpath/LP_Graphs/`label'_LP_percent_education.gph", replace
}

foreach var in sp2{
tw (rarea up95b`var' lo95b`var' h, bcolor(gs14) clw(medthin medthin)) ///
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=10, graphregion(color(white)) ///
  xtitle("") ytitle(`labtext') xtitle("Time horizon (years)") subtitle("Health - % of GDP", nobox) legend(off) 
  graph save "$outputpath/LP_Graphs/`label'_LP_percent_health.gph", replace
}

foreach var in sp3{
tw (rarea up95b`var' lo95b`var' h, bcolor(gs14) clw(medthin medthin)) ///
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=10, graphregion(color(white)) ///
  xtitle("") ytitle(`labtext') xtitle("Time horizon (years)") subtitle("Social Protection - % of GDP", nobox) legend(off) 
  graph save "$outputpath/LP_Graphs/`label'_LP_percent_socialprot.gph", replace
}


/*
set graphics off
foreach var in sp1 sp2 sp3 { 
local labtext : variable label `var'
tw (rarea up95b`var' lo95b`var' h, bcolor(gs14) clw(medthin medthin)) ///
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=10, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}


set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Bolivia Level %")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Bolivia_Ptg_lv_l1.pdf", name(ramey) replace
*/



********************************************************************************
*************************** BRAZIL *********************************************
********************************************************************************

/*******************************************************************************
**  LP per capita estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==3
keep if year <= 2019
tsset year
gen t = _n

summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percapita_education_CG)
gen sp2 = log(percapita_health_CG)
gen sp3 = log(percapita_socialprot_CG)


foreach var in cp1 sp1 sp2 sp3 { 

  quietly gen b`var' = .
  quietly gen up95b`var' = .
  quietly gen lo95b`var' = .
  
} 

gen h = t-1   /* h is the horizon for the IRFs */


local p = 1
local q = 1  /* q = 0 corresponds to recursiveness assumption, q = 1 is less restrictive */


global shock cp1 

 forvalues i = 0/12 {

 foreach var in sp1 sp2 sp3 {

     newey F`i'.`var' L(0/`p').$shock  L(`q'/`p').sp1 L(`q'/`p').sp2 L(`q'/`p').sp3, lag(`=`i' + 1')

     gen b`var'h`i' = _b[$shock] 
	 
	 boottest $shock, boottype(wild) stat(t) l(90) reps(500) seed(100) nograph  //r

     matrix se`var'h`i' = r(CI) 
  
     quietly replace b`var' = b`var'h`i' if h==`i' 
     quietly replace up95b`var' = se`var'h`i'[1,2] if h==`i' 
	 quietly replace lo95b`var' = se`var'h`i'[1,1] if h==`i' 
	
  } 
}


set graphics off
foreach var in sp1 sp2 sp3 { 
local labtext : variable label `var'
tw (rarea up95b`var' lo95b`var' h, bcolor(gs14) clw(medthin medthin)) ///
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=10, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Brazil levels pc")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Brazil_PC_lv_l1.pdf", name(ramey) replace



/*******************************************************************************
**  LP percentage of GDP estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==3
keep if year <= 2019
tsset year
gen t = _n

summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percent_education_CG)
gen sp2 = log(percent_health_CG)
gen sp3 = log(percent_socialprot_CG)


foreach var in cp1 sp1 sp2 sp3 { 

  quietly gen b`var' = .
  quietly gen up95b`var' = .
  quietly gen lo95b`var' = .
  
} 

gen h = t-1   /* h is the horizon for the IRFs */


local p = 1
local q = 1  /* q = 0 corresponds to recursiveness assumption, q = 1 is less restrictive */


global shock cp1 

 forvalues i = 0/12 {

 foreach var in sp1 sp2 sp3 {

     newey F`i'.`var' L(0/`p').$shock  L(`q'/`p').sp1 L(`q'/`p').sp2 L(`q'/`p').sp3, lag(`=`i' + 1')

     gen b`var'h`i' = _b[$shock] 
	 
	 boottest $shock, boottype(wild) stat(t) l(90) reps(500) seed(100) nograph  //r

     matrix se`var'h`i' = r(CI) 
  
     quietly replace b`var' = b`var'h`i' if h==`i' 
     quietly replace up95b`var' = se`var'h`i'[1,2] if h==`i' 
	 quietly replace lo95b`var' = se`var'h`i'[1,1] if h==`i' 
	
  } 
}


set graphics off
foreach var in sp1 sp2 sp3 { 
local labtext : variable label `var'
tw (rarea up95b`var' lo95b`var' h, bcolor(gs14) clw(medthin medthin)) ///
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=10, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Brazil Level %")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Brazil_Ptg_lv_l1.pdf", name(ramey) replace


********************************************************************************
******************************* CHILE ******************************************
********************************************************************************

/*******************************************************************************
**  LP per capita estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==4
keep if year <= 2019
tsset year
gen t = _n

summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percapita_education_CG)
gen sp2 = log(percapita_health_CG)
gen sp3 = log(percapita_socialprot_CG)


foreach var in cp1 sp1 sp2 sp3 { 

  quietly gen b`var' = .
  quietly gen up95b`var' = .
  quietly gen lo95b`var' = .
  
} 

gen h = t-1   /* h is the horizon for the IRFs */


local p = 1
local q = 1  /* q = 0 corresponds to recursiveness assumption, q = 1 is less restrictive */


global shock cp1 

 forvalues i = 0/12 {

 foreach var in sp1 sp2 sp3 {

     newey F`i'.`var' L(0/`p').$shock  L(`q'/`p').sp1 L(`q'/`p').sp2 L(`q'/`p').sp3, lag(`=`i' + 1')

     gen b`var'h`i' = _b[$shock] 
	 
	 boottest $shock, boottype(wild) stat(t) l(90) reps(500) seed(100) nograph  //r

     matrix se`var'h`i' = r(CI) 
  
     quietly replace b`var' = b`var'h`i' if h==`i' 
     quietly replace up95b`var' = se`var'h`i'[1,2] if h==`i' 
	 quietly replace lo95b`var' = se`var'h`i'[1,1] if h==`i' 
	
  } 
}


set graphics off
foreach var in sp1 sp2 sp3 { 
local labtext : variable label `var'
tw (rarea up95b`var' lo95b`var' h, bcolor(gs14) clw(medthin medthin)) ///
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=10, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Chile levels pc")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Chile_PC_lv_l1.pdf", name(ramey) replace


/*******************************************************************************
**  LP percentage of GDP estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==4
keep if year <= 2019
tsset year
gen t = _n

summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percent_education_CG)
gen sp2 = log(percent_health_CG)
gen sp3 = log(percent_socialprot_CG)


foreach var in cp1 sp1 sp2 sp3 { 

  quietly gen b`var' = .
  quietly gen up95b`var' = .
  quietly gen lo95b`var' = .
  
} 

gen h = t-1   /* h is the horizon for the IRFs */


local p = 1
local q = 1  /* q = 0 corresponds to recursiveness assumption, q = 1 is less restrictive */


global shock cp1 

 forvalues i = 0/12 {

 foreach var in sp1 sp2 sp3 {

     newey F`i'.`var' L(0/`p').$shock  L(`q'/`p').sp1 L(`q'/`p').sp2 L(`q'/`p').sp3, lag(`=`i' + 1')

     gen b`var'h`i' = _b[$shock] 
	 
	 boottest $shock, boottype(wild) stat(t) l(90) reps(500) seed(100) nograph  //r

     matrix se`var'h`i' = r(CI) 
  
     quietly replace b`var' = b`var'h`i' if h==`i' 
     quietly replace up95b`var' = se`var'h`i'[1,2] if h==`i' 
	 quietly replace lo95b`var' = se`var'h`i'[1,1] if h==`i' 
	
  } 
}


set graphics off
foreach var in sp1 sp2 sp3 { 
local labtext : variable label `var'
tw (rarea up95b`var' lo95b`var' h, bcolor(gs14) clw(medthin medthin)) ///
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=10, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Chile Level %")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Chile_Ptg_lv_l1.pdf", name(ramey) replace


********************************************************************************
**************************** COLOMBIA ******************************************
********************************************************************************

/*******************************************************************************
**  LP per capita estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==5
keep if year <= 2019
tsset year
gen t = _n

summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percapita_education_CG)
gen sp2 = log(percapita_health_CG)
gen sp3 = log(percapita_socialprot_CG)


foreach var in cp1 sp1 sp2 sp3 { 

  quietly gen b`var' = .
  quietly gen up95b`var' = .
  quietly gen lo95b`var' = .
  
} 

gen h = t-1   /* h is the horizon for the IRFs */


local p = 1
local q = 1  /* q = 0 corresponds to recursiveness assumption, q = 1 is less restrictive */


global shock cp1 

 forvalues i = 0/12 {

 foreach var in sp1 sp2 sp3 {

     newey F`i'.`var' L(0/`p').$shock  L(`q'/`p').sp1 L(`q'/`p').sp2 L(`q'/`p').sp3, lag(`=`i' + 1')

     gen b`var'h`i' = _b[$shock] 
	 
	 boottest $shock, boottype(wild) stat(t) l(90) reps(500) seed(100) nograph  //r

     matrix se`var'h`i' = r(CI) 
  
     quietly replace b`var' = b`var'h`i' if h==`i' 
     quietly replace up95b`var' = se`var'h`i'[1,2] if h==`i' 
	 quietly replace lo95b`var' = se`var'h`i'[1,1] if h==`i' 
	
  } 
}


set graphics off
foreach var in sp1 sp2 sp3 { 
local labtext : variable label `var'
tw (rarea up95b`var' lo95b`var' h, bcolor(gs14) clw(medthin medthin)) ///
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=10, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Colombia levels pc")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Colombia_PC_lv_l1.pdf", name(ramey) replace



/*******************************************************************************
**  LP percentage of GDP estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==5
keep if year <= 2019
tsset year
gen t = _n

summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percent_education_CG)
gen sp2 = log(percent_health_CG)
gen sp3 = log(percent_socialprot_CG)


foreach var in cp1 sp1 sp2 sp3 { 

  quietly gen b`var' = .
  quietly gen up95b`var' = .
  quietly gen lo95b`var' = .
  
} 

gen h = t-1   /* h is the horizon for the IRFs */


local p = 1
local q = 1  /* q = 0 corresponds to recursiveness assumption, q = 1 is less restrictive */


global shock cp1 

 forvalues i = 0/12 {

 foreach var in sp1 sp2 sp3 {

     newey F`i'.`var' L(0/`p').$shock  L(`q'/`p').sp1 L(`q'/`p').sp2 L(`q'/`p').sp3, lag(`=`i' + 1')

     gen b`var'h`i' = _b[$shock] 
	 
	 boottest $shock, boottype(wild) stat(t) l(90) reps(500) seed(100) nograph  //r

     matrix se`var'h`i' = r(CI) 
  
     quietly replace b`var' = b`var'h`i' if h==`i' 
     quietly replace up95b`var' = se`var'h`i'[1,2] if h==`i' 
	 quietly replace lo95b`var' = se`var'h`i'[1,1] if h==`i' 
	
  } 
}


set graphics off
foreach var in sp1 sp2 sp3 { 
local labtext : variable label `var'
tw (rarea up95b`var' lo95b`var' h, bcolor(gs14) clw(medthin medthin)) ///
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=10, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Colombia Level %")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Colombia_Ptg_lv_l1.pdf", name(ramey) replace


