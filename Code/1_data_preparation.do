
********************************************************************************
******************* CEPAL Social spending data *********************************
********************************************************************************

************ Spending as percentage of GDP - CENTRAL GOVERNMENT ****************

import excel "$datapath/CEPAL_Socialspending_percentageGDP.xlsx", sheet("data") firstrow clear

drop indicator unit notes_ids source_id 

rename Country__ESTANDAR country
rename Classificationofthefunctions function_spending
rename Institutionalcoverage govlevel
rename Years__ESTANDAR year
rename value spending_perc
label variable spending_perc "Public social spending as percentage of GDP"
label variable function_spending "Function of social spending"
label variable govlevel "Institutional coverage of government spending"

generate id=.
replace id=8 if country=="Argentina"
replace id=20 if country=="Belize"
replace id=24 if country=="Bolivia (Plurinational State of)"
replace id=27 if country=="Brazil"
replace id=40 if country=="Chile"
replace id=42 if country=="Colombia"
replace id=46 if country=="Costa Rica"
replace id=49 if country=="Cuba"
replace id=56 if country=="Dominican Republic"
replace id=57 if country=="Ecuador"
replace id=59 if country=="El Salvador"
replace id=78 if country=="Guatemala"
replace id=82 if country=="Haiti"
replace id=83 if country=="Honduras"
replace id=95 if country=="Jamaica"
replace id=126 if country=="Mexico"
replace id=140 if country=="Nicaragua"
replace id=148 if country=="Panama"
replace id=150 if country=="Paraguay"
replace id=151 if country=="Peru"
replace id=195 if country=="Trinidad and Tobago"
replace id=206 if country=="Uruguay"
replace id=209 if country=="Venezuela (Bolivarian Republic of)"

drop if id==.

order country id govlevel function_spending id year
sort country function_spending govlevel year

gen gov_level=.
replace gov_level=1 if govlevel=="Central government"
replace gov_level=2 if govlevel=="General government"
replace gov_level=3 if govlevel=="Nonfinancial public sector"

gen spending_type=.
replace spending_type=1 if function_spending=="Education"
replace spending_type=2 if function_spending=="Environmental protection"
replace spending_type=3 if function_spending=="Health"
replace spending_type=4 if function_spending=="Housing and community amenities"
replace spending_type=5 if function_spending=="Recreation, culture and religion"
replace spending_type=6 if function_spending=="Social expenditure"
replace spending_type=7 if function_spending=="Social protection"

drop function_spending govlevel

keep if gov_level==1
drop gov_level

reshape wide spending_perc, i(id  year) j(spending_type)

order country id year 

label variable spending_perc1 "Public social spending for EDUCATION, central government, in percent of GDP"
label variable spending_perc2 "Public social spending for ENVIRONMENTAL PROTECTION, central government, in percent of GDP"
label variable spending_perc3 "Public social spending for HEALTH, central government, in percent of GDP"
label variable spending_perc4 "Public social spending for HOUSING AND COMMUNITY AMENITIES, central government, in percent of GDP"
label variable spending_perc5 "Public social spending for RECREATION, CULTURE AND RELIGION, central government, in percent of GDP"
label variable spending_perc6 "Public social spending for SOCIAL EXPENDITURE, central government, in percent of GDP"
label variable spending_perc7 "Public social spending for SOCIAL PROTECTION, central government, in percent of GDP"

rename spending_perc1 percent_education_CG
rename spending_perc2 percent_environment_CG
rename spending_perc3 percent_health_CG
rename spending_perc4 percent_housing_CG
rename spending_perc5 percent_recreation_CG
rename spending_perc6 percent_socialexp_CG
rename spending_perc7 percent_socialprot_CG

gen percent_total_CG =.
replace percent_total_CG= percent_education_CG
replace percent_total_CG= percent_total_CG + percent_environment_CG if percent_environment_CG!=.
replace percent_total_CG= percent_total_CG + percent_health_CG if percent_health_CG!=.
replace percent_total_CG= percent_total_CG + percent_housing_CG if percent_housing_CG!=.
replace percent_total_CG= percent_total_CG + percent_recreation_CG if percent_recreation_CG!=.
replace percent_total_CG= percent_total_CG + percent_socialprot_CG if percent_socialprot_CG!=.
label variable percent_total_CG "Manual TOTAL public social spending, central government, in percent of GDP"

save "$datapath/CEPAL_spendingperc_CG.dta", replace

************ Spending as percentage of GDP - GENERAL GOVERNMENT ****************

import excel "$datapath/CEPAL_Socialspending_percentageGDP.xlsx", sheet("data") firstrow clear

drop indicator unit notes_ids source_id 

rename Country__ESTANDAR country
rename Classificationofthefunctions function_spending
rename Institutionalcoverage govlevel
rename Years__ESTANDAR year
rename value spending_perc
label variable spending_perc "Public social spending as percentage of GDP"
label variable function_spending "Function of social spending"
label variable govlevel "Institutional coverage of government spending"

generate id=.
replace id=8 if country=="Argentina"
replace id=20 if country=="Belize"
replace id=24 if country=="Bolivia (Plurinational State of)"
replace id=27 if country=="Brazil"
replace id=40 if country=="Chile"
replace id=42 if country=="Colombia"
replace id=46 if country=="Costa Rica"
replace id=49 if country=="Cuba"
replace id=56 if country=="Dominican Republic"
replace id=57 if country=="Ecuador"
replace id=59 if country=="El Salvador"
replace id=78 if country=="Guatemala"
replace id=82 if country=="Haiti"
replace id=83 if country=="Honduras"
replace id=95 if country=="Jamaica"
replace id=126 if country=="Mexico"
replace id=140 if country=="Nicaragua"
replace id=148 if country=="Panama"
replace id=150 if country=="Paraguay"
replace id=151 if country=="Peru"
replace id=195 if country=="Trinidad and Tobago"
replace id=206 if country=="Uruguay"
replace id=209 if country=="Venezuela (Bolivarian Republic of)"

drop if id==.

order country id govlevel function_spending id year
sort country function_spending govlevel year

gen gov_level=.
replace gov_level=1 if govlevel=="Central government"
replace gov_level=2 if govlevel=="General government"
replace gov_level=3 if govlevel=="Nonfinancial public sector"

gen spending_type=.
replace spending_type=1 if function_spending=="Education"
replace spending_type=2 if function_spending=="Environmental protection"
replace spending_type=3 if function_spending=="Health"
replace spending_type=4 if function_spending=="Housing and community amenities"
replace spending_type=5 if function_spending=="Recreation, culture and religion"
replace spending_type=6 if function_spending=="Social expenditure"
replace spending_type=7 if function_spending=="Social protection"

drop function_spending govlevel

keep if gov_level==2
drop gov_level

reshape wide spending_perc, i(id  year) j(spending_type)

order country id year 

label variable spending_perc1 "Public social spending for EDUCATION, general government, in percent of GDP"
label variable spending_perc2 "Public social spending for ENVIRONMENTAL PROTECTION, general government, in percent of GDP"
label variable spending_perc3 "Public social spending for HEALTH, general government, in percent of GDP"
label variable spending_perc4 "Public social spending for HOUSING AND COMMUNITY AMENITIES, general government, in percent of GDP"
label variable spending_perc5 "Public social spending for RECREATION, CULTURE AND RELIGION, general government, in percent of GDP"
label variable spending_perc6 "Public social spending for SOCIAL EXPENDITURE, general government, in percent of GDP"
label variable spending_perc7 "Public social spending for SOCIAL PROTECTION, general government, in percent of GDP"

rename spending_perc1 percent_education_GG
rename spending_perc2 percent_environment_GG
rename spending_perc3 percent_health_GG
rename spending_perc4 percent_housing_GG
rename spending_perc5 percent_recreation_GG
rename spending_perc6 percent_socialexp_GG
rename spending_perc7 percent_socialprot_GG

gen percent_total_GG =.
replace percent_total_GG= percent_education_GG
replace percent_total_GG= percent_total_GG + percent_environment_GG if percent_environment_GG!=.
replace percent_total_GG= percent_total_GG + percent_health_GG if percent_health_GG!=.
replace percent_total_GG= percent_total_GG + percent_housing_GG if percent_housing_GG!=.
replace percent_total_GG= percent_total_GG + percent_recreation_GG if percent_recreation_GG!=.
replace percent_total_GG= percent_total_GG + percent_socialprot_GG if percent_socialprot_GG!=.
label variable percent_total_GG "Manual TOTAL public social spending, general government, in percent of GDP"

save "$datapath/CEPAL_spendingperc_GG.dta", replace

************ Spending as percentage of GDP - NON-FINANCIAL PUBLIC SECTOR ****************

import excel "$datapath/CEPAL_Socialspending_percentageGDP.xlsx", sheet("data") firstrow clear

drop indicator unit notes_ids source_id 

rename Country__ESTANDAR country
rename Classificationofthefunctions function_spending
rename Institutionalcoverage govlevel
rename Years__ESTANDAR year
rename value spending_perc
label variable spending_perc "Public social spending as percentage of GDP"
label variable function_spending "Function of social spending"
label variable govlevel "Institutional coverage of government spending"

generate id=.
replace id=8 if country=="Argentina"
replace id=20 if country=="Belize"
replace id=24 if country=="Bolivia (Plurinational State of)"
replace id=27 if country=="Brazil"
replace id=40 if country=="Chile"
replace id=42 if country=="Colombia"
replace id=46 if country=="Costa Rica"
replace id=49 if country=="Cuba"
replace id=56 if country=="Dominican Republic"
replace id=57 if country=="Ecuador"
replace id=59 if country=="El Salvador"
replace id=78 if country=="Guatemala"
replace id=82 if country=="Haiti"
replace id=83 if country=="Honduras"
replace id=95 if country=="Jamaica"
replace id=126 if country=="Mexico"
replace id=140 if country=="Nicaragua"
replace id=148 if country=="Panama"
replace id=150 if country=="Paraguay"
replace id=151 if country=="Peru"
replace id=195 if country=="Trinidad and Tobago"
replace id=206 if country=="Uruguay"
replace id=209 if country=="Venezuela (Bolivarian Republic of)"

drop if id==.

order country id govlevel function_spending id year
sort country function_spending govlevel year

gen gov_level=.
replace gov_level=1 if govlevel=="Central government"
replace gov_level=2 if govlevel=="General government"
replace gov_level=3 if govlevel=="Nonfinancial public sector"

gen spending_type=.
replace spending_type=1 if function_spending=="Education"
replace spending_type=2 if function_spending=="Environmental protection"
replace spending_type=3 if function_spending=="Health"
replace spending_type=4 if function_spending=="Housing and community amenities"
replace spending_type=5 if function_spending=="Recreation, culture and religion"
replace spending_type=6 if function_spending=="Social expenditure"
replace spending_type=7 if function_spending=="Social protection"

drop function_spending govlevel

keep if gov_level==3
drop gov_level

reshape wide spending_perc, i(id  year) j(spending_type)

order country id year 

label variable spending_perc1 "Public social spending for EDUCATION, non-financial public sector, in percent of GDP"
label variable spending_perc2 "Public social spending for ENVIRONMENTAL PROTECTION, non-financial public sector, in percent of GDP"
label variable spending_perc3 "Public social spending for HEALTH, non-financial public sector, in percent of GDP"
label variable spending_perc4 "Public social spending for HOUSING AND COMMUNITY AMENITIES, non-financial public sector, in percent of GDP"
label variable spending_perc5 "Public social spending for RECREATION, CULTURE AND RELIGION, non-financial public sector, in percent of GDP"
label variable spending_perc6 "Public social spending for SOCIAL EXPENDITURE, non-financial public sector, in percent of GDP"
label variable spending_perc7 "Public social spending for SOCIAL PROTECTION, non-financial public sector, in percent of GDP"

rename spending_perc1 percent_education_NFPS
rename spending_perc2 percent_environment_NFPS
rename spending_perc3 percent_health_NFPS
rename spending_perc4 percent_housing_NFPS
rename spending_perc5 percent_recreation_NFPS
rename spending_perc6 percent_socialexp_NFPS
rename spending_perc7 percent_socialprot_NFPS

gen percent_total_NFPS =.
replace percent_total_NFPS= percent_education_NFPS
replace percent_total_NFPS= percent_total_NFPS + percent_environment_NFPS if percent_environment_NFPS!=.
replace percent_total_NFPS= percent_total_NFPS + percent_health_NFPS if percent_health_NFPS!=.
replace percent_total_NFPS= percent_total_NFPS + percent_housing_NFPS if percent_housing_NFPS!=.
replace percent_total_NFPS= percent_total_NFPS + percent_recreation_NFPS if percent_recreation_NFPS!=.
replace percent_total_NFPS= percent_total_NFPS + percent_socialprot_NFPS if percent_socialprot_NFPS!=.
label variable percent_total_NFPS "Manual TOTAL public social spending, non-financial public sector, in percent of GDP"

save "$datapath/CEPAL_spendingperc_NFPS.dta", replace

************ Spending in US Dollar - Central Government ****************

import excel "$datapath/CEPAL_Socialspending_USD.xlsx", sheet("data") firstrow clear

drop indicator unit notes_ids source_id 

rename Country__ESTANDAR country
rename Classificationofthefunctions function_spending
rename Institutionalcoverage govlevel
rename Years__ESTANDAR year
rename value spending_perc
label variable spending_perc "Public social spending in US dollars of 2010, per capita, constant"
label variable function_spending "Function of social spending"
label variable govlevel "Institutional coverage of government spending"

generate id=.
replace id=8 if country=="Argentina"
replace id=20 if country=="Belize"
replace id=24 if country=="Bolivia (Plurinational State of)"
replace id=27 if country=="Brazil"
replace id=40 if country=="Chile"
replace id=42 if country=="Colombia"
replace id=46 if country=="Costa Rica"
replace id=49 if country=="Cuba"
replace id=56 if country=="Dominican Republic"
replace id=57 if country=="Ecuador"
replace id=59 if country=="El Salvador"
replace id=78 if country=="Guatemala"
replace id=82 if country=="Haiti"
replace id=83 if country=="Honduras"
replace id=95 if country=="Jamaica"
replace id=126 if country=="Mexico"
replace id=140 if country=="Nicaragua"
replace id=148 if country=="Panama"
replace id=150 if country=="Paraguay"
replace id=151 if country=="Peru"
replace id=195 if country=="Trinidad and Tobago"
replace id=206 if country=="Uruguay"
replace id=209 if country=="Venezuela (Bolivarian Republic of)"

drop if id==.

order country id govlevel function_spending id year
sort country function_spending govlevel year

gen gov_level=.
replace gov_level=1 if govlevel=="Central government"
replace gov_level=2 if govlevel=="General government"
replace gov_level=3 if govlevel=="Nonfinancial public sector"

gen spending_type=.
replace spending_type=1 if function_spending=="Education"
replace spending_type=2 if function_spending=="Environmental protection"
replace spending_type=3 if function_spending=="Health"
replace spending_type=4 if function_spending=="Housing and community amenities"
replace spending_type=5 if function_spending=="Recreation, culture and religion"
replace spending_type=6 if function_spending=="Social expenditure"
replace spending_type=7 if function_spending=="Social protection"

drop function_spending govlevel

keep if gov_level==1
drop gov_level

reshape wide spending_perc, i(id  year) j(spending_type)

order country id year 

label variable spending_perc1 "Public social spending for EDUCATION, central government, per capita USD"
label variable spending_perc2 "Public social spending for ENVIRONMENTAL PROTECTION, central government, per capita USD"
label variable spending_perc3 "Public social spending for HEALTH, central government, per capita USD"
label variable spending_perc4 "Public social spending for HOUSING AND COMMUNITY AMENITIES, central government, per capita USD"
label variable spending_perc5 "Public social spending for RECREATION, CULTURE AND RELIGION, central government, per capita USD"
label variable spending_perc6 "Public social spending for SOCIAL EXPENDITURE, central government, per capita USD"
label variable spending_perc7 "Public social spending for SOCIAL PROTECTION, central government, per capita USD"

rename spending_perc1 percapita_education_CG
rename spending_perc2 percapita_environment_CG
rename spending_perc3 percapita_health_CG
rename spending_perc4 percapita_housing_CG
rename spending_perc5 percapita_recreation_CG
rename spending_perc6 percapita_socialexp_CG
rename spending_perc7 percapita_socialprot_CG

gen percapita_total_CG =.
replace percapita_total_CG= percapita_education_CG
replace percapita_total_CG= percapita_total_CG + percapita_environment_CG if percapita_environment_CG!=.
replace percapita_total_CG= percapita_total_CG + percapita_health_CG if percapita_health_CG!=.
replace percapita_total_CG= percapita_total_CG + percapita_housing_CG if percapita_housing_CG!=.
replace percapita_total_CG= percapita_total_CG + percapita_recreation_CG if percapita_recreation_CG!=.
replace percapita_total_CG= percapita_total_CG + percapita_socialprot_CG if percapita_socialprot_CG!=.
label variable percapita_total_CG "Manual TOTAL public social spending, central government, in percapita of GDP"

save "$datapath/CEPAL_spendingpercapita_CG.dta", replace

************ Spending percapita - GENERAL GOVERNMENT ****************

import excel "$datapath/CEPAL_Socialspending_USD.xlsx", sheet("data") firstrow clear

drop indicator unit notes_ids source_id 

rename Country__ESTANDAR country
rename Classificationofthefunctions function_spending
rename Institutionalcoverage govlevel
rename Years__ESTANDAR year
rename value spending_perc
label variable spending_perc "Public social spending as percentage of GDP"
label variable function_spending "Function of social spending"
label variable govlevel "Institutional coverage of government spending"

generate id=.
replace id=8 if country=="Argentina"
replace id=20 if country=="Belize"
replace id=24 if country=="Bolivia (Plurinational State of)"
replace id=27 if country=="Brazil"
replace id=40 if country=="Chile"
replace id=42 if country=="Colombia"
replace id=46 if country=="Costa Rica"
replace id=49 if country=="Cuba"
replace id=56 if country=="Dominican Republic"
replace id=57 if country=="Ecuador"
replace id=59 if country=="El Salvador"
replace id=78 if country=="Guatemala"
replace id=82 if country=="Haiti"
replace id=83 if country=="Honduras"
replace id=95 if country=="Jamaica"
replace id=126 if country=="Mexico"
replace id=140 if country=="Nicaragua"
replace id=148 if country=="Panama"
replace id=150 if country=="Paraguay"
replace id=151 if country=="Peru"
replace id=195 if country=="Trinidad and Tobago"
replace id=206 if country=="Uruguay"
replace id=209 if country=="Venezuela (Bolivarian Republic of)"

drop if id==.

order country id govlevel function_spending id year
sort country function_spending govlevel year

gen gov_level=.
replace gov_level=1 if govlevel=="Central government"
replace gov_level=2 if govlevel=="General government"
replace gov_level=3 if govlevel=="Nonfinancial public sector"

gen spending_type=.
replace spending_type=1 if function_spending=="Education"
replace spending_type=2 if function_spending=="Environmental protection"
replace spending_type=3 if function_spending=="Health"
replace spending_type=4 if function_spending=="Housing and community amenities"
replace spending_type=5 if function_spending=="Recreation, culture and religion"
replace spending_type=6 if function_spending=="Social expenditure"
replace spending_type=7 if function_spending=="Social protection"

drop function_spending govlevel

keep if gov_level==2
drop gov_level

reshape wide spending_perc, i(id  year) j(spending_type)

order country id year 

label variable spending_perc1 "Public social spending for EDUCATION, general government, percapita USD"
label variable spending_perc2 "Public social spending for ENVIRONMENTAL PROTECTION, general government, percapita USD"
label variable spending_perc3 "Public social spending for HEALTH, general government, percapita USD"
label variable spending_perc4 "Public social spending for HOUSING AND COMMUNITY AMENITIES, general government, percapita USD"
label variable spending_perc5 "Public social spending for RECREATION, CULTURE AND RELIGION, general government, percapita USD"
label variable spending_perc6 "Public social spending for SOCIAL EXPENDITURE, general government, percapita USD"
label variable spending_perc7 "Public social spending for SOCIAL PROTECTION, general government, percapita USD"

rename spending_perc1 percapita_education_GG
rename spending_perc2 percapita_environment_GG
rename spending_perc3 percapita_health_GG
rename spending_perc4 percapita_housing_GG
rename spending_perc5 percapita_recreation_GG
rename spending_perc6 percapita_socialexp_GG
rename spending_perc7 percapita_socialprot_GG

gen percapita_total_GG =.
replace percapita_total_GG= percapita_education_GG
replace percapita_total_GG= percapita_total_GG + percapita_environment_GG if percapita_environment_GG!=.
replace percapita_total_GG= percapita_total_GG + percapita_health_GG if percapita_health_GG!=.
replace percapita_total_GG= percapita_total_GG + percapita_housing_GG if percapita_housing_GG!=.
replace percapita_total_GG= percapita_total_GG + percapita_recreation_GG if percapita_recreation_GG!=.
replace percapita_total_GG= percapita_total_GG + percapita_socialprot_GG if percapita_socialprot_GG!=.
label variable percapita_total_GG "Manual TOTAL public social spending, general government, percapita USD"

save "$datapath/CEPAL_spendingpercapita_GG.dta", replace

************ Spending percapita - NON-FINANCIAL PUBLIC SECTOR ****************

import excel "$datapath/CEPAL_Socialspending_USD.xlsx", sheet("data") firstrow clear

drop indicator unit notes_ids source_id 

rename Country__ESTANDAR country
rename Classificationofthefunctions function_spending
rename Institutionalcoverage govlevel
rename Years__ESTANDAR year
rename value spending_perc
label variable spending_perc "Public social spending as percentage of GDP"
label variable function_spending "Function of social spending"
label variable govlevel "Institutional coverage of government spending"

generate id=.
replace id=8 if country=="Argentina"
replace id=20 if country=="Belize"
replace id=24 if country=="Bolivia (Plurinational State of)"
replace id=27 if country=="Brazil"
replace id=40 if country=="Chile"
replace id=42 if country=="Colombia"
replace id=46 if country=="Costa Rica"
replace id=49 if country=="Cuba"
replace id=56 if country=="Dominican Republic"
replace id=57 if country=="Ecuador"
replace id=59 if country=="El Salvador"
replace id=78 if country=="Guatemala"
replace id=82 if country=="Haiti"
replace id=83 if country=="Honduras"
replace id=95 if country=="Jamaica"
replace id=126 if country=="Mexico"
replace id=140 if country=="Nicaragua"
replace id=148 if country=="Panama"
replace id=150 if country=="Paraguay"
replace id=151 if country=="Peru"
replace id=195 if country=="Trinidad and Tobago"
replace id=206 if country=="Uruguay"
replace id=209 if country=="Venezuela (Bolivarian Republic of)"

drop if id==.

order country id govlevel function_spending id year
sort country function_spending govlevel year

gen gov_level=.
replace gov_level=1 if govlevel=="Central government"
replace gov_level=2 if govlevel=="General government"
replace gov_level=3 if govlevel=="Nonfinancial public sector"

gen spending_type=.
replace spending_type=1 if function_spending=="Education"
replace spending_type=2 if function_spending=="Environmental protection"
replace spending_type=3 if function_spending=="Health"
replace spending_type=4 if function_spending=="Housing and community amenities"
replace spending_type=5 if function_spending=="Recreation, culture and religion"
replace spending_type=6 if function_spending=="Social expenditure"
replace spending_type=7 if function_spending=="Social protection"

drop function_spending govlevel

keep if gov_level==3
drop gov_level

reshape wide spending_perc, i(id  year) j(spending_type)

order country id year 

label variable spending_perc1 "Public social spending for EDUCATION, non-financial public sector, percapita USD"
label variable spending_perc2 "Public social spending for ENVIRONMENTAL PROTECTION, non-financial public sector, percapita USD"
label variable spending_perc3 "Public social spending for HEALTH, non-financial public sector, percapita USD"
label variable spending_perc4 "Public social spending for HOUSING AND COMMUNITY AMENITIES, non-financial public sector, percapita USD"
label variable spending_perc5 "Public social spending for RECREATION, CULTURE AND RELIGION, non-financial public sector, percapita USD"
label variable spending_perc6 "Public social spending for SOCIAL EXPENDITURE, non-financial public sector, percapita USD"
label variable spending_perc7 "Public social spending for SOCIAL PROTECTION, non-financial public sector, percapita USD"

rename spending_perc1 percapita_education_NFPS
rename spending_perc2 percapita_environment_NFPS
rename spending_perc3 percapita_health_NFPS
rename spending_perc4 percapita_housing_NFPS
rename spending_perc5 percapita_recreation_NFPS
rename spending_perc6 percapita_socialexp_NFPS
rename spending_perc7 percapita_socialprot_NFPS

gen percapita_total_NFPS =.
replace percapita_total_NFPS= percapita_education_NFPS
replace percapita_total_NFPS= percapita_total_NFPS + percapita_environment_NFPS if percapita_environment_NFPS!=.
replace percapita_total_NFPS= percapita_total_NFPS + percapita_health_NFPS if percapita_health_NFPS!=.
replace percapita_total_NFPS= percapita_total_NFPS + percapita_housing_NFPS if percapita_housing_NFPS!=.
replace percapita_total_NFPS= percapita_total_NFPS + percapita_recreation_NFPS if percapita_recreation_NFPS!=.
replace percapita_total_NFPS= percapita_total_NFPS + percapita_socialprot_NFPS if percapita_socialprot_NFPS!=.
label variable percapita_total_NFPS "Manual TOTAL public social spending, non-financial public sector, percapita USD"

save "$datapath/CEPAL_spendingpercapita_NFPS.dta", replace

********************************************************************************
************ World Bank GDP per capita, constant (base=2015)********************
********************************************************************************

import excel "$datapath/GDPpc_WorldBank.xlsx",  clear

drop B C D E F G H I J K L M N O P Q R S T U V W X Y Z AA AB AC AD AE AF AG AH 
rename A country
rename AI year1990
rename AJ year1991
rename AK year1992
rename AL year1993
rename AM year1994
rename AN year1995
rename AO year1996
rename AP year1997
rename AQ year1998
rename AR year1999
rename AS year2000
rename AT year2001
rename AU year2002
rename AV year2003
rename AW year2004
rename AX year2005
rename AY year2006
rename AZ year2007
rename BA year2008
rename BB year2009
rename BC year2010
rename BD year2011
rename BE year2012
rename BF year2013
rename BG year2014
rename BH year2015
rename BI year2016
rename BJ year2017
rename BK year2018
rename BL year2019
rename BM year2020
rename BN year2021

drop in 1/4

gen id=.
replace id=8 if country=="Argentina"
replace id=20 if country=="Belize"
replace id=24 if country=="Bolivia"
replace id=27 if country=="Brazil"
replace id=40 if country=="Chile"
replace id=42 if country=="Colombia"
replace id=46 if country=="Costa Rica"
replace id=49 if country=="Cuba"
replace id=56 if country=="Dominican Republic"
replace id=57 if country=="Ecuador"
replace id=59 if country=="El Salvador"
replace id=78 if country=="Guatemala"
replace id=82 if country=="Haiti"
replace id=83 if country=="Honduras"
replace id=95 if country=="Jamaica"
replace id=126 if country=="Mexico"
replace id=140 if country=="Nicaragua"
replace id=148 if country=="Panama"
replace id=150 if country=="Paraguay"
replace id=151 if country=="Peru"
replace id=195 if country=="Trinidad and Tobago"
replace id=206 if country=="Uruguay"
replace id=209 if country=="Venezuela, RB"

drop if id==.
order country id 

reshape long year, i(id) j(date)
rename year GDPpc
label variable GDPpc "GDP per capita, constant 2015$, World Bank"
rename date year
drop country

destring GDPpc, replace

save "$datapath/GDPpc.dta", replace

********************************************************************************
******************* IMF Commodity price index **********************************
********************************************************************************

import delimited "$datapath/PCTOT_01-31-2023 17-02-07-08_timeSeries.csv", clear 

rename ïcountryname country
keep country indicatorname indicatorcode typename v*
drop v40-v51 v53-v64 v66-v77 v79-v90 v92-v103 v105-v116 v118-v129 v131-v142 v144-v155 v157-v168 v170-v181 v183-v194 v196-v207 v209-v220 v222-v233 v235-v246 v248-v259 v261-v272 v274-v285 v287-v298 ///
v300-v311 v313-v324 v326-v337 v339-v350 v352-v363 v365-v376 v378-v389 v391-v402 v404-v415 v417-v428 v430-v441 v443-v454 v456-v467 v469-v480 v482-v493 v495-v506 v508-v519 v521-v532 v534-v545 v547-v558 v560-v571 v573-v584 v585

generate id=.
order country id
replace id=8 if country=="Argentina"
replace id=20 if country=="Belize"
replace id=24 if country=="Bolivia"
replace id=27 if country=="Brazil"
replace id=40 if country=="Chile"
replace id=42 if country=="Colombia"
replace id=46 if country=="Costa Rica"
replace id=56 if country=="Dominican Republic"
replace id=57 if country=="Ecuador"
replace id=59 if country=="El Salvador"
replace id=78 if country=="Guatemala"
replace id=82 if country=="Haiti"
replace id=83 if country=="Honduras"
replace id=95 if country=="Jamaica"
replace id=126 if country=="Mexico"
replace id=140 if country=="Nicaragua"
replace id=148 if country=="Panama"
replace id=150 if country=="Paraguay"
replace id=151 if country=="Peru"
replace id=195 if country=="Trinidad and Tobago"
replace id=206 if country=="Uruguay"
replace id=209 if country=="Venezuela, RepÃºblica Bolivariana de"

drop if id==.

rename v8 v1962
rename v9 v1963
rename v10 v1964
rename v11 v1965
rename v12 v1966
rename v13 v1967
rename v14 v1968
rename v15 v1969
rename v16 v1970
rename v17 v1971
rename v18 v1972
rename v19 v1973
rename v20 v1974
rename v21 v1975
rename v22 v1976
rename v23 v1977
rename v24 v1978
rename v25 v1979
rename v26 v1980
rename v39 v1981
rename v52 v1982
rename v65 v1983
rename v78 v1984
rename v91 v1985
rename v104 v1986
rename v117 v1987
rename v130 v1988
rename v143 v1989
rename v156 v1990
rename v169 v1991
rename v182 v1992
rename v195 v1993
rename v208 v1994
rename v221 v1995
rename v234 v1996
rename v247 v1997
rename v260 v1998
rename v273 v1999
rename v286 v2000
rename v299 v2001
rename v312 v2002
rename v325 v2003
rename v338 v2004
rename v351 v2005
rename v364 v2006
rename v377 v2007
rename v390 v2008
rename v403 v2009
rename v416 v2010
rename v429 v2011
rename v442 v2012
rename v455 v2013
rename v468 v2014
rename v481 v2015
rename v494 v2016
rename v507 v2017
rename v520 v2018
rename v533 v2019
rename v546 v2020
rename v559 v2021
rename v572 v2022

reshape long v, i(country indicatorcode typename) j(year)
order country id year indicatorname indicatorcode typename
rename v commprice

keep if indicatorcode=="xm" | indicatorcode=="xm_gdp"
* xm: Commodity Net Export Price Index, Individual Commodities Weighted by Ratio of Net Exports to Total Commodity Trade
* xm_gdp: Commodity Net Export Price Index, Individual Commodities Weighted by Ratio of Net Exports to GDP
drop indicatorname
keep if typename=="Historical, Rolling Weights, Index"
* Alternative: Historical, Fixed Weights, Index
drop typename

gen indicator=1 if indicatorcode=="xm"
replace indicator=2 if indicatorcode=="xm_gdp"
drop indicatorcode

reshape wide commprice, i(id year) j(indicator)
order country id year 
label variable commprice1 "Commodity Net Export Price, Trade-Weighted"
label variable commprice2 "Commodity Net Export Price, GDP-Weighted"
drop country

save "$datapath/IMF_Commprices.dta", replace


********************************************************************************
************************ CEPAL OLD DATA ****************************************
********************************************************************************

import excel "$datapath/CEPAL Gasto public 1990-2015.xlsx", sheet("Nivel") clear

drop B D F H J L N P R T V X Z AB AD AF AH AJ AL AN AP AR AT AV AX AZ BB

drop in 1/124
drop in 2/8
drop in 9/61
drop in 10/16
drop in 17/681
drop in 18/24
drop in 25/737

rename C t1990
rename E t1991
rename G t1992
rename I t1993
rename K t1994
rename M t1995
rename O t1996
rename Q t1997
rename S t1998
rename U t1999
rename W t2000
rename Y t2001
rename AA t2002
rename AC t2003
rename AE t2004
rename AG t2005
rename AI t2006
rename AK t2007
rename AM t2008
rename AO t2009
rename AQ t2010
rename AS t2011
rename AU t2012
rename AW t2013
rename AY t2014
rename BA t2015

rename A spendingtype
gen id=.
replace id=57 in 2/8
replace id=46 in 18/24
replace id=83 in 10/16
drop in 1
drop in 8
drop in 15

drop if id==46

reshape long t, i(id spendingtype) j(year)
tab spendingtype, gen(spending)
gen spendingt=.
forval i=1/7 {
replace spendingt=`i' if spending`i'==1
}
drop spending1 spending2 spending3 spending4 spending5 spending6 spending7
drop spendingtype
reshape wide t, i(id year) j(spendingt)

rename t1 percapita_CGold_TOTAL
rename t2 percapita_CGold_RECREATION
rename t3 percapita_CGold_EDUCATION
rename t4 percapita_CGold_ENVIRONMENT
rename t5 percapita_CGold_SOCIALPROT
rename t6 percapita_CGold_HEALTH
rename t7 percapita_CGold_HOUSING

save "$datapath/CEPAL_spendingperc_CG_old.dta", replace

*****

import excel "$datapath/CEPAL_percentage_1990_2015", clear

drop B D F H J L N P R T V X Z AB AD AF AH AJ AL AN AP AR AT AV AX AZ BB

drop in 1/124
drop in 2/8
drop in 9/61
drop in 10/16
drop in 17/681
drop in 18/24
drop in 25/737

rename C t1990
rename E t1991
rename G t1992
rename I t1993
rename K t1994
rename M t1995
rename O t1996
rename Q t1997
rename S t1998
rename U t1999
rename W t2000
rename Y t2001
rename AA t2002
rename AC t2003
rename AE t2004
rename AG t2005
rename AI t2006
rename AK t2007
rename AM t2008
rename AO t2009
rename AQ t2010
rename AS t2011
rename AU t2012
rename AW t2013
rename AY t2014
rename BA t2015

rename A spendingtype
gen id=.
replace id=57 in 2/8
replace id=46 in 18/24
replace id=83 in 10/16
drop in 1
drop in 8
drop in 15

drop if id==46

reshape long t, i(id spendingtype) j(year)
tab spendingtype, gen(spending)
gen spendingt=.
forval i=1/7 {
replace spendingt=`i' if spending`i'==1
}
drop spending1 spending2 spending3 spending4 spending5 spending6 spending7
drop spendingtype
reshape wide t, i(id year) j(spendingt)

rename t1 percent_CGold_TOTAL
rename t2 percent_CGold_RECREATION
rename t3 percent_CGold_EDUCATION
rename t4 percent_CGold_ENVIRONMENT
rename t5 percentpercent_CGold_SOCIALPROT
rename t6 percent_CGold_HEALTH
rename t7 percent_CGold_HOUSING

save "$datapath/CEPAL_spendingpercent_CG_old.dta", replace

********************************************************************************
************************ MERGE DATASETS ****************************************
********************************************************************************

use "$datapath/CEPAL_spendingperc_CG.dta", clear

merge 1:1 id year using "$datapath/CEPAL_spendingperc_GG.dta"
drop _merge
merge 1:1 id year using "$datapath/CEPAL_spendingperc_NFPS.dta"
drop _merge
merge 1:1 id year using "$datapath/CEPAL_spendingpercapita_CG.dta"
drop _merge
merge 1:1 id year using "$datapath/CEPAL_spendingpercapita_GG.dta"
drop _merge
merge 1:1 id year using "$datapath/CEPAL_spendingpercapita_NFPS.dta"
drop _merge

gen year2=real(year)
drop year
rename year2 year 
order country id year

merge m:m id year using "$datapath/CEPAL_spendingpercent_CG_old.dta"
sort id year
drop _merge

merge m:m id year using "$datapath/CEPAL_spendingperc_CG_old.dta"
drop _merge

replace country="Ecuador" if id==57
replace country="Honduras" if id==83

label variable country "Country"
label variable year "Year"

merge 1:1 id year using "$datapath/IMF_Commprices.dta"
drop if _merge==2
drop _merge

drop if id==20 | id==49 | id==82  | id==195
drop if year<1990

merge 1:1 id year using "$datapath/GDPpc.dta"
drop if _merge==2
drop _merge

"$datapath/fed_baaffm_geo"
drop _merge
sort id year

drop if country==""

egen cid=group(id)
order id cid

label define cid 1 "Argentina" 2 "Bolivia" 3 "Brazil" 4 "Chile" 5 "Colombia" 6 "Costa Rica" 7 "Dominican Republic" 8 "Ecuador" 9 "El Salvador" 10 "Guatemala" 11 "Honduras" ///
12 "Jamaica" 13 "Mexico" 14 "Nicaragua" 15 "Panama" 16 "Paraguay" 17 "Peru" 18 "Uruguay" 19 "Venezuela"
label values cid cid

save "$datapath/dataset_for_analysis.dta", replace

