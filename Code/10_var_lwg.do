********************************************************************************
* SVAR with interaction term left wing government and commodity price
********************************************************************************

********************************************************************************
* per capita
********************************************************************************

forval i = 2/4 {

use "$datapath/dataset_for_analysis.dta", clear

tab country if cid==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
	
log using "$outputpath/logfiles_dummies/`label'_VAR_percapita_lv_CG_l1_lwg_interact.log", replace	

keep if cid==`i' 
keep if year <= 2019
tsset year

*summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percapita_education_CG)
gen sp2 = log(percapita_health_CG)
gen sp3 = log(percapita_socialprot_CG)
gen cp1lwg = cp1*lwg

* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0
constraint define 2 [cp1]L1.sp2=0
constraint define 3 [cp1]L1.sp3=0
constraint define 4 [cp1]L1.cp1lwg=0
constraint define 5 [cp1lwg]L1.sp1=0
constraint define 6 [cp1lwg]L1.sp2=0
constraint define 7 [cp1lwg]L1.sp3=0
constraint define 8 [cp1lwg]L1.cp1=0
*constraint define 5 [lwg]L1.sp1=0
*constraint define 6 [lwg]L1.sp2=0
*constraint define 7 [lwg]L1.sp3=0
constraint define 9 [lwg]L1.cp1=0

*Estimating the VAR
var cp1 cp1lwg lwg sp1 sp2 sp3, lags (1) constraints(1/9) dfk small


* Compute IRF
irf create cp1irf, step(15) bs rep(500) set(cp1irf, replace)

*grapf IRF
irf graph oirf, impulse(cp1lwg) response(sp1) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Education - Per capita, USD", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_PC_lv_education_CG_l1_lwg_interact.gph", replace

irf graph oirf, impulse(cp1lwg) response(sp2) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) //////
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Health - Per capita, USD", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_PC_lv_health_CG_l1_lwg_interact.gph", replace

irf graph oirf, impulse(cp1lwg) response(sp3) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) //////
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Social Protection - Per capita, USD", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_PC_lv_socialprot_CG_l1_lwg_interact.gph", replace


gr combine "$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_PC_lv_education_CG_l1_lwg_interact.gph" ///
"$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_PC_lv_health_CG_l1_lwg_interact.gph" ///
"$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_PC_lv_socialprot_CG_l1_lwg_interact.gph" , ///
graphregion(color(white)) row(2) ycommon title("`label'", color(black))
graph save Graph "$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_PC_lv_CG_l1_lwg_interact.gph", replace
graph export "$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_PC_lv_CG_l1_lwg_interact.png", replace

log close
}

forval i = 1/1 {

use "$datapath/dataset_for_analysis.dta", clear

tab country if cid==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
	
log using "$outputpath/logfiles_dummies/`label'_VAR_percapita_lv_CG_l1_lwg_interact.log", replace	

keep if cid==`i' 
keep if year <= 2019
tsset year

*summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percapita_education_NFPS)
gen sp2 = log(percapita_health_NFPS)
gen sp3 = log(percapita_socialprot_NFPS)
gen cp1lwg = cp1*lwg

* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0
constraint define 2 [cp1]L1.sp2=0
constraint define 3 [cp1]L1.sp3=0
constraint define 4 [cp1]L1.cp1lwg=0
constraint define 5 [cp1lwg]L1.sp1=0
constraint define 6 [cp1lwg]L1.sp2=0
constraint define 7 [cp1lwg]L1.sp3=0
constraint define 8 [cp1lwg]L1.cp1=0
*constraint define 5 [lwg]L1.sp1=0
*constraint define 6 [lwg]L1.sp2=0
*constraint define 7 [lwg]L1.sp3=0
constraint define 9 [lwg]L1.cp1=0

*Estimating the VAR
var cp1 cp1lwg lwg sp1 sp2 sp3, lags (1) constraints(1/9) dfk small

* Compute IRF
irf create cp1irf, step(15) bs rep(500) set(cp1irf, replace)

*grapf IRF
irf graph oirf, impulse(cp1lwg) response(sp1) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Education - Per capita, USD", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_PC_lv_education_NFPS_l1_lwg_interact.gph", replace

irf graph oirf, impulse(cp1lwg) response(sp2) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) //////
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Health - Per capita, USD", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_PC_lv_health_NFPS_l1_lwg_interact.gph", replace

irf graph oirf, impulse(cp1lwg) response(sp3) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) //////
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Social Protection - Per capita, USD", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_PC_lv_socialprot_NFPS_l1_lwg_interact.gph", replace

gr combine "$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_PC_lv_education_NFPS_l1_lwg_interact.gph" ///
"$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_PC_lv_health_NFPS_l1_lwg_interact.gph" ///
"$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_PC_lv_socialprot_NFPS_l1_lwg_interact.gph" , ///
graphregion(color(white)) row(2) ycommon title("`label'", color(black))
graph save Graph "$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_PC_lv_NFPS_l1_lwg_interact.gph", replace
graph export "$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_PC_lv_NFPS_l1_lwg_interact.png", replace

log close
}

forval i = 1/1 {

use "$datapath/dataset_for_analysis.dta", clear

tab country if cid==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
	
log using "$outputpath/logfiles_dummies/`label'_VAR_percapita_lv_CG_l1_lwg.log", replace	

keep if cid==`i' 
keep if year <= 2019
tsset year

*summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percapita_education_NFPS)
gen sp2 = log(percapita_health_NFPS)
gen sp3 = log(percapita_socialprot_NFPS)
gen cp1lwg = cp1*lwg

* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0
constraint define 2 [cp1]L1.sp2=0
constraint define 3 [cp1]L1.sp3=0
constraint define 4 [cp1]L1.cp1lwg=0
constraint define 5 [cp1lwg]L1.sp1=0
constraint define 6 [cp1lwg]L1.sp2=0
constraint define 7 [cp1lwg]L1.sp3=0
constraint define 8 [cp1lwg]L1.cp1=0
*constraint define 5 [lwg]L1.sp1=0
*constraint define 6 [lwg]L1.sp2=0
*constraint define 7 [lwg]L1.sp3=0
constraint define 9 [lwg]L1.cp1=0

*Estimating the VAR
var cp1 cp1lwg lwg sp1 sp2 sp3, lags (1) constraints(1/9) dfk small

* Compute IRF
irf create cp1irf, step(15) bs rep(500) set(cp1irf, replace)

*grapf IRF
irf graph oirf, impulse(cp1lwg) response(sp1) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Education - Per capita, USD", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_PC_lv_education_NFPS_l1_lwg.gph", replace

irf graph oirf, impulse(cp1lwg) response(sp2) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) //////
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Health - Per capita, USD", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_PC_lv_health_NFPS_l1_lwg.gph", replace

irf graph oirf, impulse(cp1lwg) response(sp3) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) //////
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Social Protection - Per capita, USD", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_PC_lv_socialprot_NFPS_l1_lwg.gph", replace

gr combine "$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_PC_lv_education_NFPS_l1_lwg.gph" ///
"$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_PC_lv_health_NFPS_l1_lwg.gph" ///
"$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_PC_lv_socialprot_NFPS_l1_lwg.gph" , ///
graphregion(color(white)) row(2) ycommon title("`label'", color(black))
graph save Graph "$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_PC_lv_NFPS_l1_lwg.gph", replace
graph export "$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_PC_lv_NFPS_l1_lwg.png", replace

log close
}


forval i = 8/8 {

use "$datapath/dataset_for_analysis.dta", clear

tab country if cid==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
	
log using "$outputpath/logfiles_dummies/`label'_VAR_percapita_lv_CG_l1_lwg_interact.log", replace	

keep if cid==`i' 
keep if year <= 2019
tsset year

*summarize 

rename percapita_CGold_SOCIALPROT percapita_CGold_SOCIALPROT
gen percapita_education_CGold = real(percapita_CGold_EDUCATION)
gen percapita_health_CGold = real(percapita_CGold_HEALTH)
gen percapita_socialprot_CGold = real(percapita_CGold_SOCIALPROT)

gen cp1 = log(commprice1)
gen sp1 = log(percapita_education_CGold)
gen sp2 = log(percapita_health_CGold)
gen sp3 = log(percapita_socialprot_CGold)
gen cp1lwg = cp1*lwg

* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0
constraint define 2 [cp1]L1.sp2=0
constraint define 3 [cp1]L1.sp3=0
constraint define 4 [cp1]L1.cp1lwg=0
constraint define 5 [cp1lwg]L1.sp1=0
constraint define 6 [cp1lwg]L1.sp2=0
constraint define 7 [cp1lwg]L1.sp3=0
constraint define 8 [cp1lwg]L1.cp1=0
*constraint define 5 [lwg]L1.sp1=0
*constraint define 6 [lwg]L1.sp2=0
*constraint define 7 [lwg]L1.sp3=0
constraint define 9 [lwg]L1.cp1=0

*Estimating the VAR
var cp1 cp1lwg lwg sp1 sp2 sp3, lags (1) constraints(1/9) dfk small


* Compute IRF
irf create cp1irf, step(15) bs rep(500) set(cp1irf, replace)

*grapf IRF
irf graph oirf, impulse(cp1lwg) response(sp1) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Education - Per capita, USD", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_PC_lv_education_CGold_l1_lwg_interact.gph", replace

irf graph oirf, impulse(cp1lwg) response(sp2) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) //////
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Health - Per capita, USD", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_PC_lv_health_CGold_l1_lwg_interact.gph", replace

irf graph oirf, impulse(cp1lwg) response(sp3) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) //////
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Social Protection - Per capita, USD", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_PC_lv_socialprot_CGold_l1_lwg_interact.gph", replace


gr combine "$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_PC_lv_education_CGold_l1_lwg_interact.gph" ///
"$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_PC_lv_health_CGold_l1_lwg_interact.gph" ///
"$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_PC_lv_socialprot_CGold_l1_lwg_interact.gph" , ///
graphregion(color(white)) row(2) ycommon title("`label'", color(black))
graph save Graph "$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_PC_lv_CGold_l1_lwg_interact.gph", replace
graph export "$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_PC_lv_CGold_l1_lwg_interact.png", replace

log close
}

forval i = 17/17 {

use "$datapath/dataset_for_analysis.dta", clear

tab country if cid==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
	
log using "$outputpath/logfiles_dummies/`label'_VAR_percapita_lv_CG_l1_lwg_interact.log", replace		

keep if cid==`i' 
keep if year <= 2019
tsset year

*summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percapita_education_GG)
gen sp2 = log(percapita_health_GG)
gen sp3 = log(percapita_socialprot_GG)
gen cp1lwg = cp1*lwg

* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0
constraint define 2 [cp1]L1.sp2=0
constraint define 3 [cp1]L1.sp3=0
constraint define 4 [cp1]L1.cp1lwg=0
constraint define 5 [cp1lwg]L1.sp1=0
constraint define 6 [cp1lwg]L1.sp2=0
constraint define 7 [cp1lwg]L1.sp3=0
constraint define 8 [cp1lwg]L1.cp1=0
*constraint define 5 [lwg]L1.sp1=0
*constraint define 6 [lwg]L1.sp2=0
*constraint define 7 [lwg]L1.sp3=0
constraint define 9 [lwg]L1.cp1=0

*Estimating the VAR
var cp1 cp1lwg lwg sp1 sp2 sp3, lags (1) constraints(1/9) dfk small

* Compute IRF
irf create cp1irf, step(15) bs rep(500) set(cp1irf, replace)

*grapf IRF
irf graph oirf, impulse(cp1lwg) response(sp1) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Education - Per capita, USD", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_PC_lv_education_GG_l1_lwg_interact.gph", replace

irf graph oirf, impulse(cp1lwg) response(sp2) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) //////
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Health - Per capita, USD", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_PC_lv_health_GG_l1_lwg_interact.gph", replace

irf graph oirf, impulse(cp1lwg) response(sp3) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) //////
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Social Protection - Per capita, USD", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_PC_lv_socialprot_GG_l1_lwg_interact.gph", replace

gr combine "$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_PC_lv_education_GG_l1_lwg_interact.gph" ///
"$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_PC_lv_health_GG_l1_lwg_interact.gph" ///
"$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_PC_lv_socialprot_GG_l1_lwg_interact.gph" , ///
graphregion(color(white)) row(2) ycommon title("`label'", color(black))
graph save Graph "$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_PC_lv_GG_l1_lwg_interact.gph", replace
graph export "$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_PC_lv_GG_l1_lwg_interact.png", replace

log close
}

********************************************************************************
* percentage of GDP
********************************************************************************


forval i = 2/4 {

use "$datapath/dataset_for_analysis.dta", clear

tab country if cid==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
	
log using "$outputpath/logfiles_dummies/`label'_VAR_percent_lv_CG_l1_lwg_interact.log", replace		

keep if cid==`i' 
keep if year <= 2019
tsset year

*summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percent_education_CG)
gen sp2 = log(percent_health_CG)
gen sp3 = log(percent_socialprot_CG)
gen cp1lwg = cp1*lwg

* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0
constraint define 2 [cp1]L1.sp2=0
constraint define 3 [cp1]L1.sp3=0
constraint define 4 [cp1]L1.cp1lwg=0
constraint define 5 [cp1lwg]L1.sp1=0
constraint define 6 [cp1lwg]L1.sp2=0
constraint define 7 [cp1lwg]L1.sp3=0
constraint define 8 [cp1lwg]L1.cp1=0
*constraint define 5 [lwg]L1.sp1=0
*constraint define 6 [lwg]L1.sp2=0
*constraint define 7 [lwg]L1.sp3=0
constraint define 9 [lwg]L1.cp1=0

*Estimating the VAR
var cp1 cp1lwg lwg sp1 sp2 sp3, lags (1) constraints(1/9) dfk small


* Compute IRF
irf create cp1irf, step(15) bs rep(500) set(cp1irf, replace)

*grapf IRF
irf graph oirf, impulse(cp1lwg) response(sp1) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Education - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_Perc_lv_education_CG_l1_lwg_interact.gph", replace

irf graph oirf, impulse(cp1lwg) response(sp2) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) //////
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Health - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_Perc_lv_health_CG_l1_lwg_interact.gph", replace

irf graph oirf, impulse(cp1lwg) response(sp3) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) //////
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Social Protection - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_Perc_lv_socialprot_CG_l1_lwg_interact.gph", replace


gr combine "$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_Perc_lv_education_CG_l1_lwg_interact.gph" ///
"$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_Perc_lv_health_CG_l1_lwg_interact.gph" ///
"$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_Perc_lv_socialprot_CG_l1_lwg_interact.gph" , ///
graphregion(color(white)) row(2) ycommon title("`label'", color(black))
graph save Graph "$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_Perc_lv_CG_l1_lwg_interact.gph", replace
graph export "$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_Perc_lv_CG_l1_lwg_interact.png", replace

log close
}

forval i = 1/1 {

use "$datapath/dataset_for_analysis.dta", clear

tab country if cid==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
	
log using "$outputpath/logfiles_dummies/`label'_VAR_percent_lv_CG_l1_lwg_interact.log", replace

keep if cid==`i' 
keep if year <= 2019
tsset year

*summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percent_education_NFPS)
gen sp2 = log(percent_health_NFPS)
gen sp3 = log(percent_socialprot_NFPS)
gen cp1lwg = cp1*lwg

* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0
constraint define 2 [cp1]L1.sp2=0
constraint define 3 [cp1]L1.sp3=0
constraint define 4 [cp1]L1.cp1lwg=0
constraint define 5 [cp1lwg]L1.sp1=0
constraint define 6 [cp1lwg]L1.sp2=0
constraint define 7 [cp1lwg]L1.sp3=0
constraint define 8 [cp1lwg]L1.cp1=0
*constraint define 5 [lwg]L1.sp1=0
*constraint define 6 [lwg]L1.sp2=0
*constraint define 7 [lwg]L1.sp3=0
constraint define 9 [lwg]L1.cp1=0

*Estimating the VAR
var cp1 cp1lwg lwg sp1 sp2 sp3, lags (1) constraints(1/9) dfk small



* Compute IRF
irf create cp1irf, step(15) bs rep(500) set(cp1irf, replace)

*grapf IRF
irf graph oirf, impulse(cp1lwg) response(sp1) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Education - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_Perc_lv_education_NFPS_l1_lwg_interact.gph", replace

irf graph oirf, impulse(cp1lwg) response(sp2) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) //////
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Health - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_Perc_lv_health_NFPS_l1_lwg_interact.gph", replace

irf graph oirf, impulse(cp1lwg) response(sp3) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) //////
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Social Protection - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_Perc_lv_socialprot_NFPS_l1_lwg_interact.gph", replace


gr combine "$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_Perc_lv_education_NFPS_l1_lwg_interact.gph" ///
"$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_Perc_lv_health_NFPS_l1_lwg_interact.gph" ///
"$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_Perc_lv_socialprot_NFPS_l1_lwg_interact.gph" , ///
graphregion(color(white)) row(2) ycommon title("`label'", color(black))
graph save Graph "$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_Perc_lv_NFPS_l1_lwg_interact.gph", replace
graph export "$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_Perc_lv_NFPS_l1_lwg_interact.png", replace

log close
}


forval i = 17/17 {

use "$datapath/dataset_for_analysis.dta", clear

tab country if cid==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
	
log using "$outputpath/logfiles_dummies/`label'_VAR_percent_lv_CG_l1_lwg_interact.log", replace

keep if cid==`i' 
keep if year <= 2019
tsset year

*summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percent_education_GG)
gen sp2 = log(percent_health_GG)
gen sp3 = log(percent_socialprot_GG)
gen cp1lwg = cp1*lwg

* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0
constraint define 2 [cp1]L1.sp2=0
constraint define 3 [cp1]L1.sp3=0
constraint define 4 [cp1]L1.cp1lwg=0
constraint define 5 [cp1lwg]L1.sp1=0
constraint define 6 [cp1lwg]L1.sp2=0
constraint define 7 [cp1lwg]L1.sp3=0
constraint define 8 [cp1lwg]L1.cp1=0
*constraint define 5 [lwg]L1.sp1=0
*constraint define 6 [lwg]L1.sp2=0
*constraint define 7 [lwg]L1.sp3=0
constraint define 9 [lwg]L1.cp1=0

*Estimating the VAR
var cp1 cp1lwg lwg sp1 sp2 sp3, lags (1) constraints(1/9) dfk small

* Compute IRF
irf create cp1irf, step(15) bs rep(500) set(cp1irf, replace)

*grapf IRF
irf graph oirf, impulse(cp1lwg) response(sp1) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Education - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_Perc_lv_education_GG_l1_lwg_interact.gph", replace

irf graph oirf, impulse(cp1lwg) response(sp2) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) //////
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Health - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_Perc_lv_health_GG_l1_lwg_interact.gph", replace

irf graph oirf, impulse(cp1lwg) response(sp3) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) //////
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Social Protection - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_Perc_lv_socialprot_GG_l1_lwg_interact.gph", replace


gr combine "$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_Perc_lv_education_GG_l1_lwg_interact.gph" ///
"$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_Perc_lv_health_GG_l1_lwg_interact.gph" ///
"$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_Perc_lv_socialprot_GG_l1_lwg_interact.gph" , ///
graphregion(color(white)) row(2) ycommon title("`label'", color(black))
graph save Graph "$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_Perc_lv_GG_l1_lwg_interact.gph", replace
graph export "$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_Perc_lv_GG_l1_lwg_interact.png", replace

log close
}


forval i = 8/8 {

use "$datapath/dataset_for_analysis.dta", clear

tab country if cid==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
	
log using "$outputpath/logfiles_dummies/`label'_VAR_percent_lv_CG_l1_lwg_interact.log", replace

keep if cid==`i' 
keep if year <= 2019
tsset year

*summarize 

rename percentpercent_CGold_SOCIALPROT percent_CGold_SOCIALPROT
gen percent_education_CGold = real(percent_CGold_EDUCATION)
gen percent_health_CGold = real(percent_CGold_HEALTH)
gen percent_socialprot_CGold = real(percent_CGold_SOCIALPROT)

gen cp1 = log(commprice1)
gen sp1 = log(percent_education_CGold)
gen sp2 = log(percent_health_CGold)
gen sp3 = log(percent_socialprot_CGold)
gen cp1lwg = cp1*lwg

* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0
constraint define 2 [cp1]L1.sp2=0
constraint define 3 [cp1]L1.sp3=0
constraint define 4 [cp1]L1.cp1lwg=0
constraint define 5 [cp1lwg]L1.sp1=0
constraint define 6 [cp1lwg]L1.sp2=0
constraint define 7 [cp1lwg]L1.sp3=0
constraint define 8 [cp1lwg]L1.cp1=0
*constraint define 5 [lwg]L1.sp1=0
*constraint define 6 [lwg]L1.sp2=0
*constraint define 7 [lwg]L1.sp3=0
constraint define 9 [lwg]L1.cp1=0

*Estimating the VAR
var cp1 cp1lwg lwg sp1 sp2 sp3, lags (1) constraints(1/9) dfk small


* Compute IRF
irf create cp1irf, step(15) bs rep(500) set(cp1irf, replace)

*grapf IRF
irf graph oirf, impulse(cp1lwg) response(sp1) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Education - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_Perc_lv_education_CGold_l1_lwg_interact.gph", replace

irf graph oirf, impulse(cp1lwg) response(sp2) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) //////
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Health - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_Perc_lv_health_CGold_l1_lwg_interact.gph", replace

irf graph oirf, impulse(cp1lwg) response(sp3) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) //////
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Social Protection - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_Perc_lv_socialprot_CGold_l1_lwg_interact.gph", replace


gr combine "$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_Perc_lv_education_CGold_l1_lwg_interact.gph" ///
"$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_Perc_lv_health_CGold_l1_lwg_interact.gph" ///
"$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_Perc_lv_socialprot_CGold_l1_lwg_interact.gph" , ///
graphregion(color(white)) row(2) ycommon title("`label'", color(black))
graph save Graph "$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_Perc_lv_CGold_l1_lwg_interact.gph", replace
graph export "$outputpath/VAR_Graphs/VAR_Graphs_Dummies/`label'_VAR_Perc_lv_CGold_l1_lwg_interact.png", replace

log close
}

