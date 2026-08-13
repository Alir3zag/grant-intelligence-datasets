/*==============================================================================
Replication files for:
- Appendix 12
==============================================================================*/

use "$data/daten_gesamt_92-15_Exzellenz_reputation.dta", clear
sort InstID* Jahr



********************************************************************************
* 1st phase
* Harmonize variables across universities
levelsof EinheitlicheID
local level_id `r(levels)' 
levelsof LuFid
local luf_id `r(levels)' 
foreach lev in `level_id' {
		sum Gruendungsjahr if EinheitlicheID == `lev'
		replace Gruendungsjahr = `r(mean)'  if EinheitlicheID == `lev'
		sum BundeslandID if EinheitlicheID == `lev'
		replace BundeslandID = `r(mean)'  if EinheitlicheID == `lev'
	}
	


********************************************************************************

keep if Jahr >= 2001 & Jahr <= 2006

generate Hilfsvariable = 0
levelsof EinheitlicheID
local level_id `r(levels)'
levelsof LuFid
local luf_id `r(levels)'
foreach lev in `level_id' {
	foreach luv in `luf_id' {
		count if Exz_gefoerdert_FJ == 1 & EinheitlicheID == `lev' & LuFid == `luv'
		replace Hilfsvariable = r(N) if EinheitlicheID == `lev' & LuFid == `luv'
	}
}
replace Exz_gefoerdert_FJ = 1 if Hilfsvariable == 1
drop Hilfsvariable

keep if Jahr >= 2001 & Jahr <= 2005 // Define funding phase by preparation time only

collapse (mean) Exz_gefoerdert_FJ Profs Mitarbeiter Drittmitteleinnahmen Grundmittel DiplBaMa ///
	StudierendeGesamt Zitationen Publikationen, by(EinheitlicheID LuFid Reputation Gruendungsjahr BundeslandID)
generate Foerderphase = 1
generate FoerderungPhase1 = 0
replace Exz_gefoerdert_FJ = 1 if Exz_gefoerdert_FJ > 1
replace FoerderungPhase1 = 1 if Exz_gefoerdert_FJ == 1

foreach var of varlist Drittmitteleinnahmen Grundmittel StudierendeGesamt Zitationen Publikationen {
	replace `var' = `var'/1000
	}

label var Exz_gefoerdert_FJ "ExIn-funded"
label var Profs "Professors"
label var Mitarbeiter "Academic staff"
label var Drittmitteleinnahmen "Total grant funding"
label var Grundmittel "Basic funding"
label var StudierendeGesamt "Students"
label var Zitationen "Citations"
label var Publikationen "Publications"
label var FoerderungPhase1 "Phase 1"



save "$gendata/daten_gesamt_92-15_Exzellenz_regression_81.dta", replace


********************************************************************************
********************************************************************************
* 1st phase: add DFG funding
use "$data/daten_gesamt_92-15_Exzellenz_reputation.dta", clear
keep if Jahr >= 2001 & Jahr <= 2005 
keep EinheitlicheID Jahr DM_DFG*
duplicates drop DM_DFG_Mittel Jahr EinheitlicheID, force
collapse (sum) DM_DFG_Mittel, by (EinheitlicheID Jahr)
collapse (mean) DM_DFG_Mittel, by (EinheitlicheID)
replace DM_DFG_Mittel = DM_DFG_Mittel/1000
save "$gendata/dfg_uniebene_phase1.dta", replace

* Merge to data set at subject level
use "$gendata/daten_gesamt_92-15_Exzellenz_regression_81.dta", clear
merge m:1 EinheitlicheID using "$gendata/dfg_uniebene_phase1.dta"
label var DM_DFG_Mittel "DFG grant funding"
drop _merge
save "$gendata/daten_gesamt_92-15_Exzellenz_regression_81.dta", replace

********************************************************************************
********************************************************************************

* recode missings
recode Profs Drittmitteleinnahmen StudierendeGesamt Zitationen (.=0)


* Dichotomizing macro variables
recode BundeslandID (132 133 136 138 137 140 141 142 146 143 = 0)(135 134 139 145 144 147 = 1), gen(Ost)
label var Ost "East Germany (U)"
label define Ost_L 0 "West Germany (U)" 1 "East Germany (U)"
label val Ost Ost_L

recode Gruendungsjahr (0/1945 = 0)(1946/2100 = 1), gen(Nach1945)
label var Nach1945 "Founded after 1945 (U)"
label define Gruendung_L 0 "Founded before 1945 (U)" 1 "Founded after 1945 (U)"
label val Nach1945 Gruendung_L


save "$gendata/daten_gesamt_92-15_Exzellenz_regression_81.dta", replace
* n = 2,388






********************************************************************************
********************************************************************************

* 2st phase
use "$data/daten_gesamt_92-15_Exzellenz_reputation.dta", clear

********************************************************************************
* Harmonize variables across universities
levelsof EinheitlicheID
local level_id `r(levels)'
levelsof LuFid
local luf_id `r(levels)'
foreach lev in `level_id' {
		sum Gruendungsjahr if EinheitlicheID == `lev'
		replace Gruendungsjahr = `r(mean)'  if EinheitlicheID == `lev'
		sum BundeslandID if EinheitlicheID == `lev'
		replace BundeslandID = `r(mean)'  if EinheitlicheID == `lev'
	}

********************************************************************************

keep if Jahr >= 2007 & Jahr <= 2012
replace Exz_gefoerdert_FJ = 0 if Jahr < 2012 // Excellence funding in 2012 (2nd phase)

generate Hilfsvariable = 0
levelsof EinheitlicheID
local level_id `r(levels)'
levelsof LuFid
local luf_id `r(levels)'
foreach lev in `level_id' {
	foreach luv in `luf_id' {
		count if Exz_gefoerdert_FJ == 1 & EinheitlicheID == `lev' & LuFid == `luv'
		replace Hilfsvariable = r(N) if EinheitlicheID == `lev' & LuFid == `luv'
	}
}
replace Exz_gefoerdert_FJ = 1 if Hilfsvariable == 1
drop Hilfsvariable

keep if Jahr >= 2007 & Jahr <= 2011
collapse (mean) Exz_gefoerdert_FJ Profs Mitarbeiter Drittmitteleinnahmen Grundmittel DiplBaMa ///
	StudierendeGesamt Zitationen Publikationen, by(EinheitlicheID LuFid Reputation Gruendungsjahr BundeslandID)
generate Foerderphase = 2
replace Exz_gefoerdert_FJ = 1 if Exz_gefoerdert_FJ > 1

foreach var of varlist Drittmitteleinnahmen Grundmittel StudierendeGesamt Zitationen Publikationen {
	replace `var' = `var'/1000
	}
	
label var Exz_gefoerdert_FJ "ExIn-funded"
label var Profs "Professors"
label var Mitarbeiter "Academic staff"
label var Drittmitteleinnahmen "Total grant funding"
label var Grundmittel "Basic funding"
label var StudierendeGesamt "Students"
label var Zitationen "Citations"
label var Publikationen "Publications"


save "$gendata/daten_gesamt_92-15_Exzellenz_regression_82.dta", replace


********************************************************************************
********************************************************************************
* 2st phase: Add DFG funding
use "$data/daten_gesamt_92-15_Exzellenz_reputation.dta", clear
keep if Jahr >= 2007 & Jahr <= 2012
keep EinheitlicheID Jahr DM_DFG*
duplicates drop DM_DFG_Mittel Jahr EinheitlicheID, force
collapse (sum) DM_DFG_Mittel, by (EinheitlicheID Jahr)
collapse (mean) DM_DFG_Mittel, by (EinheitlicheID)
replace DM_DFG_Mittel = DM_DFG_Mittel/1000
save "$gendata/dfg_uniebene_phase2.dta", replace

* Merge to data set at subject level
use "$gendata/daten_gesamt_92-15_Exzellenz_regression_82.dta", clear
merge m:1 EinheitlicheID using "$gendata/dfg_uniebene_phase2.dta"
label var DM_DFG_Mittel "DFG grant funding"
drop _merge
save "$gendata/daten_gesamt_92-15_Exzellenz_regression_82.dta", replace

********************************************************************************
********************************************************************************


* recode missings
recode Profs Drittmitteleinnahmen StudierendeGesamt Zitationen (.=0)

* Dichotomizing macro variables
recode BundeslandID (132 133 136 138 137 140 141 142 146 143 = 0)(135 134 139 145 144 147 = 1), gen(Ost)
label var Ost "East Germany (U)"
label define Ost_L 0 "West Germany (U)" 1 "East Germany (U)"
label val Ost Ost_L

recode Gruendungsjahr (0/1945 = 0)(1946/2100 = 1), gen(Nach1945)
label var Nach1945 "Founded after 1945 (U)"
label define Gruendung_L 0 "Founded before 1945 (U)" 1 "Founded after 1945 (U)"
label val Nach1945 Gruendung_L


save "$gendata/daten_gesamt_92-15_Exzellenz_regression_82.dta", replace
* n = 2,396

********************************************************************************
********************************************************************************

* Add 1st phase
append using "$gendata/daten_gesamt_92-15_Exzellenz_regression_81.dta"
sort EinheitlicheID LuFid Foerderphase

replace FoerderungPhase1 = 0 if Foerderphase == 2
generate Hilfsvariable = 0

levelsof EinheitlicheID
local level_id `r(levels)'
levelsof LuFid
local luf_id `r(levels)'
foreach lev in `level_id' {
	foreach luv in `luf_id' {
		count if FoerderungPhase1 == 1 & EinheitlicheID == `lev' & LuFid == `luv'
		replace Hilfsvariable = r(N) if EinheitlicheID == `lev' & LuFid == `luv'
	}
}

replace FoerderungPhase1 = 1 if Hilfsvariable == 1
replace FoerderungPhase1 = 0 if Foerderphase == 1
drop Hilfsvariable

label var Exz_gefoerdert_FJ "ExIn-funded"
label var Profs "Professors"
label var Mitarbeiter "Academic staff"
label var Drittmitteleinnahmen "Total grant funding"
label var Grundmittel "Basic funding"
label var StudierendeGesamt "Students"
label var Zitationen "Citations"
label var Publikationen "Publications"
label var FoerderungPhase1 "Phase 1"
label var DM_DFG_Mittel "DFG grant funding"

* recode missings
recode Profs Drittmitteleinnahmen StudierendeGesamt Zitationen (.=0)

save "$gendata/daten_gesamt_92-15_Exzellenz_regression_83.dta", replace



*  Add dummy for funding in first phase to data set for second phase
use "$gendata/daten_gesamt_92-15_Exzellenz_regression_82.dta", clear

merge 1:1 EinheitlicheID LuFid using ///
	"$gendata/daten_gesamt_92-15_Exzellenz_regression_81.dta", keepusing(FoerderungPhase1)
	
* recode missings
recode Profs Drittmitteleinnahmen StudierendeGesamt Zitationen (.=0)
	
tab _merge
drop _merge

drop Foerderphase
recode FoerderungPhase1 (.=0)

save "$gendata/daten_gesamt_92-15_Exzellenz_regression_82.dta", replace



**************************************************************************************

*** Regression Analyses
*** 1st phase

use "$gendata\daten_gesamt_92-15_Exzellenz_regression_81.dta", clear


********************************************************************************

** Export data
export excel using "$genexcel/Excellence_data.xlsx", ///
	sheet("1st_phase") firstrow(variables) nolabel replace

* Model with all variables
xtlogit Exz_gefoerdert_FJ Profs, i(EinheitlicheID)
	est store model1
xtlogit Exz_gefoerdert_FJ Profs Drittmitteleinnahmen, i(EinheitlicheID)
	est store model2
xtlogit Exz_gefoerdert_FJ Profs Drittmitteleinnahmen DM_DFG_Mittel, i(EinheitlicheID)
	est store model3
xtlogit Exz_gefoerdert_FJ Profs Drittmitteleinnahmen DM_DFG_Mittel StudierendeGesamt, i(EinheitlicheID)
	est store model4
xtlogit Exz_gefoerdert_FJ Profs Drittmitteleinnahmen DM_DFG_Mittel StudierendeGesamt Nach1945, i(EinheitlicheID)
	est store model5
xtlogit Exz_gefoerdert_FJ Profs Drittmitteleinnahmen DM_DFG_Mittel StudierendeGesamt Nach1945 Ost, i(EinheitlicheID)
	est store model6	   
	
	
esttab model1 model2 model3 model4 model5 model6 using ///
	"$tables/Appendix9a.rtf" ///
     , replace not b(%9.6f) ///
	        star nodepv nonum nogaps compress ///
       mtitle label varwidth(15) ///
       title ("Tab. 9a: Two-level logistic regression, first “initiative” phase (2006-2011), all universities") ///
       scalars(sigma_u rho p bic N) varlabel(_cons Intercept) 


********************************************************************************


* Correlation matrix
estpost correlate Profs Drittmitteleinnahmen DM_DFG_Mittel StudierendeGesamt Zitationen, matrix
eststo correlation
esttab correlation using "$tables/Appendix7a.rtf", ///
		replace not unstack compress b(3) title("Tab. 7a: Correlation matrix, first “initiative” phase (2006-2011), all universities") label

 
* Model with all variables
logit Exz_gefoerdert_FJ Profs 
	est store model1
logit Exz_gefoerdert_FJ Profs Drittmitteleinnahmen 
	est store model2
logit Exz_gefoerdert_FJ Profs Drittmitteleinnahmen DM_DFG_Mittel 
	est store model3
logit Exz_gefoerdert_FJ Profs Drittmitteleinnahmen DM_DFG_Mittel StudierendeGesamt
	est store model4
	
	
*Goodness of Fit test (Hosmer and Lemeshow)
cd "$tables"
asdoc estat gof, group(10) table save(Appendix10a.doc) replace
	

	
	
*** For robustness checks, we replaced DGF funding with the # of citations since both variables are highly correlated

* TABLE 4a
esttab model1 model2 model3 model4 using ///
	"$tables/Table4a.rtf" ///
     , replace not b(%9.6f) ///
       star nodepv nonum nogaps compress ///
       nomtitle label varwidth(15) ///
       title("Table 4a: Logistic regression, first “initiative” phase (2006–2011), all universities.") ///
       scalars(r2_p) varlabel(_cons Intercept) unstack nobaselevels

	   
* Robustness Check with # of Citations
logit Exz_gefoerdert_FJ Profs Drittmitteleinnahmen Zitationen 
	est store model5
logit Exz_gefoerdert_FJ Profs Drittmitteleinnahmen Zitationen StudierendeGesamt
	est store model6   
	
esttab model1 model2 model5 model6 using ///
	"$tables/Appendix11.rtf" ///
     , replace not b(%9.6f) ///
       star nodepv nonum nogaps compress ///
       label varwidth(15) ///
       title("Table 11a: Robustness check. Logistic regression, first “initiative” phase (2006–2011), all universities, incl. citations.") ///
       scalars(r2_p) varlabel(_cons Intercept) unstack nobaselevels

   
	
	
**2nd phase

use "$gendata/daten_gesamt_92-15_Exzellenz_regression_82.dta", clear

********************************************************************************
	   
* Modell with all variables
xtlogit Exz_gefoerdert_FJ Profs, i(EinheitlicheID)
	est store model1
xtlogit Exz_gefoerdert_FJ Profs Drittmitteleinnahmen, i(EinheitlicheID)
	est store model2
xtlogit Exz_gefoerdert_FJ Profs Drittmitteleinnahmen DM_DFG_Mittel, i(EinheitlicheID)
	est store model3
xtlogit Exz_gefoerdert_FJ Profs Drittmitteleinnahmen DM_DFG_Mittel StudierendeGesamt, i(EinheitlicheID)
	est store model4
xtlogit Exz_gefoerdert_FJ Profs Drittmitteleinnahmen DM_DFG_Mittel StudierendeGesamt FoerderungPhase1, i(EinheitlicheID)
	est store model5
xtlogit Exz_gefoerdert_FJ Profs Drittmitteleinnahmen DM_DFG_Mittel StudierendeGesamt FoerderungPhase1 Nach1945, i(EinheitlicheID)
	est store model6
xtlogit Exz_gefoerdert_FJ Profs Drittmitteleinnahmen DM_DFG_Mittel StudierendeGesamt FoerderungPhase1 Nach1945 Ost, i(EinheitlicheID)
	est store model7
	

esttab model1 model2 model3 model4 model5 model6 model7 using ///
	"$tables/Appendix9b.rtf" ///
     , replace not b(%9.6f) ///
       star nodepv nonum nogaps compress ///
       nomtitle label varwidth(15) ///
       title ("Tab. 9b: Two-level logistic regression, second “initiative” phase (2012-2017), all universities") ///
       scalars(sigma_u rho p bic) varlabel(_cons Intercept)

********************************************************************************


* Correlation matrix
estpost correlate Profs Drittmitteleinnahmen DM_DFG_Mittel StudierendeGesamt Zitationen FoerderungPhase1, matrix
eststo correlation
esttab correlation using "$tables/Appendix7b.rtf", ///
		replace not unstack compress b(3) label title("Tab. 7b: Correlation matrix, second “initiative” phase (2012-2017), all universities")


* Model with all variables
logit Exz_gefoerdert_FJ Profs 
	est store model1
logit Exz_gefoerdert_FJ Profs Drittmitteleinnahmen 
	est store model2
logit Exz_gefoerdert_FJ Profs Drittmitteleinnahmen DM_DFG_Mittel
	est store model3
logit Exz_gefoerdert_FJ Profs Drittmitteleinnahmen DM_DFG_Mittel StudierendeGesamt 
	est store model4
logit Exz_gefoerdert_FJ Profs Drittmitteleinnahmen DM_DFG_Mittel StudierendeGesamt i.FoerderungPhase1 
	est store model5

	
*Goodness of Fit test (Hosmer and Lemeshow)
cd "$tables"
asdoc estat gof, group(10) table save(Appendix10b.doc) replace
	
	
esttab model1 model2 model3 model4 model5 using ///
	"$tables/Table4b.rtf" ///
     , replace not b(%9.6f) ///
       star nodepv nonum nogaps compress ///
       nomtitle label varwidth(15) ///
       title ("Table 4b: Logistic regression, second “initiative” phase (2012–2017), all universities") ///
       scalars(r2_p) varlabel(_cons Intercept) unstack nobaselevels
	   
* Robustness Check with # of Citations
logit Exz_gefoerdert_FJ Profs Drittmitteleinnahmen Zitationen
	est store model6
logit Exz_gefoerdert_FJ Profs Drittmitteleinnahmen Zitationen StudierendeGesamt
	est store model7
logit Exz_gefoerdert_FJ Profs Drittmitteleinnahmen Zitationen StudierendeGesamt i.FoerderungPhase1 
	est store model8

	
esttab model1 model2 model6 model7 model8 using ///
	"$tables/Appendix11.rtf" ///
     , append not b(%9.6f) ///
       star nodepv nonum nogaps compress ///
       label varwidth(15) ///
       title("Table 11b: Robustness check. Logistic regression, second “initiative” phase (2012–2017), all universities, incl. citations.") ///
       scalars(r2_p) varlabel(_cons Intercept) unstack nobaselevels

   
	   
********************************************************************************
* 12 subject fields with good WoS coverage

**1st phase

use "$gendata/daten_gesamt_92-15_Exzellenz_regression_81.dta", clear

keep if LuFid == 39 | LuFid == 56 | LuFid == 32 | LuFid == 37 | LuFid == 13 | LuFid == 12 ///
	| LuFid == 21 | LuFid == 2 | LuFid == 19 | LuFid == 16 | LuFid == 31 | LuFid == 15
	
********************************************************************************
   
* Model with all variables
xtlogit Exz_gefoerdert_FJ Zitationen, i(EinheitlicheID)
	est store model1
xtlogit Exz_gefoerdert_FJ Zitationen Profs, i(EinheitlicheID)
	est store model2
xtlogit Exz_gefoerdert_FJ Zitationen Profs Drittmitteleinnahmen, i(EinheitlicheID)
	est store model3
xtlogit Exz_gefoerdert_FJ Zitationen Profs Drittmitteleinnahmen DM_DFG_Mittel, i(EinheitlicheID)
	est store model4
xtlogit Exz_gefoerdert_FJ Zitationen Profs Drittmitteleinnahmen DM_DFG_Mittel StudierendeGesamt , i(EinheitlicheID)
	est store model5
xtlogit Exz_gefoerdert_FJ Zitationen Profs Drittmitteleinnahmen DM_DFG_Mittel StudierendeGesamt Nach1945, i(EinheitlicheID)
	est store model6
xtlogit Exz_gefoerdert_FJ Zitationen Profs Drittmitteleinnahmen DM_DFG_Mittel StudierendeGesamt Nach1945 Ost, i(EinheitlicheID)
	est store model7

	
esttab model1 model2 model3 model4 model5 model6 model7 using ///
	"$tables/Appendix9c.rtf" ///
     , replace not b(%9.6f) ///
       star nodepv nonum nogaps compress ///
       nomtitle label varwidth(15) ///
       title ("Tab. 9c: Two-level logistic regression, first “initiative” phase (2006-2011), 12 subject fields with good WoS coverage, all universities") ///
       scalars(sigma_u rho p bic) varlabel(_cons Intercept)

********************************************************************************
	
* Correlation matrix
estpost correlate Profs Drittmitteleinnahmen DM_DFG_Mittel StudierendeGesamt Zitationen, matrix
eststo correlation
esttab correlation using "$tables/Appendix7c.rtf", ///
		replace not unstack compress b(3)  title("Tab. 7c: Correlation matrix, first “initiative” phase (2006-2011), 12 subject fields with good WoS coverage, all universities") label

	   
* Model for all variables
logit Exz_gefoerdert_FJ Zitationen 
	est store model1
logit Exz_gefoerdert_FJ Zitationen DM_DFG_Mittel
	est store model2
logit Exz_gefoerdert_FJ Zitationen DM_DFG_Mittel Drittmitteleinnahmen 
	est store model3
logit Exz_gefoerdert_FJ Zitationen DM_DFG_Mittel Drittmitteleinnahmen Profs 
	est store model4
logit Exz_gefoerdert_FJ Zitationen DM_DFG_Mittel Drittmitteleinnahmen Profs StudierendeGesamt 
	est store model5

	
esttab model1 model2 model3 model4 model5 using ///
	"$tables/Appendix8k.rtf" ///
     , replace not b(%9.6f) ///
       star nodepv nonum nogaps compress ///
       nomtitle label varwidth(15) ///
       title ("Tab. 8k: Logistic regression, first “initiative” phase (2006-2011), 12 subject fields with good WoS coverage, all universities") ///
       scalars(r2_p) varlabel(_cons Intercept) unstack nobaselevels


use "$gendata/daten_gesamt_92-15_Exzellenz_regression_82.dta", clear

keep if LuFid == 39 | LuFid == 56 | LuFid == 32 | LuFid == 37 | LuFid == 13 | LuFid == 12 ///
	| LuFid == 21 | LuFid == 2 | LuFid == 19 | LuFid == 16 | LuFid == 31 | LuFid == 15
	
********************************************************************************
	   
* Model with all variables
xtlogit Exz_gefoerdert_FJ Zitationen, i(EinheitlicheID)
	est store model7
xtlogit Exz_gefoerdert_FJ Zitationen Profs, i(EinheitlicheID)
	est store model1
xtlogit Exz_gefoerdert_FJ Zitationen Profs Drittmitteleinnahmen, i(EinheitlicheID)
	est store model2
xtlogit Exz_gefoerdert_FJ Zitationen Profs Drittmitteleinnahmen DM_DFG_Mittel, i(EinheitlicheID)
	est store model3
xtlogit Exz_gefoerdert_FJ Zitationen Profs Drittmitteleinnahmen DM_DFG_Mittel StudierendeGesamt , i(EinheitlicheID)
	est store model4
xtlogit Exz_gefoerdert_FJ Zitationen Profs Drittmitteleinnahmen DM_DFG_Mittel StudierendeGesamt FoerderungPhase1, i(EinheitlicheID)
	est store model5
xtlogit Exz_gefoerdert_FJ Zitationen Profs Drittmitteleinnahmen DM_DFG_Mittel StudierendeGesamt FoerderungPhase1 Nach1945, i(EinheitlicheID)
	est store model6
xtlogit Exz_gefoerdert_FJ Zitationen Profs Drittmitteleinnahmen DM_DFG_Mittel StudierendeGesamt FoerderungPhase1 Nach1945 Ost, i(EinheitlicheID)
	est store model7
		
esttab model7 model1 model2 model3 model4 model5 model6 model7 using ///
	"$tables/Appendix9d.rtf" ///
     , replace not b(%9.6f) ///
       star nodepv nonum nogaps compress ///
       nomtitle label varwidth(15) ///
       title ("Tab. 9d: Two-level logistic regression, second “initiative” phase (2012-2017), 12 subject fields with good WoS coverage, all universities") ///
       scalars(sigma_u rho p bic) varlabel(_cons Intercept)

********************************************************************************
	
* Correlation matrix
estpost correlate Profs Drittmitteleinnahmen DM_DFG_Mittel StudierendeGesamt Zitationen FoerderungPhase1, matrix
eststo correlation
esttab correlation using "$tables/Appendix7d.rtf", ///
		replace not unstack compress b(3)  title("Tab. 7d: Correlation matrix, second “initiative” phase (2012-2017), 12 subject fields with good WoS coverage, all universities") label

* Model for all variables
logit Exz_gefoerdert_FJ Zitationen 
	est store model1
logit Exz_gefoerdert_FJ Zitationen Profs 
	est store model2
logit Exz_gefoerdert_FJ Zitationen Profs Drittmitteleinnahmen 
	est store model3
logit Exz_gefoerdert_FJ Zitationen Profs Drittmitteleinnahmen DM_DFG_Mittel 
	est store model4
logit Exz_gefoerdert_FJ Zitationen Profs Drittmitteleinnahmen DM_DFG_Mittel StudierendeGesamt 
	est store model5
logit Exz_gefoerdert_FJ Zitationen Profs Drittmitteleinnahmen DM_DFG_Mittel StudierendeGesamt i.FoerderungPhase1 
	est store model6

	
esttab model1 model2 model3 model4 model5 model6 using ///
	"$tables/Appendix8l.rtf" ///
     , replace not b(%9.6f) ///
       star nodepv nonum nogaps compress ///
       nomtitle label varwidth(15) ///
       title ("Tab. 8l: Logistic regression, second “initiative” phase (2012-2017), 12 subject fields with good WoS coverage, all universities") ///
       scalars(r2_p) varlabel(_cons Intercept) unstack nobaselevels
   
exit



