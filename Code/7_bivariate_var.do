********************************************************************************
*Estimation of the SVARS and IRFs for per capita spending for health, social protection and education separately (only boom countries)
********************************************************************************

********************************************************************************
*Education: 
********************************************************************************

*Bolivia, Brazil, Chile, Colombia, Mexico
cd "$outputpath"

foreach i of numlist 2 3 4 5 13 {

use "$datapath/dataset_for_analysis.dta", clear

tab country if cid==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
	
log using "$outputpath/logfiles_loops/`label'_VAR_percapita_lv_education_CG_l1_bivariate.log", replace	

keep if cid==`i' 
keep if year <= 2019
tsset year

*summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percapita_education_CG)

* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0

varsoc cp1 sp1, maxlag(2)

*Estimating the VAR
var cp1 sp1, lags (1) constraints(1/1) dfk small

*Test if the VAR is stable
varstable
matrix b=r(Modulus)
putexcel set stability_percapita, sheet("`label'", replace) modify 
putexcel A2 = matrix(b),  nformat(number_d2) 

*Correlation between variables of the VAR
vargranger

*test for autocorrelation
varlmar, mlag(1)
matrix l=r(lm)
putexcel set lm_percapita, sheet("`label'", replace) modify 
putexcel A2 = matrix(l),  nformat(number_d2) 

* Compute IRF
irf create cp1irf, step(15) bs rep(500) set(cp1irf, replace)

*grapf IRF
irf graph oirf, impulse(cp1) response(sp1) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Education - Per capita, USD", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_education_CG_l1_bivariate.gph", replace
graph export "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_education_CG_l1_bivariate.png", replace

log close
}

*Ecuador CG data from 1990-2015

forval i = 8/8 {

use "$datapath/dataset_for_analysis.dta", clear

tab country if cid==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"

log using "$outputpath/logfiles_loops/`label'_VAR_PC_lv_education_CGold_l1_bivariate.log", replace	

keep if cid==`i' 
keep if year <= 2019
tsset year

summarize 

gen percapita_education_CGold = percapita_CGold_EDUCATION


gen cp1 = log(commprice1)
gen sp1 = log(percapita_education_CGold)


* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0

	
*Estimating the VAR
var cp1 sp1, lags (1) constraints(1/1) dfk small

*Test if the VAR is stable
varstable
matrix b=r(Modulus)
putexcel set stability_percapita, sheet("`label'", replace) modify 
putexcel A2 = matrix(b),  nformat(number_d2) 

*Correlation between variables of the VAR
vargranger

*test for autocorrelation
varlmar, mlag(1)
matrix l=r(lm)
putexcel set lm_percapita, sheet("`label'", replace) modify 
putexcel A2 = matrix(l),  nformat(number_d2) 

* Compute IRF
irf create cp1irf, step(15) bs rep(500) set(cp1irf, replace)

*grapf IRF
irf graph oirf, impulse(cp1) response(sp1) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) //////
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Education - Per capita, USD", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_education_CGold_l1_bivariate.gph", replace
graph export "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_education_CGold_l1_bivariate.png", replace

log close
}


*Peru GG
forval i = 17/17 {


use "$datapath/dataset_for_analysis.dta", clear

tab country if cid==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
	
log using "$outputpath/logfiles_loops/`label'_VAR_percapita_lv_education_GG_l1_bivariate.log", replace	

keep if cid==`i' 
keep if year <= 2019
tsset year

*summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percapita_education_GG)

* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0

varsoc cp1 sp1, maxlag(2)

*Estimating the VAR
var cp1 sp1, lags (1) constraints(1/1) dfk small

*Test if the VAR is stable
varstable
matrix b=r(Modulus)
putexcel set stability_percapita, sheet("`label'", replace) modify 
putexcel A2 = matrix(b),  nformat(number_d2) 

*Correlation between variables of the VAR
vargranger

*test for autocorrelation
varlmar, mlag(1)
matrix l=r(lm)
putexcel set lm_percapita, sheet("`label'", replace) modify 
putexcel A2 = matrix(l),  nformat(number_d2) 

* Compute IRF
irf create cp1irf, step(15) bs rep(500) set(cp1irf, replace)

*grapf IRF
irf graph oirf, impulse(cp1) response(sp1) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Education - Per capita, USD", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_education_GG_l1_bivariate.gph", replace
graph export "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_education_GG_l1_bivariate.png", replace

log close
}

**** Argentina NFPS ****

forval i = 1/1 {

use "$datapath/dataset_for_analysis.dta", clear

tab country if cid==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
	
log using "$outputpath/logfiles_loops/`label'_VAR_percapita_lv_education_NFPS_l1_bivariate.log", replace	

keep if cid==`i' 
keep if year <= 2019
tsset year

*summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percapita_education_NFPS)

* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0

varsoc cp1 sp1, maxlag(2)

*Estimating the VAR
var cp1 sp1, lags (1) constraints(1/1) dfk small

*Test if the VAR is stable
varstable
matrix b=r(Modulus)
putexcel set stability_percapita, sheet("`label'", replace) modify 
putexcel A2 = matrix(b),  nformat(number_d2) 

*Correlation between variables of the VAR
vargranger

*test for autocorrelation
varlmar, mlag(1)
matrix l=r(lm)
putexcel set lm_percapita, sheet("`label'", replace) modify 
putexcel A2 = matrix(l),  nformat(number_d2) 

* Compute IRF
irf create cp1irf, step(15) bs rep(500) set(cp1irf, replace)

*grapf IRF
irf graph oirf, impulse(cp1) response(sp1) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Education - Per capita, USD", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_education_NFPS_l1_bivariate.gph", replace
graph export "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_education_NFPS_l1_bivariate.png", replace

log close
}


********************************************************************************
*Health: 
********************************************************************************

*Bolivia, Brazil, Chile, Colombia, Mexico
cd "$outputpath"

foreach i of numlist 2 3 4 5 13 {

use "$datapath/dataset_for_analysis.dta", clear

tab country if cid==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
	
log using "$outputpath/logfiles_loops/`label'_VAR_percapita_lv_health_CG_l1_bivariate.log", replace	

keep if cid==`i' 
keep if year <= 2019
tsset year

*summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percapita_health_CG)

* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0

varsoc cp1 sp1, maxlag(2)

*Estimating the VAR
var cp1 sp1, lags (1) constraints(1/1) dfk small

*Test if the VAR is stable
varstable
matrix b=r(Modulus)
putexcel set stability_percapita, sheet("`label'", replace) modify 
putexcel A2 = matrix(b),  nformat(number_d2) 

*Correlation between variables of the VAR
vargranger

*test for autocorrelation
varlmar, mlag(1)
matrix l=r(lm)
putexcel set lm_percapita, sheet("`label'", replace) modify 
putexcel A2 = matrix(l),  nformat(number_d2) 

* Compute IRF
irf create cp1irf, step(15) bs rep(500) set(cp1irf, replace)

*grapf IRF
irf graph oirf, impulse(cp1) response(sp1) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Health - Per capita, USD", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_health_CG_l1_bivariate.gph", replace
graph export "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_health_CG_l1_bivariate.png", replace

log close
}

*Ecuador CG data from 1990-2015

forval i = 8/8 {

use "$datapath/dataset_for_analysis.dta", clear

tab country if cid==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"

log using "$outputpath/logfiles_loops/`label'_VAR_PC_lv_health_CGold_l1_bivariate.log", replace	

keep if cid==`i' 
keep if year <= 2019
tsset year

summarize 

gen percapita_health_CGold = percapita_CGold_HEALTH


gen cp1 = log(commprice1)
gen sp1 = log(percapita_health_CGold)


* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0

	
*Estimating the VAR
var cp1 sp1, lags (1) constraints(1/1) dfk small

*Test if the VAR is stable
varstable
matrix b=r(Modulus)
putexcel set stability_percapita, sheet("`label'", replace) modify 
putexcel A2 = matrix(b),  nformat(number_d2) 

*Correlation between variables of the VAR
vargranger

*test for autocorrelation
varlmar, mlag(1)
matrix l=r(lm)
putexcel set lm_percapita, sheet("`label'", replace) modify 
putexcel A2 = matrix(l),  nformat(number_d2) 

* Compute IRF
irf create cp1irf, step(15) bs rep(500) set(cp1irf, replace)

*grapf IRF
irf graph oirf, impulse(cp1) response(sp1) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) //////
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Health - Per capita, USD", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_health_CGold_l1_bivariate.gph", replace
graph export "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_health_CGold_l1_bivariate.png", replace

log close
}


*Peru GG
forval i = 17/17 {


use "$datapath/dataset_for_analysis.dta", clear

tab country if cid==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
	
log using "$outputpath/logfiles_loops/`label'_VAR_percapita_lv_health_GG_l1_bivariate.log", replace	

keep if cid==`i' 
keep if year <= 2019
tsset year

*summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percapita_health_GG)

* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0

varsoc cp1 sp1, maxlag(2)

*Estimating the VAR
var cp1 sp1, lags (1) constraints(1/1) dfk small

*Test if the VAR is stable
varstable
matrix b=r(Modulus)
putexcel set stability_percapita, sheet("`label'", replace) modify 
putexcel A2 = matrix(b),  nformat(number_d2) 

*Correlation between variables of the VAR
vargranger

*test for autocorrelation
varlmar, mlag(1)
matrix l=r(lm)
putexcel set lm_percapita, sheet("`label'", replace) modify 
putexcel A2 = matrix(l),  nformat(number_d2) 

* Compute IRF
irf create cp1irf, step(15) bs rep(500) set(cp1irf, replace)

*grapf IRF
irf graph oirf, impulse(cp1) response(sp1) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Health - Per capita, USD", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_health_GG_l1_bivariate.gph", replace
graph export "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_health_GG_l1_bivariate.png", replace

log close
}

**** Argentina NFPS ****

forval i = 1/1 {

use "$datapath/dataset_for_analysis.dta", clear

tab country if cid==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
	
log using "$outputpath/logfiles_loops/`label'_VAR_percapita_lv_health_NFPS_l1_bivariate.log", replace	

keep if cid==`i' 
keep if year <= 2019
tsset year

*summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percapita_health_NFPS)

* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0

varsoc cp1 sp1, maxlag(2)

*Estimating the VAR
var cp1 sp1, lags (1) constraints(1/1) dfk small

*Test if the VAR is stable
varstable
matrix b=r(Modulus)
putexcel set stability_percapita, sheet("`label'", replace) modify 
putexcel A2 = matrix(b),  nformat(number_d2) 

*Correlation between variables of the VAR
vargranger

*test for autocorrelation
varlmar, mlag(1)
matrix l=r(lm)
putexcel set lm_percapita, sheet("`label'", replace) modify 
putexcel A2 = matrix(l),  nformat(number_d2) 

* Compute IRF
irf create cp1irf, step(15) bs rep(500) set(cp1irf, replace)

*grapf IRF
irf graph oirf, impulse(cp1) response(sp1) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Health - Per capita, USD", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_health_NFPS_l1_bivariate.gph", replace
graph export "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_health_NFPS_l1_bivariate.png", replace

log close
}


********************************************************************************
*Social Protection: 
********************************************************************************

*Bolivia, Brazil, Chile, Colombia, Mexico
cd "$outputpath"

foreach i of numlist 2 3 4 5 13 {

use "$datapath/dataset_for_analysis.dta", clear

tab country if cid==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
	
log using "$outputpath/logfiles_loops/`label'_VAR_percapita_lv_socialprot_CG_l1_bivariate.log", replace	

keep if cid==`i' 
keep if year <= 2019
tsset year

*summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percapita_socialprot_CG)

* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0

varsoc cp1 sp1, maxlag(2)

*Estimating the VAR
var cp1 sp1, lags (1) constraints(1/1) dfk small

*Test if the VAR is stable
varstable
matrix b=r(Modulus)
putexcel set stability_percapita, sheet("`label'", replace) modify 
putexcel A2 = matrix(b),  nformat(number_d2) 

*Correlation between variables of the VAR
vargranger

*test for autocorrelation
varlmar, mlag(1)
matrix l=r(lm)
putexcel set lm_percapita, sheet("`label'", replace) modify 
putexcel A2 = matrix(l),  nformat(number_d2) 

* Compute IRF
irf create cp1irf, step(15) bs rep(500) set(cp1irf, replace)

*grapf IRF
irf graph oirf, impulse(cp1) response(sp1) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Social Protection - Per capita, USD", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_socialprot_CG_l1_bivariate.gph", replace
graph export "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_socialprot_CG_l1_bivariate.png", replace

log close
}

*Ecuador CG data from 1990-2015

forval i = 8/8 {

use "$datapath/dataset_for_analysis.dta", clear

tab country if cid==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"

log using "$outputpath/logfiles_loops/`label'_VAR_PC_lv_socialprot_CGold_l1_bivariate.log", replace	

keep if cid==`i' 
keep if year <= 2019
tsset year

summarize 

gen percapita_socialprot_CGold = percapita_CGold_SOCIALPROT


gen cp1 = log(commprice1)
gen sp1 = log(percapita_socialprot_CGold)


* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0

	
*Estimating the VAR
var cp1 sp1, lags (1) constraints(1/1) dfk small

*Test if the VAR is stable
varstable
matrix b=r(Modulus)
putexcel set stability_percapita, sheet("`label'", replace) modify 
putexcel A2 = matrix(b),  nformat(number_d2) 

*Correlation between variables of the VAR
vargranger

*test for autocorrelation
varlmar, mlag(1)
matrix l=r(lm)
putexcel set lm_percapita, sheet("`label'", replace) modify 
putexcel A2 = matrix(l),  nformat(number_d2) 

* Compute IRF
irf create cp1irf, step(15) bs rep(500) set(cp1irf, replace)

*grapf IRF
irf graph oirf, impulse(cp1) response(sp1) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) //////
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Social Protection - Per capita, USD", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_socialprot_CGold_l1_bivariate.gph", replace
graph export "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_socialprot_CGold_l1_bivariate.png", replace

log close
}


*Peru GG
forval i = 17/17 {


use "$datapath/dataset_for_analysis.dta", clear

tab country if cid==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
	
log using "$outputpath/logfiles_loops/`label'_VAR_percapita_lv_socialprot_GG_l1_bivariate.log", replace	

keep if cid==`i' 
keep if year <= 2019
tsset year

*summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percapita_socialprot_GG)

* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0

varsoc cp1 sp1, maxlag(2)

*Estimating the VAR
var cp1 sp1, lags (1) constraints(1/1) dfk small

*Test if the VAR is stable
varstable
matrix b=r(Modulus)
putexcel set stability_percapita, sheet("`label'", replace) modify 
putexcel A2 = matrix(b),  nformat(number_d2) 

*Correlation between variables of the VAR
vargranger

*test for autocorrelation
varlmar, mlag(1)
matrix l=r(lm)
putexcel set lm_percapita, sheet("`label'", replace) modify 
putexcel A2 = matrix(l),  nformat(number_d2) 

* Compute IRF
irf create cp1irf, step(15) bs rep(500) set(cp1irf, replace)

*grapf IRF
irf graph oirf, impulse(cp1) response(sp1) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Social Protection - Per capita, USD", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_socialprot_GG_l1_bivariate.gph", replace
graph export "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_socialprot_GG_l1_bivariate.png", replace

log close
}

**** Argentina NFPS ****

forval i = 1/1 {

use "$datapath/dataset_for_analysis.dta", clear

tab country if cid==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
	
log using "$outputpath/logfiles_loops/`label'_VAR_percapita_lv_socialprot_NFPS_l1_bivariate.log", replace	

keep if cid==`i' 
keep if year <= 2019
tsset year

*summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percapita_socialprot_NFPS)

* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0

varsoc cp1 sp1, maxlag(2)

*Estimating the VAR
var cp1 sp1, lags (1) constraints(1/1) dfk small

*Test if the VAR is stable
varstable
matrix b=r(Modulus)
putexcel set stability_percapita, sheet("`label'", replace) modify 
putexcel A2 = matrix(b),  nformat(number_d2) 

*Correlation between variables of the VAR
vargranger

*test for autocorrelation
varlmar, mlag(1)
matrix l=r(lm)
putexcel set lm_percapita, sheet("`label'", replace) modify 
putexcel A2 = matrix(l),  nformat(number_d2) 

* Compute IRF
irf create cp1irf, step(15) bs rep(500) set(cp1irf, replace)

*grapf IRF
irf graph oirf, impulse(cp1) response(sp1) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Social Protection - Per capita, USD", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_socialprot_NFPS_l1_bivariate.gph", replace
graph export "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_socialprot_NFPS_l1_bivariate.png", replace

log close
}


gr combine "$outputpath/VAR_Graphs/loops/Argentina_VAR_perc_lv_education_NFPS_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Argentina_VAR_perc_lv_health_NFPS_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Argentina_VAR_perc_lv_socialprot_NFPS_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Argentina_VAR_PC_lv_education_NFPS_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Argentina_VAR_PC_lv_health_NFPS_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Argentina_VAR_PC_lv_socialprot_NFPS_l1_bivariate.gph" , ///
graphregion(color(white)) row(2) ycommon title("Argentina", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/Argentina_bivariate.gph", replace
graph export "$outputpath/VAR_Graphs/loops/Argentina_bivariate.eps", replace

gr combine "$outputpath/VAR_Graphs/loops/Bolivia_VAR_perc_lv_education_CG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Bolivia_VAR_perc_lv_health_CG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Bolivia_VAR_perc_lv_socialprot_CG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Bolivia_VAR_PC_lv_education_CG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Bolivia_VAR_PC_lv_health_CG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Bolivia_VAR_PC_lv_socialprot_CG_l1_bivariate.gph" , ///
graphregion(color(white)) row(2) ycommon title("Bolivia", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/Bolivia_bivariate.gph", replace
graph export "$outputpath/VAR_Graphs/loops/Bolivia_bivariate.eps", replace

gr combine "$outputpath/VAR_Graphs/loops/Brazil_VAR_perc_lv_education_CG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Brazil_VAR_perc_lv_health_CG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Brazil_VAR_perc_lv_socialprot_CG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Brazil_VAR_PC_lv_education_CG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Brazil_VAR_PC_lv_health_CG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Brazil_VAR_PC_lv_socialprot_CG_l1_bivariate.gph" , ///
graphregion(color(white)) row(2) ycommon title("Brazil", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/Brazil_bivariate.gph", replace
graph export "$outputpath/VAR_Graphs/loops/Brazil_bivariate.eps", replace

gr combine "$outputpath/VAR_Graphs/loops/Chile_VAR_perc_lv_education_CG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Chile_VAR_perc_lv_health_CG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Chile_VAR_perc_lv_socialprot_CG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Chile_VAR_PC_lv_education_CG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Chile_VAR_PC_lv_health_CG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Chile_VAR_PC_lv_socialprot_CG_l1_bivariate.gph" , ///
graphregion(color(white)) row(2) ycommon title("Chile", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/Chile_bivariate.gph", replace
graph export "$outputpath/VAR_Graphs/loops/Chile_bivariate.eps", replace

gr combine "$outputpath/VAR_Graphs/loops/Colombia_VAR_perc_lv_education_CG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Colombia_VAR_perc_lv_health_CG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Colombia_VAR_perc_lv_socialprot_CG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Colombia_VAR_PC_lv_education_CG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Colombia_VAR_PC_lv_health_CG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Colombia_VAR_PC_lv_socialprot_CG_l1_bivariate.gph" , ///
graphregion(color(white)) row(2) ycommon title("Colombia", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/Colombia_bivariate.gph", replace
graph export "$outputpath/VAR_Graphs/loops/Colombia_bivariate.eps", replace

gr combine "$outputpath/VAR_Graphs/loops/Ecuador_VAR_perc_lv_education_CGold_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Ecuador_VAR_perc_lv_health_CGold_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Ecuador_VAR_perc_lv_socialprot_CGold_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Ecuador_VAR_PC_lv_education_CGold_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Ecuador_VAR_PC_lv_health_CGold_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Ecuador_VAR_PC_lv_socialprot_CGold_l1_bivariate.gph" , ///
graphregion(color(white)) row(2) ycommon title("Ecuador", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/Ecuador_bivariate.gph", replace
graph export "$outputpath/VAR_Graphs/loops/Ecuador_bivariate.eps", replace

gr combine "$outputpath/VAR_Graphs/loops/Mexico_VAR_perc_lv_education_CG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Mexico_VAR_perc_lv_health_CG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Mexico_VAR_perc_lv_socialprot_CG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Mexico_VAR_PC_lv_education_CG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Mexico_VAR_PC_lv_health_CG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Mexico_VAR_PC_lv_socialprot_CG_l1_bivariate.gph" , ///
graphregion(color(white)) row(2) ycommon title("Mexico", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/Mexico_bivariate.gph", replace
graph export "$outputpath/VAR_Graphs/loops/Mexico_bivariate.eps", replace

gr combine "$outputpath/VAR_Graphs/loops/Peru_VAR_perc_lv_education_GG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Peru_VAR_perc_lv_health_GG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Peru_VAR_perc_lv_socialprot_GG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Peru_VAR_PC_lv_education_GG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Peru_VAR_PC_lv_health_GG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Peru_VAR_PC_lv_socialprot_GG_l1_bivariate.gph" , ///
graphregion(color(white)) row(2) ycommon title("Peru", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/Peru_bivariate.gph", replace
graph export "$outputpath/VAR_Graphs/loops/Peru_bivariate.eps", replace


********************************************************************************
*Estimation of the SVARS and IRFs for % of GDP spending for health, social protection and education separately (only boom countries)
********************************************************************************

********************************************************************************
*Education: 
********************************************************************************

*Bolivia, Brazil, Chile, Colombia, Mexico
cd "$outputpath"

foreach i of numlist 2 3 4 5 13 {

use "$datapath/dataset_for_analysis.dta", clear

tab country if cid==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
	
log using "$outputpath/logfiles_loops/`label'_VAR_percent_lv_education_CG_l1_bivariate.log", replace	

keep if cid==`i' 
keep if year <= 2019
tsset year

*summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percent_education_CG)

* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0

varsoc cp1 sp1, maxlag(2)

*Estimating the VAR
var cp1 sp1, lags (1) constraints(1/1) dfk small

*Test if the VAR is stable
varstable
matrix b=r(Modulus)
putexcel set stability_percent, sheet("`label'", replace) modify 
putexcel A2 = matrix(b),  nformat(number_d2) 

*Correlation between variables of the VAR
vargranger

*test for autocorrelation
varlmar, mlag(1)
matrix l=r(lm)
putexcel set lm_percent, sheet("`label'", replace) modify 
putexcel A2 = matrix(l),  nformat(number_d2) 

* Compute IRF
irf create cp1irf, step(15) bs rep(500) set(cp1irf, replace)

*grapf IRF
irf graph oirf, impulse(cp1) response(sp1) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Education - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_education_CG_l1_bivariate.gph", replace
graph export "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_education_CG_l1_bivariate.png", replace

log close
}

*Ecuador CG data from 1990-2015

forval i = 8/8 {

use "$datapath/dataset_for_analysis.dta", clear

tab country if cid==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"

log using "$outputpath/logfiles_loops/`label'_VAR_percent_lv_education_CGold_l1_bivariate.log", replace	

keep if cid==`i' 
keep if year <= 2019
tsset year

summarize 

gen percent_education_CGold = percent_CGold_EDUCATION


gen cp1 = log(commprice1)
gen sp1 = log(percent_education_CGold)


* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0

	
*Estimating the VAR
var cp1 sp1, lags (1) constraints(1/1) dfk small

*Test if the VAR is stable
varstable
matrix b=r(Modulus)
putexcel set stability_percent, sheet("`label'", replace) modify 
putexcel A2 = matrix(b),  nformat(number_d2) 

*Correlation between variables of the VAR
vargranger

*test for autocorrelation
varlmar, mlag(1)
matrix l=r(lm)
putexcel set lm_percent, sheet("`label'", replace) modify 
putexcel A2 = matrix(l),  nformat(number_d2) 

* Compute IRF
irf create cp1irf, step(15) bs rep(500) set(cp1irf, replace)

*grapf IRF
irf graph oirf, impulse(cp1) response(sp1) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) //////
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Education - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_education_CGold_l1_bivariate.gph", replace
graph export "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_education_CGold_l1_bivariate.png", replace

log close
}


*Peru GG
forval i = 17/17 {


use "$datapath/dataset_for_analysis.dta", clear

tab country if cid==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
	
log using "$outputpath/logfiles_loops/`label'_VAR_percent_lv_education_GG_l1_bivariate.log", replace	

keep if cid==`i' 
keep if year <= 2019
tsset year

*summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percent_education_GG)

* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0

varsoc cp1 sp1, maxlag(2)

*Estimating the VAR
var cp1 sp1, lags (1) constraints(1/1) dfk small

*Test if the VAR is stable
varstable
matrix b=r(Modulus)
putexcel set stability_percent, sheet("`label'", replace) modify 
putexcel A2 = matrix(b),  nformat(number_d2) 

*Correlation between variables of the VAR
vargranger

*test for autocorrelation
varlmar, mlag(1)
matrix l=r(lm)
putexcel set lm_percent, sheet("`label'", replace) modify 
putexcel A2 = matrix(l),  nformat(number_d2) 

* Compute IRF
irf create cp1irf, step(15) bs rep(500) set(cp1irf, replace)

*grapf IRF
irf graph oirf, impulse(cp1) response(sp1) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Education - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_education_GG_l1_bivariate.gph", replace
graph export "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_education_GG_l1_bivariate.png", replace

log close
}

**** Argentina NFPS ****

forval i = 1/1 {

use "$datapath/dataset_for_analysis.dta", clear

tab country if cid==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
	
log using "$outputpath/logfiles_loops/`label'_VAR_percent_lv_education_NFPS_l1_bivariate.log", replace	

keep if cid==`i' 
keep if year <= 2019
tsset year

*summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percent_education_NFPS)

* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0

varsoc cp1 sp1, maxlag(2)

*Estimating the VAR
var cp1 sp1, lags (1) constraints(1/1) dfk small

*Test if the VAR is stable
varstable
matrix b=r(Modulus)
putexcel set stability_percent, sheet("`label'", replace) modify 
putexcel A2 = matrix(b),  nformat(number_d2) 

*Correlation between variables of the VAR
vargranger

*test for autocorrelation
varlmar, mlag(1)
matrix l=r(lm)
putexcel set lm_percent, sheet("`label'", replace) modify 
putexcel A2 = matrix(l),  nformat(number_d2) 

* Compute IRF
irf create cp1irf, step(15) bs rep(500) set(cp1irf, replace)

*grapf IRF
irf graph oirf, impulse(cp1) response(sp1) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Education - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_education_NFPS_l1_bivariate.gph", replace
graph export "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_education_NFPS_l1_bivariate.png", replace

log close
}


********************************************************************************
*Health: 
********************************************************************************

*Bolivia, Brazil, Chile, Colombia, Mexico
cd "$outputpath"

foreach i of numlist 2 3 4 5 13 {

use "$datapath/dataset_for_analysis.dta", clear

tab country if cid==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
	
log using "$outputpath/logfiles_loops/`label'_VAR_percent_lv_health_CG_l1_bivariate.log", replace	

keep if cid==`i' 
keep if year <= 2019
tsset year

*summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percent_health_CG)

* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0

varsoc cp1 sp1, maxlag(2)

*Estimating the VAR
var cp1 sp1, lags (1) constraints(1/1) dfk small

*Test if the VAR is stable
varstable
matrix b=r(Modulus)
putexcel set stability_percent, sheet("`label'", replace) modify 
putexcel A2 = matrix(b),  nformat(number_d2) 

*Correlation between variables of the VAR
vargranger

*test for autocorrelation
varlmar, mlag(1)
matrix l=r(lm)
putexcel set lm_percent, sheet("`label'", replace) modify 
putexcel A2 = matrix(l),  nformat(number_d2) 

* Compute IRF
irf create cp1irf, step(15) bs rep(500) set(cp1irf, replace)

*grapf IRF
irf graph oirf, impulse(cp1) response(sp1) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Health - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_health_CG_l1_bivariate.gph", replace
graph export "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_health_CG_l1_bivariate.png", replace

log close
}

*Ecuador CG data from 1990-2015

forval i = 8/8 {

use "$datapath/dataset_for_analysis.dta", clear

tab country if cid==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"

log using "$outputpath/logfiles_loops/`label'_VAR_percent_lv_health_CGold_l1_bivariate.log", replace	

keep if cid==`i' 
keep if year <= 2019
tsset year

summarize 

gen percent_health_CGold = percent_CGold_HEALTH


gen cp1 = log(commprice1)
gen sp1 = log(percent_health_CGold)


* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0

	
*Estimating the VAR
var cp1 sp1, lags (1) constraints(1/1) dfk small

*Test if the VAR is stable
varstable
matrix b=r(Modulus)
putexcel set stability_percent, sheet("`label'", replace) modify 
putexcel A2 = matrix(b),  nformat(number_d2) 

*Correlation between variables of the VAR
vargranger

*test for autocorrelation
varlmar, mlag(1)
matrix l=r(lm)
putexcel set lm_percent, sheet("`label'", replace) modify 
putexcel A2 = matrix(l),  nformat(number_d2) 

* Compute IRF
irf create cp1irf, step(15) bs rep(500) set(cp1irf, replace)

*grapf IRF
irf graph oirf, impulse(cp1) response(sp1) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) //////
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Health - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_health_CGold_l1_bivariate.gph", replace
graph export "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_health_CGold_l1_bivariate.png", replace

log close
}


*Peru GG
forval i = 17/17 {


use "$datapath/dataset_for_analysis.dta", clear

tab country if cid==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
	
log using "$outputpath/logfiles_loops/`label'_VAR_percent_lv_health_GG_l1_bivariate.log", replace	

keep if cid==`i' 
keep if year <= 2019
tsset year

*summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percent_health_GG)

* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0

varsoc cp1 sp1, maxlag(2)

*Estimating the VAR
var cp1 sp1, lags (1) constraints(1/1) dfk small

*Test if the VAR is stable
varstable
matrix b=r(Modulus)
putexcel set stability_percent, sheet("`label'", replace) modify 
putexcel A2 = matrix(b),  nformat(number_d2) 

*Correlation between variables of the VAR
vargranger

*test for autocorrelation
varlmar, mlag(1)
matrix l=r(lm)
putexcel set lm_percent, sheet("`label'", replace) modify 
putexcel A2 = matrix(l),  nformat(number_d2) 

* Compute IRF
irf create cp1irf, step(15) bs rep(500) set(cp1irf, replace)

*grapf IRF
irf graph oirf, impulse(cp1) response(sp1) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Health - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_health_GG_l1_bivariate.gph", replace
graph export "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_health_GG_l1_bivariate.png", replace

log close
}

**** Argentina NFPS ****

forval i = 1/1 {

use "$datapath/dataset_for_analysis.dta", clear

tab country if cid==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
	
log using "$outputpath/logfiles_loops/`label'_VAR_percent_lv_health_NFPS_l1_bivariate.log", replace	

keep if cid==`i' 
keep if year <= 2019
tsset year

*summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percent_health_NFPS)

* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0

varsoc cp1 sp1, maxlag(2)

*Estimating the VAR
var cp1 sp1, lags (1) constraints(1/1) dfk small

*Test if the VAR is stable
varstable
matrix b=r(Modulus)
putexcel set stability_percent, sheet("`label'", replace) modify 
putexcel A2 = matrix(b),  nformat(number_d2) 

*Correlation between variables of the VAR
vargranger

*test for autocorrelation
varlmar, mlag(1)
matrix l=r(lm)
putexcel set lm_percent, sheet("`label'", replace) modify 
putexcel A2 = matrix(l),  nformat(number_d2) 

* Compute IRF
irf create cp1irf, step(15) bs rep(500) set(cp1irf, replace)

*grapf IRF
irf graph oirf, impulse(cp1) response(sp1) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Health - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_health_NFPS_l1_bivariate.gph", replace
graph export "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_health_NFPS_l1_bivariate.png", replace

log close
}


********************************************************************************
*Social Protection: 
********************************************************************************

*Bolivia, Brazil, Chile, Colombia, Mexico
cd "$outputpath"

foreach i of numlist 2 3 4 5 13 {

use "$datapath/dataset_for_analysis.dta", clear

tab country if cid==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
	
log using "$outputpath/logfiles_loops/`label'_VAR_percent_lv_socialprot_CG_l1_bivariate.log", replace	

keep if cid==`i' 
keep if year <= 2019
tsset year

*summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percent_socialprot_CG)

* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0

varsoc cp1 sp1, maxlag(2)

*Estimating the VAR
var cp1 sp1, lags (1) constraints(1/1) dfk small

*Test if the VAR is stable
varstable
matrix b=r(Modulus)
putexcel set stability_percent, sheet("`label'", replace) modify 
putexcel A2 = matrix(b),  nformat(number_d2) 

*Correlation between variables of the VAR
vargranger

*test for autocorrelation
varlmar, mlag(1)
matrix l=r(lm)
putexcel set lm_percent, sheet("`label'", replace) modify 
putexcel A2 = matrix(l),  nformat(number_d2) 

* Compute IRF
irf create cp1irf, step(15) bs rep(500) set(cp1irf, replace)

*grapf IRF
irf graph oirf, impulse(cp1) response(sp1) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Social Protection - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_socialprot_CG_l1_bivariate.gph", replace
graph export "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_socialprot_CG_l1_bivariate.png", replace

log close
}

*Ecuador CG data from 1990-2015

forval i = 8/8 {

use "$datapath/dataset_for_analysis.dta", clear

tab country if cid==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"

log using "$outputpath/logfiles_loops/`label'_VAR_percent_lv_socialprot_CGold_l1_bivariate.log", replace	

keep if cid==`i' 
keep if year <= 2019
tsset year

summarize 

gen percent_socialprot_CGold = percent_CGold_SOCIALPROT


gen cp1 = log(commprice1)
gen sp1 = log(percent_socialprot_CGold)


* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0

	
*Estimating the VAR
var cp1 sp1, lags (1) constraints(1/1) dfk small

*Test if the VAR is stable
varstable
matrix b=r(Modulus)
putexcel set stability_percent, sheet("`label'", replace) modify 
putexcel A2 = matrix(b),  nformat(number_d2) 

*Correlation between variables of the VAR
vargranger

*test for autocorrelation
varlmar, mlag(1)
matrix l=r(lm)
putexcel set lm_percent, sheet("`label'", replace) modify 
putexcel A2 = matrix(l),  nformat(number_d2) 

* Compute IRF
irf create cp1irf, step(15) bs rep(500) set(cp1irf, replace)

*grapf IRF
irf graph oirf, impulse(cp1) response(sp1) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) //////
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Social Protection - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_socialprot_CGold_l1_bivariate.gph", replace
graph export "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_socialprot_CGold_l1_bivariate.png", replace

log close
}


*Peru GG
forval i = 17/17 {


use "$datapath/dataset_for_analysis.dta", clear

tab country if cid==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
	
log using "$outputpath/logfiles_loops/`label'_VAR_percent_lv_socialprot_GG_l1_bivariate.log", replace	

keep if cid==`i' 
keep if year <= 2019
tsset year

*summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percent_socialprot_GG)

* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0

varsoc cp1 sp1, maxlag(2)

*Estimating the VAR
var cp1 sp1, lags (1) constraints(1/1) dfk small

*Test if the VAR is stable
varstable
matrix b=r(Modulus)
putexcel set stability_percent, sheet("`label'", replace) modify 
putexcel A2 = matrix(b),  nformat(number_d2) 

*Correlation between variables of the VAR
vargranger

*test for autocorrelation
varlmar, mlag(1)
matrix l=r(lm)
putexcel set lm_percent, sheet("`label'", replace) modify 
putexcel A2 = matrix(l),  nformat(number_d2) 

* Compute IRF
irf create cp1irf, step(15) bs rep(500) set(cp1irf, replace)

*grapf IRF
irf graph oirf, impulse(cp1) response(sp1) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Social Protection - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_socialprot_GG_l1_bivariate.gph", replace
graph export "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_socialprot_GG_l1_bivariate.png", replace

log close
}

**** Argentina NFPS ****

forval i = 1/1 {

use "$datapath/dataset_for_analysis.dta", clear

tab country if cid==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
	
log using "$outputpath/logfiles_loops/`label'_VAR_percent_lv_socialprot_NFPS_l1_bivariate.log", replace	

keep if cid==`i' 
keep if year <= 2019
tsset year

*summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percent_socialprot_NFPS)

* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0

varsoc cp1 sp1, maxlag(2)

*Estimating the VAR
var cp1 sp1, lags (1) constraints(1/1) dfk small

*Test if the VAR is stable
varstable
matrix b=r(Modulus)
putexcel set stability_percent, sheet("`label'", replace) modify 
putexcel A2 = matrix(b),  nformat(number_d2) 

*Correlation between variables of the VAR
vargranger

*test for autocorrelation
varlmar, mlag(1)
matrix l=r(lm)
putexcel set lm_percent, sheet("`label'", replace) modify 
putexcel A2 = matrix(l),  nformat(number_d2) 

* Compute IRF
irf create cp1irf, step(15) bs rep(500) set(cp1irf, replace)

*grapf IRF
irf graph oirf, impulse(cp1) response(sp1) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Social Protection - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_socialprot_NFPS_l1_bivariate.gph", replace
graph export "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_socialprot_NFPS_l1_bivariate.png", replace

log close
}

gr combine "$outputpath/VAR_Graphs/loops/Argentina_VAR_perc_lv_education_NFPS_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Argentina_VAR_perc_lv_health_NFPS_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Argentina_VAR_perc_lv_socialprot_NFPS_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Argentina_VAR_PC_lv_education_NFPS_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Argentina_VAR_PC_lv_health_NFPS_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Argentina_VAR_PC_lv_socialprot_NFPS_l1_bivariate.gph" , ///
graphregion(color(white)) row(2) ycommon title("Argentina", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/Argentina_bivariate.gph", replace
graph export "$outputpath/VAR_Graphs/loops/Argentina_bivariate.eps", replace

gr combine "$outputpath/VAR_Graphs/loops/Bolivia_VAR_perc_lv_education_CG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Bolivia_VAR_perc_lv_health_CG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Bolivia_VAR_perc_lv_socialprot_CG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Bolivia_VAR_PC_lv_education_CG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Bolivia_VAR_PC_lv_health_CG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Bolivia_VAR_PC_lv_socialprot_CG_l1_bivariate.gph" , ///
graphregion(color(white)) row(2) ycommon title("Bolivia", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/Bolivia_bivariate.gph", replace
graph export "$outputpath/VAR_Graphs/loops/Bolivia_bivariate.eps", replace

gr combine "$outputpath/VAR_Graphs/loops/Brazil_VAR_perc_lv_education_CG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Brazil_VAR_perc_lv_health_CG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Brazil_VAR_perc_lv_socialprot_CG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Brazil_VAR_PC_lv_education_CG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Brazil_VAR_PC_lv_health_CG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Brazil_VAR_PC_lv_socialprot_CG_l1_bivariate.gph" , ///
graphregion(color(white)) row(2) ycommon title("Brazil", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/Brazil_bivariate.gph", replace
graph export "$outputpath/VAR_Graphs/loops/Brazil_bivariate.eps", replace

gr combine "$outputpath/VAR_Graphs/loops/Chile_VAR_perc_lv_education_CG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Chile_VAR_perc_lv_health_CG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Chile_VAR_perc_lv_socialprot_CG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Chile_VAR_PC_lv_education_CG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Chile_VAR_PC_lv_health_CG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Chile_VAR_PC_lv_socialprot_CG_l1_bivariate.gph" , ///
graphregion(color(white)) row(2) ycommon title("Chile", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/Chile_bivariate.gph", replace
graph export "$outputpath/VAR_Graphs/loops/Chile_bivariate.eps", replace

gr combine "$outputpath/VAR_Graphs/loops/Colombia_VAR_perc_lv_education_CG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Colombia_VAR_perc_lv_health_CG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Colombia_VAR_perc_lv_socialprot_CG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Colombia_VAR_PC_lv_education_CG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Colombia_VAR_PC_lv_health_CG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Colombia_VAR_PC_lv_socialprot_CG_l1_bivariate.gph" , ///
graphregion(color(white)) row(2) ycommon title("Colombia", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/Colombia_bivariate.gph", replace
graph export "$outputpath/VAR_Graphs/loops/Colombia_bivariate.eps", replace

gr combine "$outputpath/VAR_Graphs/loops/Ecuador_VAR_perc_lv_education_CGold_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Ecuador_VAR_perc_lv_health_CGold_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Ecuador_VAR_perc_lv_socialprot_CGold_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Ecuador_VAR_PC_lv_education_CGold_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Ecuador_VAR_PC_lv_health_CGold_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Ecuador_VAR_PC_lv_socialprot_CGold_l1_bivariate.gph" , ///
graphregion(color(white)) row(2) ycommon title("Ecuador", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/Ecuador_bivariate.gph", replace
graph export "$outputpath/VAR_Graphs/loops/Ecuador_bivariate.eps", replace

gr combine "$outputpath/VAR_Graphs/loops/Mexico_VAR_perc_lv_education_CG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Mexico_VAR_perc_lv_health_CG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Mexico_VAR_perc_lv_socialprot_CG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Mexico_VAR_PC_lv_education_CG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Mexico_VAR_PC_lv_health_CG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Mexico_VAR_PC_lv_socialprot_CG_l1_bivariate.gph" , ///
graphregion(color(white)) row(2) ycommon title("Mexico", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/Mexico_bivariate.gph", replace
graph export "$outputpath/VAR_Graphs/loops/Mexico_bivariate.eps", replace

gr combine "$outputpath/VAR_Graphs/loops/Peru_VAR_perc_lv_education_GG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Peru_VAR_perc_lv_health_GG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Peru_VAR_perc_lv_socialprot_GG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Peru_VAR_PC_lv_education_GG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Peru_VAR_PC_lv_health_GG_l1_bivariate.gph" ///
"$outputpath/VAR_Graphs/loops/Peru_VAR_PC_lv_socialprot_GG_l1_bivariate.gph" , ///
graphregion(color(white)) row(2) ycommon title("Peru", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/Peru_bivariate.gph", replace
graph export "$outputpath/VAR_Graphs/loops/Peru_bivariate.eps", replace






