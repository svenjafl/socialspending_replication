********************************************************************************
*************************** ARGENTINA ******************************************
********************************************************************************

/*******************************************************************************
**  LP levels per capita estimation
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


local p = 2
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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Argentina levels pc")  name(ramey, replace) ///
note("Upper Left: Education, NFPS; Upper right: Health, NFPS; Lower left: Social Protection, NFPS.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Argentina_PC_lv.pdf", name(ramey) replace



/*******************************************************************************
**  LP fist difference per capita estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==1
keep if year <= 2019
tsset year
gen t = _n

summarize 

gen lcp1 = log(commprice1)
gen lsp1 = log(percapita_education_NFPS)
gen lsp2 = log(percapita_health_NFPS)
gen lsp3 = log(percapita_socialprot_NFPS)

gen cp1 = D.lcp1
gen sp1 = D.lsp1
gen sp2 = D.lsp2
gen sp3 = D.lsp3

foreach var in cp1 sp1 sp2 sp3 { 

  quietly gen b`var' = .
  quietly gen up95b`var' = .
  quietly gen lo95b`var' = .
  
} 

gen h = t-1   /* h is the horizon for the IRFs */


local p = 2
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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Argentina 1.Diff pc")  name(ramey, replace) ///
note("Upper Left: Education, NFPS; Upper right: Health, NFPS; Lower left: Social Protection, NFPS.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Argentina_PC_diff.pdf", name(ramey) replace


/*******************************************************************************
**  LP levels percentage of GDP estimation
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


local p = 2
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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Argentina Level %")  name(ramey, replace) ///
note("Upper Left: Education, NFPS; Upper right: Health, NFPS; Lower left: Social Protection, NFPS.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Argentina_Ptg_lv.pdf", name(ramey) replace



/*******************************************************************************
**  LP fist difference percentage of GDP estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==1
keep if year <= 2019
tsset year
gen t = _n

summarize 

gen lcp1 = log(commprice1)
gen lsp1 = log(percent_education_NFPS)
gen lsp2 = log(percent_health_NFPS)
gen lsp3 = log(percent_socialprot_NFPS)

gen cp1 = D.lcp1
gen sp1 = D.lsp1
gen sp2 = D.lsp2
gen sp3 = D.lsp3

foreach var in cp1 sp1 sp2 sp3 { 

  quietly gen b`var' = .
  quietly gen up95b`var' = .
  quietly gen lo95b`var' = .
  
} 

gen h = t-1   /* h is the horizon for the IRFs */


local p = 2
local q = 1  /* q = 0 corresponds to recursiveness assumption, q = 1 is less restrictive */


global shock cp1 

 forvalues i = 0/12 {

 foreach var in sp1 sp2 sp3 {

     newey F`i'.`var' L(0/`p').$shock  L(`q'/`p').sp1 L(`q'/`p').sp2 L(`q'/`p').sp3 , lag(`=`i' + 1')

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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Argentina 1.Diff %")  name(ramey, replace) ///
note("Upper Left: Education, NFPS; Upper right: Health, NFPS; Lower left: Social Protection, NFPS.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Argentina_Ptg_diff.pdf", name(ramey) replace

********************************************************************************
***************************** BOLIVIA ******************************************
********************************************************************************

/*******************************************************************************
**  LP levels per capita estimation
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


local p = 2
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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Bolivia levels pc")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Bolivia_PC_lv.pdf", name(ramey) replace



/*******************************************************************************
**  LP fist difference per capita estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==2
keep if year <= 2019
tsset year
gen t = _n

summarize 

gen lcp1 = log(commprice1)
gen lsp1 = log(percapita_education_CG)
gen lsp2 = log(percapita_health_CG)
gen lsp3 = log(percapita_socialprot_CG)

gen cp1 = D.lcp1
gen sp1 = D.lsp1
gen sp2 = D.lsp2
gen sp3 = D.lsp3

foreach var in cp1 sp1 sp2 sp3 { 

  quietly gen b`var' = .
  quietly gen up95b`var' = .
  quietly gen lo95b`var' = .
  
} 

gen h = t-1   /* h is the horizon for the IRFs */


local p = 2
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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Bolivia 1.Diff pc")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Bolivia_PC_diff.pdf", name(ramey) replace


/*******************************************************************************
**  LP levels percentage of GDP estimation
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


local p = 2
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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Bolivia Level %")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Bolivia_Ptg_lv.pdf", name(ramey) replace



/*******************************************************************************
**  LP fist difference percentage of GDP estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==2
keep if year <= 2019
tsset year
gen t = _n

summarize 

gen lcp1 = log(commprice1)
gen lsp1 = log(percent_education_CG)
gen lsp2 = log(percent_health_CG)
gen lsp3 = log(percent_socialprot_CG)

gen cp1 = D.lcp1
gen sp1 = D.lsp1
gen sp2 = D.lsp2
gen sp3 = D.lsp3

foreach var in cp1 sp1 sp2 sp3 { 

  quietly gen b`var' = .
  quietly gen up95b`var' = .
  quietly gen lo95b`var' = .
  
} 

gen h = t-1   /* h is the horizon for the IRFs */


local p = 2
local q = 1  /* q = 0 corresponds to recursiveness assumption, q = 1 is less restrictive */


global shock cp1 

 forvalues i = 0/12 {

 foreach var in sp1 sp2 sp3 {

     newey F`i'.`var' L(0/`p').$shock  L(`q'/`p').sp1 L(`q'/`p').sp2 L(`q'/`p').sp3 , lag(`=`i' + 1')

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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Bolivia 1.Diff %")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Bolivia_Ptg_diff.pdf", name(ramey) replace

********************************************************************************
*************************** BRAZIL *********************************************
********************************************************************************

/*******************************************************************************
**  LP levels per capita estimation
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


local p = 2
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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Brazil levels pc")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Brazil_PC_lv.pdf", name(ramey) replace



/*******************************************************************************
**  LP fist difference per capita estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==3
keep if year <= 2019
tsset year
gen t = _n

summarize 

gen lcp1 = log(commprice1)
gen lsp1 = log(percapita_education_CG)
gen lsp2 = log(percapita_health_CG)
gen lsp3 = log(percapita_socialprot_CG)

gen cp1 = D.lcp1
gen sp1 = D.lsp1
gen sp2 = D.lsp2
gen sp3 = D.lsp3

foreach var in cp1 sp1 sp2 sp3 { 

  quietly gen b`var' = .
  quietly gen up95b`var' = .
  quietly gen lo95b`var' = .
  
} 

gen h = t-1   /* h is the horizon for the IRFs */


local p = 2
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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Brazil 1.Diff pc")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Brazil_PC_diff.pdf", name(ramey) replace


/*******************************************************************************
**  LP levels percentage of GDP estimation
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


local p = 2
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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Brazil Level %")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Brazil_Ptg_lv.pdf", name(ramey) replace



/*******************************************************************************
**  LP fist difference percentage of GDP estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==3
keep if year <= 2019
tsset year
gen t = _n

summarize 

gen lcp1 = log(commprice1)
gen lsp1 = log(percent_education_CG)
gen lsp2 = log(percent_health_CG)
gen lsp3 = log(percent_socialprot_CG)

gen cp1 = D.lcp1
gen sp1 = D.lsp1
gen sp2 = D.lsp2
gen sp3 = D.lsp3

foreach var in cp1 sp1 sp2 sp3 { 

  quietly gen b`var' = .
  quietly gen up95b`var' = .
  quietly gen lo95b`var' = .
  
} 

gen h = t-1   /* h is the horizon for the IRFs */


local p = 2
local q = 1  /* q = 0 corresponds to recursiveness assumption, q = 1 is less restrictive */


global shock cp1 

 forvalues i = 0/12 {

 foreach var in sp1 sp2 sp3 {

     newey F`i'.`var' L(0/`p').$shock  L(`q'/`p').sp1 L(`q'/`p').sp2 L(`q'/`p').sp3 , lag(`=`i' + 1')

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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Brazil 1.Diff %")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Brazil_Ptg_diff.pdf", name(ramey) replace

********************************************************************************
******************************* CHILE ******************************************
********************************************************************************

/*******************************************************************************
**  LP levels per capita estimation
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


local p = 2
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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Chile levels pc")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Chile_PC_lv.pdf", name(ramey) replace



/*******************************************************************************
**  LP fist difference per capita estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==4
keep if year <= 2019
tsset year
gen t = _n

summarize 

gen lcp1 = log(commprice1)
gen lsp1 = log(percapita_education_CG)
gen lsp2 = log(percapita_health_CG)
gen lsp3 = log(percapita_socialprot_CG)

gen cp1 = D.lcp1
gen sp1 = D.lsp1
gen sp2 = D.lsp2
gen sp3 = D.lsp3

foreach var in cp1 sp1 sp2 sp3 { 

  quietly gen b`var' = .
  quietly gen up95b`var' = .
  quietly gen lo95b`var' = .
  
} 

gen h = t-1   /* h is the horizon for the IRFs */


local p = 2
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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Chile 1.Diff pc")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Chile_PC_diff.pdf", name(ramey) replace


/*******************************************************************************
**  LP levels percentage of GDP estimation
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


local p = 2
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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Chile Level %")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Chile_Ptg_lv.pdf", name(ramey) replace

/*******************************************************************************
**  LP fist difference percentage of GDP estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==4
keep if year <= 2019
tsset year
gen t = _n

summarize 

gen lcp1 = log(commprice1)
gen lsp1 = log(percent_education_CG)
gen lsp2 = log(percent_health_CG)
gen lsp3 = log(percent_socialprot_CG)

gen cp1 = D.lcp1
gen sp1 = D.lsp1
gen sp2 = D.lsp2
gen sp3 = D.lsp3

foreach var in cp1 sp1 sp2 sp3 { 

  quietly gen b`var' = .
  quietly gen up95b`var' = .
  quietly gen lo95b`var' = .
  
} 

gen h = t-1   /* h is the horizon for the IRFs */


local p = 2
local q = 1  /* q = 0 corresponds to recursiveness assumption, q = 1 is less restrictive */


global shock cp1 

 forvalues i = 0/12 {

 foreach var in sp1 sp2 sp3 {

     newey F`i'.`var' L(0/`p').$shock  L(`q'/`p').sp1 L(`q'/`p').sp2 L(`q'/`p').sp3 , lag(`=`i' + 1')

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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Chile 1.Diff %")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Chile_Ptg_diff.pdf", name(ramey) replace

********************************************************************************
**************************** COLOMBIA ******************************************
********************************************************************************

/*******************************************************************************
**  LP levels per capita estimation
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


local p = 2
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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Colombia levels pc")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Colombia_PC_lv.pdf", name(ramey) replace



/*******************************************************************************
**  LP fist difference per capita estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==5
keep if year <= 2019
tsset year
gen t = _n

summarize 

gen lcp1 = log(commprice1)
gen lsp1 = log(percapita_education_CG)
gen lsp2 = log(percapita_health_CG)
gen lsp3 = log(percapita_socialprot_CG)

gen cp1 = D.lcp1
gen sp1 = D.lsp1
gen sp2 = D.lsp2
gen sp3 = D.lsp3

foreach var in cp1 sp1 sp2 sp3 { 

  quietly gen b`var' = .
  quietly gen up95b`var' = .
  quietly gen lo95b`var' = .
  
} 

gen h = t-1   /* h is the horizon for the IRFs */


local p = 2
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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Colombia 1.Diff pc")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Colombia_PC_diff.pdf", name(ramey) replace


/*******************************************************************************
**  LP levels percentage of GDP estimation
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


local p = 2
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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Colombia Level %")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Colombia_Ptg_lv.pdf", name(ramey) replace



/*******************************************************************************
**  LP fist difference percentage of GDP estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==5
keep if year <= 2019
tsset year
gen t = _n

summarize 

gen lcp1 = log(commprice1)
gen lsp1 = log(percent_education_CG)
gen lsp2 = log(percent_health_CG)
gen lsp3 = log(percent_socialprot_CG)

gen cp1 = D.lcp1
gen sp1 = D.lsp1
gen sp2 = D.lsp2
gen sp3 = D.lsp3

foreach var in cp1 sp1 sp2 sp3 { 

  quietly gen b`var' = .
  quietly gen up95b`var' = .
  quietly gen lo95b`var' = .
  
} 

gen h = t-1   /* h is the horizon for the IRFs */


local p = 2
local q = 1  /* q = 0 corresponds to recursiveness assumption, q = 1 is less restrictive */


global shock cp1 

 forvalues i = 0/12 {

 foreach var in sp1 sp2 sp3 {

     newey F`i'.`var' L(0/`p').$shock  L(`q'/`p').sp1 L(`q'/`p').sp2 L(`q'/`p').sp3 , lag(`=`i' + 1')

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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Colombia 1.Diff %")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Colombia_Ptg_diff.pdf", name(ramey) replace

********************************************************************************
*************************** COSTA RICA *****************************************
********************************************************************************

/*******************************************************************************
**  LP levels per capita estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==6
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


local p = 2
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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Costa Rica levels pc")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Costa Rica_PC_lv.pdf", name(ramey) replace



/*******************************************************************************
**  LP fist difference per capita estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==6
keep if year <= 2019
tsset year
gen t = _n

summarize 

gen lcp1 = log(commprice1)
gen lsp1 = log(percapita_education_CG)
gen lsp2 = log(percapita_health_CG)
gen lsp3 = log(percapita_socialprot_CG)

gen cp1 = D.lcp1
gen sp1 = D.lsp1
gen sp2 = D.lsp2
gen sp3 = D.lsp3

foreach var in cp1 sp1 sp2 sp3 { 

  quietly gen b`var' = .
  quietly gen up95b`var' = .
  quietly gen lo95b`var' = .
  
} 

gen h = t-1   /* h is the horizon for the IRFs */


local p = 2
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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Costa Rica 1.Diff pc")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Costa Rica_PC_diff.pdf", name(ramey) replace


/*******************************************************************************
**  LP levels percentage of GDP estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==6
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


local p = 2
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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Costa Rica Level %")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Costa Rica_Ptg_lv.pdf", name(ramey) replace



/*******************************************************************************
**  LP fist difference percentage of GDP estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==6
keep if year <= 2019
tsset year
gen t = _n

summarize 

gen lcp1 = log(commprice1)
gen lsp1 = log(percent_education_CG)
gen lsp2 = log(percent_health_CG)
gen lsp3 = log(percent_socialprot_CG)

gen cp1 = D.lcp1
gen sp1 = D.lsp1
gen sp2 = D.lsp2
gen sp3 = D.lsp3

foreach var in cp1 sp1 sp2 sp3 { 

  quietly gen b`var' = .
  quietly gen up95b`var' = .
  quietly gen lo95b`var' = .
  
} 

gen h = t-1   /* h is the horizon for the IRFs */


local p = 2
local q = 1  /* q = 0 corresponds to recursiveness assumption, q = 1 is less restrictive */


global shock cp1 

 forvalues i = 0/12 {

 foreach var in sp1 sp2 sp3 {

     newey F`i'.`var' L(0/`p').$shock  L(`q'/`p').sp1 L(`q'/`p').sp2 L(`q'/`p').sp3 , lag(`=`i' + 1')

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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Costa Rica 1.Diff %")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Costa Rica_Ptg_diff.pdf", name(ramey) replace

********************************************************************************
***************************** DOM REP ******************************************
********************************************************************************

/*******************************************************************************
**  LP levels per capita estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==7
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


local p = 2
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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Dominican Republic levels pc")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Dominican Republic_PC_lv.pdf", name(ramey) replace



/*******************************************************************************
**  LP fist difference per capita estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==7
keep if year <= 2019
tsset year
gen t = _n

summarize 

gen lcp1 = log(commprice1)
gen lsp1 = log(percapita_education_CG)
gen lsp2 = log(percapita_health_CG)
gen lsp3 = log(percapita_socialprot_CG)

gen cp1 = D.lcp1
gen sp1 = D.lsp1
gen sp2 = D.lsp2
gen sp3 = D.lsp3

foreach var in cp1 sp1 sp2 sp3 { 

  quietly gen b`var' = .
  quietly gen up95b`var' = .
  quietly gen lo95b`var' = .
  
} 

gen h = t-1   /* h is the horizon for the IRFs */


local p = 2
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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Dominican Republic 1.Diff pc")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Dominican Republic_PC_diff.pdf", name(ramey) replace


/*******************************************************************************
**  LP levels percentage of GDP estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==7
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


local p = 2
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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Dominican Republic Level %")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Dominican Republic_Ptg_lv.pdf", name(ramey) replace



/*******************************************************************************
**  LP fist difference percentage of GDP estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==7
keep if year <= 2019
tsset year
gen t = _n

summarize 

gen lcp1 = log(commprice1)
gen lsp1 = log(percent_education_CG)
gen lsp2 = log(percent_health_CG)
gen lsp3 = log(percent_socialprot_CG)

gen cp1 = D.lcp1
gen sp1 = D.lsp1
gen sp2 = D.lsp2
gen sp3 = D.lsp3

foreach var in cp1 sp1 sp2 sp3 { 

  quietly gen b`var' = .
  quietly gen up95b`var' = .
  quietly gen lo95b`var' = .
  
} 

gen h = t-1   /* h is the horizon for the IRFs */


local p = 2
local q = 1  /* q = 0 corresponds to recursiveness assumption, q = 1 is less restrictive */


global shock cp1 

 forvalues i = 0/12 {

 foreach var in sp1 sp2 sp3 {

     newey F`i'.`var' L(0/`p').$shock  L(`q'/`p').sp1 L(`q'/`p').sp2 L(`q'/`p').sp3 , lag(`=`i' + 1')

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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Dominican Republic 1.Diff %")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Dominican Republic_Ptg_diff.pdf", name(ramey) replace

********************************************************************************
***************************** ECUADOR ******************************************
********************************************************************************

/*******************************************************************************
**  LP levels per capita estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==8
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


local p = 2
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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Ecuador levels pc")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Ecuador_PC_lv.pdf", name(ramey) replace



/*******************************************************************************
**  LP fist difference per capita estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==8
keep if year <= 2019
tsset year
gen t = _n

summarize 

gen lcp1 = log(commprice1)
gen lsp1 = log(percapita_education_CG)
gen lsp2 = log(percapita_health_CG)
gen lsp3 = log(percapita_socialprot_CG)

gen cp1 = D.lcp1
gen sp1 = D.lsp1
gen sp2 = D.lsp2
gen sp3 = D.lsp3

foreach var in cp1 sp1 sp2 sp3 { 

  quietly gen b`var' = .
  quietly gen up95b`var' = .
  quietly gen lo95b`var' = .
  
} 

gen h = t-1   /* h is the horizon for the IRFs */


local p = 2
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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Ecuador 1.Diff pc")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Ecuador_PC_diff.pdf", name(ramey) replace


/*******************************************************************************
**  LP levels percentage of GDP estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==8
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


local p = 2
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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Ecuador Level %")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Ecuador_Ptg_lv.pdf", name(ramey) replace



/*******************************************************************************
**  LP fist difference percentage of GDP estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==8
keep if year <= 2019
tsset year
gen t = _n

summarize 

gen lcp1 = log(commprice1)
gen lsp1 = log(percent_education_CG)
gen lsp2 = log(percent_health_CG)
gen lsp3 = log(percent_socialprot_CG)

gen cp1 = D.lcp1
gen sp1 = D.lsp1
gen sp2 = D.lsp2
gen sp3 = D.lsp3

foreach var in cp1 sp1 sp2 sp3 { 

  quietly gen b`var' = .
  quietly gen up95b`var' = .
  quietly gen lo95b`var' = .
  
} 

gen h = t-1   /* h is the horizon for the IRFs */


local p = 2
local q = 1  /* q = 0 corresponds to recursiveness assumption, q = 1 is less restrictive */


global shock cp1 

 forvalues i = 0/12 {

 foreach var in sp1 sp2 sp3 {

     newey F`i'.`var' L(0/`p').$shock  L(`q'/`p').sp1 L(`q'/`p').sp2 L(`q'/`p').sp3 , lag(`=`i' + 1')

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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Ecuador 1.Diff %")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Ecuador_Ptg_diff.pdf", name(ramey) replace

********************************************************************************
*************************** EL SALVADOR ****************************************
********************************************************************************

/*******************************************************************************
**  LP levels per capita estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==9
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


local p = 2
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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("El Salvador levels pc")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_El Salvador_PC_lv.pdf", name(ramey) replace



/*******************************************************************************
**  LP fist difference per capita estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==9
keep if year <= 2019
tsset year
gen t = _n

summarize 

gen lcp1 = log(commprice1)
gen lsp1 = log(percapita_education_CG)
gen lsp2 = log(percapita_health_CG)
gen lsp3 = log(percapita_socialprot_CG)

gen cp1 = D.lcp1
gen sp1 = D.lsp1
gen sp2 = D.lsp2
gen sp3 = D.lsp3

foreach var in cp1 sp1 sp2 sp3 { 

  quietly gen b`var' = .
  quietly gen up95b`var' = .
  quietly gen lo95b`var' = .
  
} 

gen h = t-1   /* h is the horizon for the IRFs */


local p = 2
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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("El Salvador 1.Diff pc")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_El Salvador_PC_diff.pdf", name(ramey) replace


/*******************************************************************************
**  LP levels percentage of GDP estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==9
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


local p = 2
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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("El Salvador Level %")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_El Salvador_Ptg_lv.pdf", name(ramey) replace



/*******************************************************************************
**  LP fist difference percentage of GDP estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==9
keep if year <= 2019
tsset year
gen t = _n

summarize 

gen lcp1 = log(commprice1)
gen lsp1 = log(percent_education_CG)
gen lsp2 = log(percent_health_CG)
gen lsp3 = log(percent_socialprot_CG)

gen cp1 = D.lcp1
gen sp1 = D.lsp1
gen sp2 = D.lsp2
gen sp3 = D.lsp3

foreach var in cp1 sp1 sp2 sp3 { 

  quietly gen b`var' = .
  quietly gen up95b`var' = .
  quietly gen lo95b`var' = .
  
} 

gen h = t-1   /* h is the horizon for the IRFs */


local p = 2
local q = 1  /* q = 0 corresponds to recursiveness assumption, q = 1 is less restrictive */


global shock cp1 

 forvalues i = 0/12 {

 foreach var in sp1 sp2 sp3 {

     newey F`i'.`var' L(0/`p').$shock  L(`q'/`p').sp1 L(`q'/`p').sp2 L(`q'/`p').sp3 , lag(`=`i' + 1')

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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("El Salvador 1.Diff %")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_El Salvador_Ptg_diff.pdf", name(ramey) replace

********************************************************************************
*************************** GUATEMALA ******************************************
********************************************************************************

/*******************************************************************************
**  LP levels per capita estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==10
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


local p = 2
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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Guatemala levels pc")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Guatemala_PC_lv.pdf", name(ramey) replace



/*******************************************************************************
**  LP fist difference per capita estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==10
keep if year <= 2019
tsset year
gen t = _n

summarize 

gen lcp1 = log(commprice1)
gen lsp1 = log(percapita_education_CG)
gen lsp2 = log(percapita_health_CG)
gen lsp3 = log(percapita_socialprot_CG)

gen cp1 = D.lcp1
gen sp1 = D.lsp1
gen sp2 = D.lsp2
gen sp3 = D.lsp3

foreach var in cp1 sp1 sp2 sp3 { 

  quietly gen b`var' = .
  quietly gen up95b`var' = .
  quietly gen lo95b`var' = .
  
} 

gen h = t-1   /* h is the horizon for the IRFs */


local p = 2
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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Guatemala 1.Diff pc")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Guatemala_PC_diff.pdf", name(ramey) replace


/*******************************************************************************
**  LP levels percentage of GDP estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==10
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


local p = 2
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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Guatemala Level %")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Guatemala_Ptg_lv.pdf", name(ramey) replace



/*******************************************************************************
**  LP fist difference percentage of GDP estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==10
keep if year <= 2019
tsset year
gen t = _n

summarize 

gen lcp1 = log(commprice1)
gen lsp1 = log(percent_education_CG)
gen lsp2 = log(percent_health_CG)
gen lsp3 = log(percent_socialprot_CG)

gen cp1 = D.lcp1
gen sp1 = D.lsp1
gen sp2 = D.lsp2
gen sp3 = D.lsp3

foreach var in cp1 sp1 sp2 sp3 { 

  quietly gen b`var' = .
  quietly gen up95b`var' = .
  quietly gen lo95b`var' = .
  
} 

gen h = t-1   /* h is the horizon for the IRFs */


local p = 2
local q = 1  /* q = 0 corresponds to recursiveness assumption, q = 1 is less restrictive */


global shock cp1 

 forvalues i = 0/12 {

 foreach var in sp1 sp2 sp3 {

     newey F`i'.`var' L(0/`p').$shock  L(`q'/`p').sp1 L(`q'/`p').sp2 L(`q'/`p').sp3 , lag(`=`i' + 1')

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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Guatemala 1.Diff %")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Guatemala_Ptg_diff.pdf", name(ramey) replace

********************************************************************************
**************************** HONDURAS ******************************************
********************************************************************************

/*******************************************************************************
**  LP levels per capita estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==11
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


local p = 2
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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Honduras levels pc")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Honduras_PC_lv.pdf", name(ramey) replace



/*******************************************************************************
**  LP fist difference per capita estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==11
keep if year <= 2019
tsset year
gen t = _n

summarize 

gen lcp1 = log(commprice1)
gen lsp1 = log(percapita_education_CG)
gen lsp2 = log(percapita_health_CG)
gen lsp3 = log(percapita_socialprot_CG)

gen cp1 = D.lcp1
gen sp1 = D.lsp1
gen sp2 = D.lsp2
gen sp3 = D.lsp3

foreach var in cp1 sp1 sp2 sp3 { 

  quietly gen b`var' = .
  quietly gen up95b`var' = .
  quietly gen lo95b`var' = .
  
} 

gen h = t-1   /* h is the horizon for the IRFs */


local p = 2
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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Honduras 1.Diff pc")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Honduras_PC_diff.pdf", name(ramey) replace


/*******************************************************************************
**  LP levels percentage of GDP estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==11
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


local p = 2
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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Honduras Level %")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Honduras_Ptg_lv.pdf", name(ramey) replace



/*******************************************************************************
**  LP fist difference percentage of GDP estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==11
keep if year <= 2019
tsset year
gen t = _n

summarize 

gen lcp1 = log(commprice1)
gen lsp1 = log(percent_education_CG)
gen lsp2 = log(percent_health_CG)
gen lsp3 = log(percent_socialprot_CG)

gen cp1 = D.lcp1
gen sp1 = D.lsp1
gen sp2 = D.lsp2
gen sp3 = D.lsp3

foreach var in cp1 sp1 sp2 sp3 { 

  quietly gen b`var' = .
  quietly gen up95b`var' = .
  quietly gen lo95b`var' = .
  
} 

gen h = t-1   /* h is the horizon for the IRFs */


local p = 2
local q = 1  /* q = 0 corresponds to recursiveness assumption, q = 1 is less restrictive */


global shock cp1 

 forvalues i = 0/12 {

 foreach var in sp1 sp2 sp3 {

     newey F`i'.`var' L(0/`p').$shock  L(`q'/`p').sp1 L(`q'/`p').sp2 L(`q'/`p').sp3 , lag(`=`i' + 1')

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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Honduras 1.Diff %")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Honduras_Ptg_diff.pdf", name(ramey) replace

********************************************************************************
****************************** MEXICO ******************************************
********************************************************************************

/*******************************************************************************
**  LP levels per capita estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==13
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


local p = 2
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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Mexico levels pc")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Mexico_PC_lv.pdf", name(ramey) replace



/*******************************************************************************
**  LP fist difference per capita estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==13
keep if year <= 2019
tsset year
gen t = _n

summarize 

gen lcp1 = log(commprice1)
gen lsp1 = log(percapita_education_CG)
gen lsp2 = log(percapita_health_CG)
gen lsp3 = log(percapita_socialprot_CG)

gen cp1 = D.lcp1
gen sp1 = D.lsp1
gen sp2 = D.lsp2
gen sp3 = D.lsp3

foreach var in cp1 sp1 sp2 sp3 { 

  quietly gen b`var' = .
  quietly gen up95b`var' = .
  quietly gen lo95b`var' = .
  
} 

gen h = t-1   /* h is the horizon for the IRFs */


local p = 2
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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Mexico 1.Diff pc")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Mexico_PC_diff.pdf", name(ramey) replace


/*******************************************************************************
**  LP levels percentage of GDP estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==13
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


local p = 2
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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Mexico Level %")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Mexico_Ptg_lv.pdf", name(ramey) replace



/*******************************************************************************
**  LP fist difference percentage of GDP estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==13
keep if year <= 2019
tsset year
gen t = _n

summarize 

gen lcp1 = log(commprice1)
gen lsp1 = log(percent_education_CG)
gen lsp2 = log(percent_health_CG)
gen lsp3 = log(percent_socialprot_CG)

gen cp1 = D.lcp1
gen sp1 = D.lsp1
gen sp2 = D.lsp2
gen sp3 = D.lsp3

foreach var in cp1 sp1 sp2 sp3 { 

  quietly gen b`var' = .
  quietly gen up95b`var' = .
  quietly gen lo95b`var' = .
  
} 

gen h = t-1   /* h is the horizon for the IRFs */


local p = 2
local q = 1  /* q = 0 corresponds to recursiveness assumption, q = 1 is less restrictive */


global shock cp1 

 forvalues i = 0/12 {

 foreach var in sp1 sp2 sp3 {

     newey F`i'.`var' L(0/`p').$shock  L(`q'/`p').sp1 L(`q'/`p').sp2 L(`q'/`p').sp3 , lag(`=`i' + 1')

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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Mexico 1.Diff %")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Mexico_Ptg_diff.pdf", name(ramey) replace

********************************************************************************
*************************** NICARAGUA ******************************************
********************************************************************************

/*******************************************************************************
**  LP levels per capita estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==14
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


local p = 2
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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Nicaragua levels pc")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Nicaragua_PC_lv.pdf", name(ramey) replace



/*******************************************************************************
**  LP fist difference per capita estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==14
keep if year <= 2019
tsset year
gen t = _n

summarize 

gen lcp1 = log(commprice1)
gen lsp1 = log(percapita_education_CG)
gen lsp2 = log(percapita_health_CG)
gen lsp3 = log(percapita_socialprot_CG)

gen cp1 = D.lcp1
gen sp1 = D.lsp1
gen sp2 = D.lsp2
gen sp3 = D.lsp3

foreach var in cp1 sp1 sp2 sp3 { 

  quietly gen b`var' = .
  quietly gen up95b`var' = .
  quietly gen lo95b`var' = .
  
} 

gen h = t-1   /* h is the horizon for the IRFs */


local p = 2
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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Nicaragua 1.Diff pc")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Nicaragua_PC_diff.pdf", name(ramey) replace


/*******************************************************************************
**  LP levels percentage of GDP estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==14
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


local p = 2
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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Nicaragua Level %")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Nicaragua_Ptg_lv.pdf", name(ramey) replace



/*******************************************************************************
**  LP fist difference percentage of GDP estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==14
keep if year <= 2019
tsset year
gen t = _n

summarize 

gen lcp1 = log(commprice1)
gen lsp1 = log(percent_education_CG)
gen lsp2 = log(percent_health_CG)
gen lsp3 = log(percent_socialprot_CG)

gen cp1 = D.lcp1
gen sp1 = D.lsp1
gen sp2 = D.lsp2
gen sp3 = D.lsp3

foreach var in cp1 sp1 sp2 sp3 { 

  quietly gen b`var' = .
  quietly gen up95b`var' = .
  quietly gen lo95b`var' = .
  
} 

gen h = t-1   /* h is the horizon for the IRFs */


local p = 2
local q = 1  /* q = 0 corresponds to recursiveness assumption, q = 1 is less restrictive */


global shock cp1 

 forvalues i = 0/12 {

 foreach var in sp1 sp2 sp3 {

     newey F`i'.`var' L(0/`p').$shock  L(`q'/`p').sp1 L(`q'/`p').sp2 L(`q'/`p').sp3 , lag(`=`i' + 1')

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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Nicaragua 1.Diff %")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Nicaragua_Ptg_diff.pdf", name(ramey) replace

********************************************************************************
****************************** PANAMA ******************************************
********************************************************************************

/*******************************************************************************
**  LP levels per capita estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==15
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


local p = 2
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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Panama levels pc")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Panama_PC_lv.pdf", name(ramey) replace



/*******************************************************************************
**  LP fist difference per capita estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==15
keep if year <= 2019
tsset year
gen t = _n

summarize 

gen lcp1 = log(commprice1)
gen lsp1 = log(percapita_education_CG)
gen lsp2 = log(percapita_health_CG)
gen lsp3 = log(percapita_socialprot_CG)

gen cp1 = D.lcp1
gen sp1 = D.lsp1
gen sp2 = D.lsp2
gen sp3 = D.lsp3

foreach var in cp1 sp1 sp2 sp3 { 

  quietly gen b`var' = .
  quietly gen up95b`var' = .
  quietly gen lo95b`var' = .
  
} 

gen h = t-1   /* h is the horizon for the IRFs */


local p = 2
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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Panama 1.Diff pc")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Panama_PC_diff.pdf", name(ramey) replace


/*******************************************************************************
**  LP levels percentage of GDP estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==15
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


local p = 2
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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Panama Level %")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Panama_Ptg_lv.pdf", name(ramey) replace



/*******************************************************************************
**  LP fist difference percentage of GDP estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==15
keep if year <= 2019
tsset year
gen t = _n

summarize 

gen lcp1 = log(commprice1)
gen lsp1 = log(percent_education_CG)
gen lsp2 = log(percent_health_CG)
gen lsp3 = log(percent_socialprot_CG)

gen cp1 = D.lcp1
gen sp1 = D.lsp1
gen sp2 = D.lsp2
gen sp3 = D.lsp3

foreach var in cp1 sp1 sp2 sp3 { 

  quietly gen b`var' = .
  quietly gen up95b`var' = .
  quietly gen lo95b`var' = .
  
} 

gen h = t-1   /* h is the horizon for the IRFs */


local p = 2
local q = 1  /* q = 0 corresponds to recursiveness assumption, q = 1 is less restrictive */


global shock cp1 

 forvalues i = 0/12 {

 foreach var in sp1 sp2 sp3 {

     newey F`i'.`var' L(0/`p').$shock  L(`q'/`p').sp1 L(`q'/`p').sp2 L(`q'/`p').sp3 , lag(`=`i' + 1')

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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Panama 1.Diff %")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Panama_Ptg_diff.pdf", name(ramey) replace

********************************************************************************
****************************** PARAGUAY ****************************************
********************************************************************************

/*******************************************************************************
**  LP levels per capita estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==16
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


local p = 2
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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Paraguay levels pc")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Paraguay_PC_lv.pdf", name(ramey) replace



/*******************************************************************************
**  LP fist difference per capita estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==16
keep if year <= 2019
tsset year
gen t = _n

summarize 

gen lcp1 = log(commprice1)
gen lsp1 = log(percapita_education_CG)
gen lsp2 = log(percapita_health_CG)
gen lsp3 = log(percapita_socialprot_CG)

gen cp1 = D.lcp1
gen sp1 = D.lsp1
gen sp2 = D.lsp2
gen sp3 = D.lsp3

foreach var in cp1 sp1 sp2 sp3 { 

  quietly gen b`var' = .
  quietly gen up95b`var' = .
  quietly gen lo95b`var' = .
  
} 

gen h = t-1   /* h is the horizon for the IRFs */


local p = 2
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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Paraguay 1.Diff pc")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Paraguay_PC_diff.pdf", name(ramey) replace


/*******************************************************************************
**  LP levels percentage of GDP estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==16
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


local p = 2
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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Paraguay Level %")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Paraguay_Ptg_lv.pdf", name(ramey) replace



/*******************************************************************************
**  LP fist difference percentage of GDP estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==16
keep if year <= 2019
tsset year
gen t = _n

summarize 

gen lcp1 = log(commprice1)
gen lsp1 = log(percent_education_CG)
gen lsp2 = log(percent_health_CG)
gen lsp3 = log(percent_socialprot_CG)

gen cp1 = D.lcp1
gen sp1 = D.lsp1
gen sp2 = D.lsp2
gen sp3 = D.lsp3

foreach var in cp1 sp1 sp2 sp3 { 

  quietly gen b`var' = .
  quietly gen up95b`var' = .
  quietly gen lo95b`var' = .
  
} 

gen h = t-1   /* h is the horizon for the IRFs */


local p = 2
local q = 1  /* q = 0 corresponds to recursiveness assumption, q = 1 is less restrictive */


global shock cp1 

 forvalues i = 0/12 {

 foreach var in sp1 sp2 sp3 {

     newey F`i'.`var' L(0/`p').$shock  L(`q'/`p').sp1 L(`q'/`p').sp2 L(`q'/`p').sp3 , lag(`=`i' + 1')

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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Paraguay 1.Diff %")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Paraguay_Ptg_diff.pdf", name(ramey) replace

********************************************************************************
********************************** PERU ****************************************
********************************************************************************

/*******************************************************************************
**  LP levels per capita estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==17
keep if year <= 2019
tsset year
gen t = _n

summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percapita_education_GG)
gen sp2 = log(percapita_health_GG)
gen sp3 = log(percapita_socialprot_GG)


foreach var in cp1 sp1 sp2 sp3 { 

  quietly gen b`var' = .
  quietly gen up95b`var' = .
  quietly gen lo95b`var' = .
  
} 

gen h = t-1   /* h is the horizon for the IRFs */


local p = 2
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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Peru levels pc")  name(ramey, replace) ///
note("Upper Left: Education, GG; Upper right: Health, GG; Lower left: Social Protection, GG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Peru_PC_lv.pdf", name(ramey) replace



/*******************************************************************************
**  LP fist difference per capita estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==17
keep if year <= 2019
tsset year
gen t = _n

summarize 

gen lcp1 = log(commprice1)
gen lsp1 = log(percapita_education_GG)
gen lsp2 = log(percapita_health_GG)
gen lsp3 = log(percapita_socialprot_GG)

gen cp1 = D.lcp1
gen sp1 = D.lsp1
gen sp2 = D.lsp2
gen sp3 = D.lsp3

foreach var in cp1 sp1 sp2 sp3 { 

  quietly gen b`var' = .
  quietly gen up95b`var' = .
  quietly gen lo95b`var' = .
  
} 

gen h = t-1   /* h is the horizon for the IRFs */


local p = 2
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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Peru 1.Diff pc")  name(ramey, replace) ///
note("Upper Left: Education, GG; Upper right: Health, GG; Lower left: Social Protection, GG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Peru_PC_diff.pdf", name(ramey) replace


/*******************************************************************************
**  LP levels percentage of GDP estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==17
keep if year <= 2019
tsset year
gen t = _n

summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percent_education_GG)
gen sp2 = log(percent_health_GG)
gen sp3 = log(percent_socialprot_GG)


foreach var in cp1 sp1 sp2 sp3 { 

  quietly gen b`var' = .
  quietly gen up95b`var' = .
  quietly gen lo95b`var' = .
  
} 

gen h = t-1   /* h is the horizon for the IRFs */


local p = 2
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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Peru Level %")  name(ramey, replace) ///
note("Upper Left: Education, GG; Upper right: Health, GG; Lower left: Social Protection, GG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Peru_Ptg_lv.pdf", name(ramey) replace



/*******************************************************************************
**  LP fist difference percentage of GDP estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==17
keep if year <= 2019
tsset year
gen t = _n

summarize 

gen lcp1 = log(commprice1)
gen lsp1 = log(percent_education_GG)
gen lsp2 = log(percent_health_GG)
gen lsp3 = log(percent_socialprot_GG)

gen cp1 = D.lcp1
gen sp1 = D.lsp1
gen sp2 = D.lsp2
gen sp3 = D.lsp3

foreach var in cp1 sp1 sp2 sp3 { 

  quietly gen b`var' = .
  quietly gen up95b`var' = .
  quietly gen lo95b`var' = .
  
} 

gen h = t-1   /* h is the horizon for the IRFs */


local p = 2
local q = 1  /* q = 0 corresponds to recursiveness assumption, q = 1 is less restrictive */


global shock cp1 

 forvalues i = 0/12 {

 foreach var in sp1 sp2 sp3 {

     newey F`i'.`var' L(0/`p').$shock  L(`q'/`p').sp1 L(`q'/`p').sp2 L(`q'/`p').sp3 , lag(`=`i' + 1')

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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Peru 1.Diff %")  name(ramey, replace) ///
note("Upper Left: Education, GG; Upper right: Health, GG; Lower left: Social Protection, GG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Peru_Ptg_diff.pdf", name(ramey) replace

********************************************************************************
********************************** URUGUAY *************************************
********************************************************************************

/*******************************************************************************
**  LP levels per capita estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==18
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


local p = 2
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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Uruguay levels pc")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Uruguay_PC_lv.pdf", name(ramey) replace



/*******************************************************************************
**  LP fist difference per capita estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==18
keep if year <= 2019
tsset year
gen t = _n

summarize 

gen lcp1 = log(commprice1)
gen lsp1 = log(percapita_education_CG)
gen lsp2 = log(percapita_health_CG)
gen lsp3 = log(percapita_socialprot_CG)

gen cp1 = D.lcp1
gen sp1 = D.lsp1
gen sp2 = D.lsp2
gen sp3 = D.lsp3

foreach var in cp1 sp1 sp2 sp3 { 

  quietly gen b`var' = .
  quietly gen up95b`var' = .
  quietly gen lo95b`var' = .
  
} 

gen h = t-1   /* h is the horizon for the IRFs */


local p = 2
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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Uruguay 1.Diff pc")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Uruguay_PC_diff.pdf", name(ramey) replace


/*******************************************************************************
**  LP levels percentage of GDP estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==18
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


local p = 2
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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Uruguay Level %")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Uruguay_Ptg_lv.pdf", name(ramey) replace



/*******************************************************************************
**  LP fist difference percentage of GDP estimation
*******************************************************************************/

use "$datapath/dataset_for_analysis.dta", clear

keep if cid==18
keep if year <= 2019
tsset year
gen t = _n

summarize 

gen lcp1 = log(commprice1)
gen lsp1 = log(percent_education_CG)
gen lsp2 = log(percent_health_CG)
gen lsp3 = log(percent_socialprot_CG)

gen cp1 = D.lcp1
gen sp1 = D.lsp1
gen sp2 = D.lsp2
gen sp3 = D.lsp3

foreach var in cp1 sp1 sp2 sp3 { 

  quietly gen b`var' = .
  quietly gen up95b`var' = .
  quietly gen lo95b`var' = .
  
} 

gen h = t-1   /* h is the horizon for the IRFs */


local p = 2
local q = 1  /* q = 0 corresponds to recursiveness assumption, q = 1 is less restrictive */


global shock cp1 

 forvalues i = 0/12 {

 foreach var in sp1 sp2 sp3 {

     newey F`i'.`var' L(0/`p').$shock  L(`q'/`p').sp1 L(`q'/`p').sp2 L(`q'/`p').sp3 , lag(`=`i' + 1')

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
  (scatter b`var' h, c(l) clp(l) ms(i) clc(black) mc(black) clw(medthick)) if h<=12, ///
  xtitle("") ytitle(`labtext') legend(off) name(vargk_`var', replace)
}
*/

set graphics on

graph combine vargk_sp1 vargk_sp2 vargk_sp3 ,title("Uruguay 1.Diff %")  name(ramey, replace) ///
note("Upper Left: Education, CG; Upper right: Health, CG; Lower left: Social Protection, CG.", size(vsmall))
graph export "$outputpath/LP_Graphs/LP_Uruguay_Ptg_diff.pdf", name(ramey) replace


