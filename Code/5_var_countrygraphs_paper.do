

gr combine "$outputpath/VAR_Graphs/loops/Argentina_VAR_perc_lv_education_NFPS.gph" ///
"$outputpath/VAR_Graphs/loops/Argentina_VAR_perc_lv_health_NFPS.gph" ///
"$outputpath/VAR_Graphs/loops/Argentina_VAR_perc_lv_socialprot_NFPS.gph" ///
"$outputpath/VAR_Graphs/loops/Argentina_VAR_PC_lv_education_NFPS.gph" ///
"$outputpath/VAR_Graphs/loops/Argentina_VAR_PC_lv_health_NFPS.gph" ///
"$outputpath/VAR_Graphs/loops/Argentina_VAR_PC_lv_socialprot_NFPS.gph" , ///
graphregion(color(white)) row(2) ycommon title("Argentina", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/ARGENTINA", replace
graph export "$outputpath/VAR_Graphs/loops/ARGENTINA.png", replace

gr combine "$outputpath/VAR_Graphs/loops/Bolivia_VAR_perc_lv_education_CG.gph" ///
"$outputpath/VAR_Graphs/loops/Bolivia_VAR_perc_lv_health_CG.gph" ///
"$outputpath/VAR_Graphs/loops/Bolivia_VAR_perc_lv_socialprot_CG.gph" ///
"$outputpath/VAR_Graphs/loops/Bolivia_VAR_PC_lv_education_CG.gph" ///
"$outputpath/VAR_Graphs/loops/Bolivia_VAR_PC_lv_health_CG.gph" ///
"$outputpath/VAR_Graphs/loops/Bolivia_VAR_PC_lv_socialprot_CG.gph" , ///
graphregion(color(white)) row(2) ycommon title("Bolivia", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/Bolivia", replace
graph export "$outputpath/VAR_Graphs/loops/Bolivia.png", replace

gr combine "$outputpath/VAR_Graphs/loops/Colombia_VAR_perc_lv_education_CG.gph" ///
"$outputpath/VAR_Graphs/loops/Colombia_VAR_perc_lv_health_CG.gph" ///
"$outputpath/VAR_Graphs/loops/Colombia_VAR_perc_lv_socialprot_CG.gph" ///
"$outputpath/VAR_Graphs/loops/Colombia_VAR_PC_lv_education_CG.gph" ///
"$outputpath/VAR_Graphs/loops/Colombia_VAR_PC_lv_health_CG.gph" ///
"$outputpath/VAR_Graphs/loops/Colombia_VAR_PC_lv_socialprot_CG.gph" , ///
graphregion(color(white)) row(2) ycommon title("Colombia", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/Colombia", replace
graph export "$outputpath/VAR_Graphs/loops/Colombia.png", replace

gr combine "$outputpath/VAR_Graphs/loops/Chile_VAR_perc_lv_education_CG.gph" ///
"$outputpath/VAR_Graphs/loops/Chile_VAR_perc_lv_health_CG.gph" ///
"$outputpath/VAR_Graphs/loops/Chile_VAR_perc_lv_socialprot_CG.gph" ///
"$outputpath/VAR_Graphs/loops/Chile_VAR_PC_lv_education_CG.gph" ///
"$outputpath/VAR_Graphs/loops/Chile_VAR_PC_lv_health_CG.gph" ///
"$outputpath/VAR_Graphs/loops/Chile_VAR_PC_lv_socialprot_CG.gph" , ///
graphregion(color(white)) row(2) ycommon title("Chile", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/Chile", replace
graph export "$outputpath/VAR_Graphs/loops/Chile.png", replace

gr combine "$outputpath/VAR_Graphs/loops/Mexico_VAR_perc_lv_education_CG.gph" ///
"$outputpath/VAR_Graphs/loops/Mexico_VAR_perc_lv_health_CG.gph" ///
"$outputpath/VAR_Graphs/loops/Mexico_VAR_perc_lv_socialprot_CG.gph" ///
"$outputpath/VAR_Graphs/loops/Mexico_VAR_PC_lv_education_CG.gph" ///
"$outputpath/VAR_Graphs/loops/Mexico_VAR_PC_lv_health_CG.gph" ///
"$outputpath/VAR_Graphs/loops/Mexico_VAR_PC_lv_socialprot_CG.gph" , ///
graphregion(color(white)) row(2) ycommon title("Mexico", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/Mexico", replace
graph export "$outputpath/VAR_Graphs/loops/Mexico.png", replace

gr combine "$outputpath/VAR_Graphs/loops/Brazil_VAR_perc_lv_education_CG.gph" ///
"$outputpath/VAR_Graphs/loops/Brazil_VAR_perc_lv_health_CG.gph" ///
"$outputpath/VAR_Graphs/loops/Brazil_VAR_perc_lv_socialprot_CG.gph" ///
"$outputpath/VAR_Graphs/loops/Brazil_VAR_PC_lv_education_CG.gph" ///
"$outputpath/VAR_Graphs/loops/Brazil_VAR_PC_lv_health_CG.gph" ///
"$outputpath/VAR_Graphs/loops/Brazil_VAR_PC_lv_socialprot_CG.gph" , ///
graphregion(color(white)) row(2) ycommon title("Brazil", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/Brazil", replace
graph export "$outputpath/VAR_Graphs/loops/Brazil.png", replace

gr combine "$outputpath/VAR_Graphs/loops/57_VAR_perc_lv_education_CGold.gph" ///
"$outputpath/VAR_Graphs/loops/57_VAR_perc_lv_health_CGold.gph" ///
"$outputpath/VAR_Graphs/loops/57_VAR_perc_lv_socialprot_CGold.gph" ///
"$outputpath/VAR_Graphs/loops/57_VAR_PC_lv_education_CGold.gph" ///
"$outputpath/VAR_Graphs/loops/57_VAR_PC_lv_health_CGold.gph" ///
"$outputpath/VAR_Graphs/loops/57_VAR_PC_lv_socialprot_CGold.gph" , ///
graphregion(color(white)) row(2) ycommon title("Ecuador", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/Ecuador", replace
graph export "$outputpath/VAR_Graphs/loops/Ecuador.png", replace
