/*==============================================================================
Replication files for
- Appendix 8b, 8d (Technical universities in Germany: n = 17)
==============================================================================*/

** TECHNICAL UNIVERSITIES

*Setup
clear all

*** Alle subjects
**1st phase

use "$data/daten_gesamt_92-15_Exzellenz_regression_81_tu.dta", clear

	   
* Model for all variables
logit Exz_gefoerdert_FJ Profs 
	est store model1
logit Exz_gefoerdert_FJ Profs Drittmitteleinnahmen 
	est store model2
logit Exz_gefoerdert_FJ Profs Drittmitteleinnahmen DM_DFG_Mittel
	est store model3
logit Exz_gefoerdert_FJ Profs Drittmitteleinnahmen DM_DFG_Mittel StudierendeGesamt 
	est store model4
	
	
esttab model1 model2 model3 model4 using ///
	"$tables/Appendix8d_TU.rtf" ///
     , replace not b(%9.6f) ///
       star nodepv nonum nogaps compress ///
       nomtitle label varwidth(15) ///
       title ("Tab. 8d: Logistic regression, first “initiative” phase (2006-2011), TUs") ///
       scalars(r2_p) varlabel(_cons Intercept) unstack nobaselevels
	   

**2nd phase

use "$data/daten_gesamt_92-15_Exzellenz_regression_82_tu.dta", clear

  
* Model for all variables
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
	
esttab model1 model2 model3 model4 model5 using ///
	"$tables/Appendix8b_TU.rtf" ///
     , replace not b(%9.6f) ///
       star nodepv nonum nogaps compress ///
       nomtitle label varwidth(15) ///
       title ("Tab. 8b: Logistic regression, second “initiative” phase (2012-2017), TUs") ///
       scalars(r2_p) varlabel(_cons Intercept) unstack nobaselevels


exit


***************************************************************************************************************


