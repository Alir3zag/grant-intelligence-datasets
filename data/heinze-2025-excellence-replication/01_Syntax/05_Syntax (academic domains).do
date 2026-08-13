/*==============================================================================
Replication Files for
- Appendix 8e, 8f (natural science)
- Appendix 8g, 8h (social science)
- Appendix 8i, 8j (humanities)
- Supplement (engineering)
==============================================================================*/

*Setup
clear all

********************************************************************************


*** Humanities *****************************************************************

**1st phase

use "$data/daten_gesamt_92-15_Exzellenz_regression_81.dta", clear

keep if LuFid==50 | LuFid==18  | LuFid==27  | LuFid==36  | LuFid==23  | LuFid==10  ///
		| LuFid==3  | LuFid==4  | LuFid==22  | LuFid==5  | LuFid==44  | LuFid==45 ///
		| LuFid==7  | LuFid==28  | LuFid==39  | LuFid==17  | LuFid==46


   
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
	"$tables/Appendix8i_fachgr.rtf" ///
     , replace not b(%9.6f) ///
       star nodepv nonum nogaps compress ///
       nomtitle label varwidth(15) ///
       title ("Tab. 8i: Logistic regression, first “initiative” phase (2006-2011), humanities") ///
       scalars(r2_p) varlabel(_cons Intercept) unstack nobaselevels

	
**2nd phase

use "$data/daten_gesamt_92-15_Exzellenz_regression_82.dta", clear

keep if LuFid==50 | LuFid==18  | LuFid==27  | LuFid==36  | LuFid==23  | LuFid==10  ///
		| LuFid==3  | LuFid==4  | LuFid==22  | LuFid==5  | LuFid==44  | LuFid==45 ///
		| LuFid==7  | LuFid==28  | LuFid==39  | LuFid==17  | LuFid==46

   
* Modell for all variables
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
	"$tables/Appendix8j_fachgr.rtf" ///
     , replace not b(%9.6f) ///
       star nodepv nonum nogaps compress ///
       nomtitle label varwidth(15) ///
       title ("Tab. 8j: Logistic regression, second “initiative” phase (2012-2017), humanities") ///
       scalars(r2_p) varlabel(_cons Intercept) unstack nobaselevels


	   

*** Social Sciences ************************************************************

**1st phase

use "$data/daten_gesamt_92-15_Exzellenz_regression_81.dta", clear

keep if LuFid == 41 | LuFid ==43 | LuFid ==38  | LuFid ==48  | LuFid ==47 ///
		 | LuFid ==42  | LuFid ==53  | LuFid ==56  | LuFid ==55

  
	   
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
	"$tables/Appendix8g_fachgr.rtf" ///
     , replace not b(%9.6f) ///
       star nodepv nonum nogaps compress ///
       nomtitle label varwidth(15) ///
       title ("Tab. 8g: Logistic regression, first “initiative” phase (2006-2011), social sciences") ///
       scalars(r2_p) varlabel(_cons Intercept) unstack nobaselevels
	   

   
	
**2nd phase

use "$data/daten_gesamt_92-15_Exzellenz_regression_82.dta", clear

keep if LuFid == 41 | LuFid ==43 | LuFid ==38  | LuFid ==48  | LuFid ==47 ///
		 | LuFid ==42  | LuFid ==53  | LuFid ==56  | LuFid ==55

   
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
	"$tables/Appendix8h_fachgr.rtf" ///
     , replace not b(%9.6f) ///
       star nodepv nonum nogaps compress ///
       nomtitle label varwidth(15) ///
       title ("Tab. 8h: Logistic regression, second “initiative” phase (2012-2017), social sciences") ///
       scalars(r2_p) varlabel(_cons Intercept) unstack nobaselevels

	   	   	   
		   
*** Natural Sciences ***********************************************************

**1st phase

use "$data/daten_gesamt_92-15_Exzellenz_regression_81.dta", clear


keep if LuFid==33 | LuFid==32 | LuFid==25 | LuFid==37 | LuFid==13 | LuFid==35 ///
		 | LuFid==12 | LuFid==21 | LuFid==20
	   
	     
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
	"$tables/Appendix8e_fachgr.rtf" ///
     , replace not b(%9.6f) ///
       star nodepv nonum nogaps compress ///
       nomtitle label varwidth(15) ///
       title ("Tab. 8e: Logistic regression, first “initiative” phase (2006-2011), natural sciences") ///
       scalars(r2_p) varlabel(_cons Intercept) unstack nobaselevels
	
	   
   
	
**2nd phase

use "$data/daten_gesamt_92-15_Exzellenz_regression_82.dta", clear

keep if LuFid==33 | LuFid==32 | LuFid==25 | LuFid==37 | LuFid==13 | LuFid==35 ///
		 | LuFid==12 | LuFid==21 | LuFid==20


	   
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
	"$tables/Appendix8f_fachgr.rtf" ///
     , replace not b(%9.6f) ///
       star nodepv nonum nogaps compress ///
       nomtitle label varwidth(15) ///
       title ("Tab. 8f: Logistic regression, second “initiative” phase (2012-2017), natural sciences") ///
       scalars(r2_p) varlabel(_cons Intercept) unstack nobaselevels
	   

		   
*** Engineeringn ***************************************************************

**1. Phase

use "$data/daten_gesamt_92-15_Exzellenz_regression_81.dta", clear

keep if LuFid==26 | LuFid==54 | LuFid==9 | LuFid==31 | LuFid==15 | LuFid==51 ///
		 | LuFid==6  | LuFid==40  | LuFid==8  | LuFid==52

	   
* Model for all variables
logit Exz_gefoerdert_FJ Profs 
	est store model1
logit Exz_gefoerdert_FJ Profs Drittmitteleinnahmen 
	est store model2
logit Exz_gefoerdert_FJ Profs Drittmitteleinnahmen  DM_DFG_Mittel 
	est store model3
logit Exz_gefoerdert_FJ Profs Drittmitteleinnahmen DM_DFG_Mittel StudierendeGesamt
	est store model4
	
	
esttab model1 model2 model3 model4 using ///
	"$tables/Appendix_fachgr_Engineering1.rtf" ///
     , replace not b(%9.6f) ///
       star nodepv nonum nogaps compress ///
       nomtitle label varwidth(15) ///
       title ("Supplement: Logistic regression, first “initiative” phase (2006-2011), engineering") ///
       scalars(r2_p) varlabel(_cons Intercept) unstack nobaselevels
	   
   
	
**2nd phase

use "$data/daten_gesamt_92-15_Exzellenz_regression_82.dta", clear

keep if LuFid==26 | LuFid==54 | LuFid==9 | LuFid==31 | LuFid==15 | LuFid==51 ///
		 | LuFid==6  | LuFid==40  | LuFid==8  | LuFid==52

	   
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
	"$tables/Appendix_fachgr_Engineering2.rtf" ///
     , replace not b(%9.6f) ///
       star nodepv nonum nogaps compress ///
       nomtitle label varwidth(15) ///
       title ("Supplement: Logistic regression, second “initiative” phase (2012-2017), engineering") ///
       scalars(r2_p) varlabel(_cons Intercept) unstack nobaselevels
	   

exit


********************************************************************************

