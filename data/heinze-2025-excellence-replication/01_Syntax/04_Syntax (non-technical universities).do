/*==============================================================================
Replication files for
- Appendix 8a and 8c
==============================================================================*/

** NON-TECHNICAL UNIVERSITIES

*Setup
clear all

*** Alle subjects
*** 1st phase

use "$data/daten_gesamt_92-15_Exzellenz_regression_81_ntu.dta", clear

   
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
	"$tables/Appendix8c_NTU.rtf" ///
     , replace not b(%9.6f) ///
       star nodepv nonum nogaps compress ///
       nomtitle label varwidth(15) ///
       title ("Tab. 8c: Logistic regression, first “initiative” phase (2006-2011), NTUs") ///
       scalars(r2_p) varlabel(_cons Intercept) unstack nobaselevels
	   

	
**2nd phase

use "$data/daten_gesamt_92-15_Exzellenz_regression_82_ntu.dta", clear

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
	"$tables/Appendix8a_NTU.rtf" ///
     , replace not b(%9.6f) ///
       star nodepv nonum nogaps compress ///
       nomtitle label varwidth(15) ///
       title ("Tab. 8a: Logistic regression, second “initiative” phase (2012-2017), NTUs") ///
       scalars(r2_p) varlabel(_cons Intercept) unstack nobaselevels
	   


exit


***************************************************************************************************************


