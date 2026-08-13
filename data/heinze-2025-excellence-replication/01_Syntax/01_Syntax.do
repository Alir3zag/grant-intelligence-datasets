/*==============================================================================
Replication files for:
- Table 2
- Table 3a, 3b
==============================================================================*/

use "$data/daten_gesamt_92-15_Exzellenz_reputation.dta", clear

** Total grant funding

tab ExzGefoerdertDummy

	keep if ExzGefoerdertDummy == 0
	collapse (sum) Drittmitteleinnahmen, by(EinheitlicheID DM_DFG_Mittel Jahr ExzGefoerdertDummy)
	collapse (sum) Drittmitteleinnahmen DM_DFG_Mittel, by(Jahr ExzGefoerdertDummy)
	sort Jahr
	replace Drittmitteleinnahmen = Drittmitteleinnahmen / 26
	replace DM_DFG_Mittel = DM_DFG_Mittel / 26
	replace DM_DFG_Mittel = DM_DFG_Mittel / 1000 // in million
	replace Drittmitteleinnahmen = Drittmitteleinnahmen / 1000 // in million
	generate Anteil = DM_DFG_Mittel / Drittmitteleinnahmen
	save "$gendata/Drittmittel_DFG_Tabelle_DM.dta", replace
	
use "$data/daten_gesamt_92-15_Exzellenz_reputation.dta", clear

	keep if ExzGefoerdertDummy == 1
	collapse (sum) Drittmitteleinnahmen, by(EinheitlicheID DM_DFG_Mittel Jahr ExzGefoerdertDummy)
	collapse (sum) Drittmitteleinnahmen DM_DFG_Mittel, by(Jahr ExzGefoerdertDummy)
	sort Jahr
	replace Drittmitteleinnahmen = Drittmitteleinnahmen / 42
	replace DM_DFG_Mittel = DM_DFG_Mittel / 42
	replace DM_DFG_Mittel = DM_DFG_Mittel / 1000 // in million
	replace Drittmitteleinnahmen = Drittmitteleinnahmen / 1000 // in million
	generate Anteil = DM_DFG_Mittel / Drittmitteleinnahmen
	save "$gendata/Drittmittel_DFG_Tabelle_DM2.dta", replace

	
use "$data/daten_gesamt_92-15_Exzellenz_reputation.dta", clear

	collapse (sum) Drittmitteleinnahmen, by(EinheitlicheID DM_DFG_Mittel Jahr)
	collapse (sum) Drittmitteleinnahmen DM_DFG_Mittel, by(Jahr)
	sort Jahr
	replace Drittmitteleinnahmen = Drittmitteleinnahmen / 68
	replace DM_DFG_Mittel = DM_DFG_Mittel / 68
	replace DM_DFG_Mittel = DM_DFG_Mittel / 1000 // in million
	replace Drittmitteleinnahmen = Drittmitteleinnahmen / 1000 // in million
	generate Anteil = DM_DFG_Mittel / Drittmitteleinnahmen
	generate ExzGefoerdertDummy_U = 2
	save "$gendata/Drittmittel_DFG_Tabelle_DM3.dta", replace

	
	
* Funded in all three funding lines
use "$data/daten_gesamt_92-15_Exzellenz_reputation.dta", clear

	keep if ExzDreiFLDummy_U == 1
	collapse (sum) Drittmitteleinnahmen, by(EinheitlicheID DM_DFG_Mittel Jahr ExzDreiFLDummy_U)
	collapse (sum) Drittmitteleinnahmen DM_DFG_Mittel, by(Jahr ExzDreiFLDummy_U)
	sort Jahr
	replace Drittmitteleinnahmen = Drittmitteleinnahmen / 14
	replace DM_DFG_Mittel = DM_DFG_Mittel / 14
	replace DM_DFG_Mittel = DM_DFG_Mittel / 1000 // in million
	replace Drittmitteleinnahmen = Drittmitteleinnahmen / 1000 // in million
	generate Anteil = DM_DFG_Mittel / Drittmitteleinnahmen
	generate ExzGefoerdertDummy_U = 3
	save "$gendata/Drittmittel_DFG_Tabelle_DM4.dta", replace
	
	

** Professors

use "$data/daten_gesamt_92-15_Exzellenz_reputation.dta", clear

tab ExzGefoerdertDummy

	keep if ExzGefoerdertDummy == 0
	collapse (sum) Profs, by(EinheitlicheID Jahr ExzGefoerdertDummy)
	collapse (sum) Profs, by(Jahr ExzGefoerdertDummy)
	sort Jahr
	replace Profs = Profs / 26
	save "$gendata/Drittmittel_DFG_Tabelle_Profs.dta", replace
	
	
	
use "$data/daten_gesamt_92-15_Exzellenz_reputation.dta", clear

	keep if ExzGefoerdertDummy == 1
	collapse (sum) Profs, by(EinheitlicheID Jahr ExzGefoerdertDummy)
	collapse (sum) Profs, by(Jahr ExzGefoerdertDummy)
	sort Jahr
	replace Profs = Profs / 42
	save "$gendata/Drittmittel_DFG_Tabelle_Profs2.dta", replace
	
	
use "$data/daten_gesamt_92-15_Exzellenz_reputation.dta", clear

	collapse (sum) Profs, by(EinheitlicheID Jahr ExzGefoerdertDummy)
	collapse (sum) Profs, by(Jahr)
	sort Jahr
	replace Profs = Profs / 68
	generate ExzGefoerdertDummy_U = 2
	save "$gendata/Drittmittel_DFG_Tabelle_Profs3.dta", replace

	
	
* Funded in all three funding lines
use "$data/daten_gesamt_92-15_Exzellenz_reputation.dta", clear

	keep if ExzDreiFLDummy_U == 1
	collapse (sum) Profs, by(EinheitlicheID Jahr ExzDreiFLDummy_U)
	collapse (sum) Profs, by(Jahr ExzDreiFLDummy_U)
	sort Jahr
	replace Profs = Profs / 14
	generate ExzGefoerdertDummy_U = 3
	save "$gendata/Drittmittel_DFG_Tabelle_Profs4.dta", replace

	
	
** Students

use "$data/daten_gesamt_92-15_Exzellenz_reputation.dta", clear

tab ExzGefoerdertDummy

	keep if ExzGefoerdertDummy == 0
	collapse (sum) StudierendeGesamt, by(EinheitlicheID Jahr ExzGefoerdertDummy)
	collapse (sum) StudierendeGesamt, by(Jahr ExzGefoerdertDummy)
	sort Jahr
	replace StudierendeGesamt = StudierendeGesamt / 26
	save "$gendata/Drittmittel_DFG_Tabelle_Stud.dta", replace

	
	
use "$data/daten_gesamt_92-15_Exzellenz_reputation.dta", clear

	keep if ExzGefoerdertDummy == 1
	collapse (sum) StudierendeGesamt, by(EinheitlicheID Jahr ExzGefoerdertDummy)
	collapse (sum) StudierendeGesamt, by(Jahr ExzGefoerdertDummy)
	sort Jahr
	replace StudierendeGesamt = StudierendeGesamt / 42
	save "$gendata/Drittmittel_DFG_Tabelle_Stud2.dta", replace

	
use "$data/daten_gesamt_92-15_Exzellenz_reputation.dta", clear

	collapse (sum) StudierendeGesamt, by(EinheitlicheID Jahr ExzGefoerdertDummy)
	collapse (sum) StudierendeGesamt, by(Jahr)
	sort Jahr
	replace StudierendeGesamt = StudierendeGesamt / 68
	generate ExzGefoerdertDummy_U = 2
	save "$gendata/Drittmittel_DFG_Tabelle_Stud3.dta", replace
	
	
	
* Funded in all three funding lines
use "$data/daten_gesamt_92-15_Exzellenz_reputation.dta", clear

	keep if ExzDreiFLDummy_U == 1
	collapse (sum) StudierendeGesamt, by(EinheitlicheID Jahr ExzDreiFLDummy_U)
	collapse (sum) StudierendeGesamt, by(Jahr ExzDreiFLDummy_U)
	sort Jahr
	replace StudierendeGesamt = StudierendeGesamt / 14
	generate ExzGefoerdertDummy_U = 3
	save "$gendata/Drittmittel_DFG_Tabelle_Stud4.dta", replace
	
	
	
** Citations

use "$data/daten_gesamt_92-15_Exzellenz_reputation.dta", clear

tab ExzGefoerdertDummy

	keep if ExzGefoerdertDummy == 0
	collapse (sum) Zitationen, by(EinheitlicheID Jahr ExzGefoerdertDummy)
	collapse (sum) Zitationen, by(Jahr ExzGefoerdertDummy)
	sort Jahr
	replace Zitationen = Zitationen / 26
	save "$gendata/Drittmittel_DFG_Tabelle_Zit.dta", replace

	
	
use "$data/daten_gesamt_92-15_Exzellenz_reputation.dta", clear

	keep if ExzGefoerdertDummy == 1
	collapse (sum) Zitationen, by(EinheitlicheID Jahr ExzGefoerdertDummy)
	collapse (sum) Zitationen, by(Jahr ExzGefoerdertDummy)
	sort Jahr
	replace Zitationen = Zitationen / 42
	save "$gendata/Drittmittel_DFG_Tabelle_Zit2.dta", replace

	
use "$data/daten_gesamt_92-15_Exzellenz_reputation.dta", clear

	collapse (sum) Zitationen, by(EinheitlicheID Jahr ExzGefoerdertDummy)
	collapse (sum) Zitationen, by(Jahr)
	sort Jahr
	replace Zitationen = Zitationen / 68
	generate ExzGefoerdertDummy_U = 2
	save "$gendata/Drittmittel_DFG_Tabelle_Zit3.dta", replace
	
	
* Funded in all three funding lines
use "$data/daten_gesamt_92-15_Exzellenz_reputation.dta", clear

	keep if ExzDreiFLDummy_U == 1
	collapse (sum) Zitationen, by(EinheitlicheID Jahr ExzDreiFLDummy_U)
	collapse (sum) Zitationen, by(Jahr ExzDreiFLDummy_U)
	sort Jahr
	replace Zitationen = Zitationen / 14
	generate ExzGefoerdertDummy_U = 3
	save "$gendata/Drittmittel_DFG_Tabelle_Zit4.dta", replace
	
	
	
	
** Publications

use "$data/daten_gesamt_92-15_Exzellenz_reputation.dta", clear

tab ExzGefoerdertDummy

	keep if ExzGefoerdertDummy == 0
	collapse (sum) Publikationen, by(EinheitlicheID Jahr ExzGefoerdertDummy)
	collapse (sum) Publikationen, by(Jahr ExzGefoerdertDummy)
	sort Jahr
	replace Publikationen = Publikationen / 26
	save "$gendata/Drittmittel_DFG_Tabelle_Pub.dta", replace

	
	
use "$data/daten_gesamt_92-15_Exzellenz_reputation.dta", clear

	keep if ExzGefoerdertDummy == 1
	collapse (sum) Publikationen, by(EinheitlicheID Jahr ExzGefoerdertDummy)
	collapse (sum) Publikationen, by(Jahr ExzGefoerdertDummy)
	sort Jahr
	replace Publikationen = Publikationen / 42
	save "$gendata/Drittmittel_DFG_Tabelle_Pub2.dta", replace

	
use "$data/daten_gesamt_92-15_Exzellenz_reputation.dta", clear

	collapse (sum) Publikationen, by(EinheitlicheID Jahr ExzGefoerdertDummy)
	collapse (sum) Publikationen, by(Jahr)
	sort Jahr
	replace Publikationen = Publikationen / 68
	generate ExzGefoerdertDummy_U = 2
	save "$gendata/Drittmittel_DFG_Tabelle_Pub3.dta", replace
	
	
* Funded in all three funding lines
use "$data/daten_gesamt_92-15_Exzellenz_reputation.dta", clear

	keep if ExzDreiFLDummy_U == 1
	collapse (sum) Publikationen, by(EinheitlicheID Jahr ExzDreiFLDummy_U)
	collapse (sum) Publikationen, by(Jahr ExzDreiFLDummy_U)
	sort Jahr
	replace Publikationen = Publikationen / 14
	generate ExzGefoerdertDummy_U = 3
	save "$gendata/Drittmittel_DFG_Tabelle_Pub4.dta", replace
	
	
	

	
	
********************************************************************************
********************************************************************************
** Add data for 2018

** Total grant funding
use "$data/daten_gesamt_16-18_Exzellenz_hilfsdaten.dta", clear

tab ExzGefoerdertDummy

	keep if ExzGefoerdertDummy == 0
	collapse (sum) Drittmitteleinnahmen, by(EinheitlicheID Jahr ExzGefoerdertDummy)
	collapse (sum) Drittmitteleinnahmen, by(Jahr ExzGefoerdertDummy)
	sort Jahr
	replace Drittmitteleinnahmen = Drittmitteleinnahmen / 26
	replace Drittmitteleinnahmen = Drittmitteleinnahmen / 1000 // in million
	append using "$gendata/Drittmittel_DFG_Tabelle_DM.dta"	
	sort Jahr
	save "$gendata/Drittmittel_DFG_Tabelle_DM.dta", replace
	
use "$data\daten_gesamt_16-18_Exzellenz_hilfsdaten.dta", clear

	keep if ExzGefoerdertDummy == 1
	collapse (sum) Drittmitteleinnahmen, by(EinheitlicheID Jahr ExzGefoerdertDummy)
	collapse (sum) Drittmitteleinnahmen , by(Jahr ExzGefoerdertDummy)
	sort Jahr
	replace Drittmitteleinnahmen = Drittmitteleinnahmen / 42
	replace Drittmitteleinnahmen = Drittmitteleinnahmen / 1000 // in million
	append using "$gendata/Drittmittel_DFG_Tabelle_DM2.dta" 
	sort Jahr
	save "$gendata/Drittmittel_DFG_Tabelle_DM2.dta" , replace
	
	
use "$data/daten_gesamt_16-18_Exzellenz_hilfsdaten.dta", clear

	collapse (sum) Drittmitteleinnahmen, by(EinheitlicheID Jahr)
	collapse (sum) Drittmitteleinnahmen, by(Jahr)
	sort Jahr
	replace Drittmitteleinnahmen = Drittmitteleinnahmen / 68
	replace Drittmitteleinnahmen = Drittmitteleinnahmen / 1000 // in million
	generate ExzGefoerdertDummy_U = 2
	append using "$gendata/Drittmittel_DFG_Tabelle_DM3.dta" 
	sort Jahr
	save "$gendata/Drittmittel_DFG_Tabelle_DM3.dta", replace
	
	
* Funded in all three funding lines
use "$data/daten_gesamt_16-18_Exzellenz_hilfsdaten.dta", clear

	keep if ExzDreiFLDummy_U == 1
	collapse (sum) Drittmitteleinnahmen, by(EinheitlicheID Jahr ExzDreiFLDummy_U)
	collapse (sum) Drittmitteleinnahmen, by(Jahr ExzDreiFLDummy_U)
	sort Jahr
	replace Drittmitteleinnahmen = Drittmitteleinnahmen / 14
	replace Drittmitteleinnahmen = Drittmitteleinnahmen / 1000 // in million
	generate ExzGefoerdertDummy_U = 3
	append using "$gendata/Drittmittel_DFG_Tabelle_DM4.dta" 
	sort Jahr
	save "$gendata/Drittmittel_DFG_Tabelle_DM4.dta", replace
	

** Professors

use "$data/daten_gesamt_16-18_Exzellenz_hilfsdaten.dta", clear

tab ExzGefoerdertDummy

	keep if ExzGefoerdertDummy == 0
	collapse (sum) Profs, by(EinheitlicheID Jahr ExzGefoerdertDummy)
	collapse (sum) Profs, by(Jahr ExzGefoerdertDummy)
	sort Jahr
	replace Profs = Profs / 26
	append using "$gendata/Drittmittel_DFG_Tabelle_Profs.dta"
	sort Jahr
	save "$gendata/Drittmittel_DFG_Tabelle_Profs.dta" , replace
	
	
use "$data/daten_gesamt_16-18_Exzellenz_hilfsdaten.dta", clear

	keep if ExzGefoerdertDummy == 1
	collapse (sum) Profs, by(EinheitlicheID Jahr ExzGefoerdertDummy)
	collapse (sum) Profs, by(Jahr ExzGefoerdertDummy)
	sort Jahr
	replace Profs = Profs / 42
	append using "$gendata/Drittmittel_DFG_Tabelle_Profs2.dta" 
	sort Jahr
	save "$gendata/Drittmittel_DFG_Tabelle_Profs2.dta", replace
	
use "$data/daten_gesamt_16-18_Exzellenz_hilfsdaten.dta", clear

	collapse (sum) Profs, by(EinheitlicheID Jahr ExzGefoerdertDummy)
	collapse (sum) Profs, by(Jahr)
	sort Jahr
	replace Profs = Profs / 68
	generate ExzGefoerdertDummy_U = 2
	append using "$gendata/Drittmittel_DFG_Tabelle_Profs3.dta" 
	sort Jahr
	save "$gendata/Drittmittel_DFG_Tabelle_Profs3.dta" , replace
	
	
* Funded in all three funding lines
use "$data/daten_gesamt_16-18_Exzellenz_hilfsdaten.dta", clear

	keep if ExzDreiFLDummy_U == 1
	collapse (sum) Profs, by(EinheitlicheID Jahr ExzDreiFLDummy_U)
	collapse (sum) Profs, by(Jahr ExzDreiFLDummy_U)
	sort Jahr
	replace Profs = Profs / 14
	generate ExzGefoerdertDummy_U = 3
	append using "$gendata/Drittmittel_DFG_Tabelle_Profs4.dta" 
	sort Jahr
	save "$gendata/Drittmittel_DFG_Tabelle_Profs4.dta" , replace
	
	
** Students

use "$data/daten_gesamt_16-18_Exzellenz_hilfsdaten.dta", clear

tab ExzGefoerdertDummy

	keep if ExzGefoerdertDummy == 0
	collapse (sum) StudierendeGesamt, by(EinheitlicheID Jahr ExzGefoerdertDummy)
	collapse (sum) StudierendeGesamt, by(Jahr ExzGefoerdertDummy)
	sort Jahr
	replace StudierendeGesamt = StudierendeGesamt / 26
	append using "$gendata/Drittmittel_DFG_Tabelle_Stud.dta" 
	sort Jahr
	save "$gendata/Drittmittel_DFG_Tabelle_Stud.dta", replace
	
	
use "$data/daten_gesamt_16-18_Exzellenz_hilfsdaten.dta", clear

	keep if ExzGefoerdertDummy == 1
	collapse (sum) StudierendeGesamt, by(EinheitlicheID Jahr ExzGefoerdertDummy)
	collapse (sum) StudierendeGesamt, by(Jahr ExzGefoerdertDummy)
	sort Jahr
	replace StudierendeGesamt = StudierendeGesamt / 42
	append using "$gendata/Drittmittel_DFG_Tabelle_Stud2.dta" 
	sort Jahr
	save "$gendata/Drittmittel_DFG_Tabelle_Stud2.dta", replace
	
	
use "$data/daten_gesamt_16-18_Exzellenz_hilfsdaten.dta", clear

	collapse (sum) StudierendeGesamt, by(EinheitlicheID Jahr ExzGefoerdertDummy)
	collapse (sum) StudierendeGesamt, by(Jahr)
	sort Jahr
	replace StudierendeGesamt = StudierendeGesamt / 68
	generate ExzGefoerdertDummy_U = 2
	append using "$gendata/Drittmittel_DFG_Tabelle_Stud3.dta" 
	sort Jahr
	save "$gendata/Drittmittel_DFG_Tabelle_Stud3.dta" , replace
	
	
* Funded in all three funding lines
use "$data/daten_gesamt_16-18_Exzellenz_hilfsdaten.dta", clear

	keep if ExzDreiFLDummy_U == 1
	collapse (sum) StudierendeGesamt, by(EinheitlicheID Jahr ExzDreiFLDummy_U)
	collapse (sum) StudierendeGesamt, by(Jahr ExzDreiFLDummy_U)
	sort Jahr
	replace StudierendeGesamt = StudierendeGesamt / 14
	generate ExzGefoerdertDummy_U = 3
	append using "$gendata/Drittmittel_DFG_Tabelle_Stud4.dta" 
	sort Jahr
	save "$gendata/Drittmittel_DFG_Tabelle_Stud4.dta" , replace
	
	
** Citations

use "$data/daten_gesamt_16-18_Exzellenz_hilfsdaten.dta", clear

tab ExzGefoerdertDummy

	keep if ExzGefoerdertDummy == 0
	collapse (sum) Zitationen, by(EinheitlicheID Jahr ExzGefoerdertDummy)
	collapse (sum) Zitationen, by(Jahr ExzGefoerdertDummy)
	sort Jahr
	replace Zitationen = Zitationen / 26
	append using "$gendata/Drittmittel_DFG_Tabelle_Zit.dta" 
	sort Jahr
	save "$gendata/Drittmittel_DFG_Tabelle_Zit.dta", replace
	
	
use "$data/daten_gesamt_16-18_Exzellenz_hilfsdaten.dta", clear

	keep if ExzGefoerdertDummy == 1
	collapse (sum) Zitationen, by(EinheitlicheID Jahr ExzGefoerdertDummy)
	collapse (sum) Zitationen, by(Jahr ExzGefoerdertDummy)
	sort Jahr
	replace Zitationen = Zitationen / 42
	append using "$gendata/Drittmittel_DFG_Tabelle_Zit2.dta" 
	sort Jahr
	save "$gendata/Drittmittel_DFG_Tabelle_Zit2.dta" , replace
	
use "$data/daten_gesamt_16-18_Exzellenz_hilfsdaten.dta", clear

	collapse (sum) Zitationen, by(EinheitlicheID Jahr ExzGefoerdertDummy)
	collapse (sum) Zitationen, by(Jahr)
	sort Jahr
	replace Zitationen = Zitationen / 68
	generate ExzGefoerdertDummy_U = 2
	append using "$gendata/Drittmittel_DFG_Tabelle_Zit3.dta" 
	sort Jahr
	save "$gendata/Drittmittel_DFG_Tabelle_Zit3.dta", replace
	
* Funded in all three funding lines
use "$data/daten_gesamt_16-18_Exzellenz_hilfsdaten.dta", clear

	keep if ExzDreiFLDummy_U == 1
	collapse (sum) Zitationen, by(EinheitlicheID Jahr ExzDreiFLDummy_U)
	collapse (sum) Zitationen, by(Jahr ExzDreiFLDummy_U)
	sort Jahr
	replace Zitationen = Zitationen / 14
	generate ExzGefoerdertDummy_U = 3
	append using "$gendata/Drittmittel_DFG_Tabelle_Zit4.dta" 
	sort Jahr
	save "$gendata/Drittmittel_DFG_Tabelle_Zit4.dta", replace
	

*** Add DFG funding

use "$data\dm_dfg_mittel_hilfsdaten2018.dta", clear

tab ExzGefoerdertDummy

	keep if ExzGefoerdertDummy == 0
	collapse (sum) DM_DFG_Mittel, by(EinheitlicheID Jahr ExzGefoerdertDummy)
	collapse (sum) DM_DFG_Mittel, by(Jahr ExzGefoerdertDummy)
	sort Jahr
	replace DM_DFG_Mittel = DM_DFG_Mittel / 26
	replace DM_DFG_Mittel = DM_DFG_Mittel / 1000 // in million
	merge 1:1 Jahr ExzGefoerdertDummy using "$gendata/Drittmittel_DFG_Tabelle_DM.dta", update
	sort Jahr
	drop _merge
	save "$gendata/Drittmittel_DFG_Tabelle_DM.dta", replace
	
use "$data\dm_dfg_mittel_hilfsdaten2018.dta", clear

	keep if ExzGefoerdertDummy == 1
	collapse (sum) DM_DFG_Mittel, by(EinheitlicheID Jahr ExzGefoerdertDummy)
	collapse (sum) DM_DFG_Mittel , by(Jahr ExzGefoerdertDummy)
	sort Jahr
	replace DM_DFG_Mittel = DM_DFG_Mittel / 42
	replace DM_DFG_Mittel = DM_DFG_Mittel / 1000 // in million
	merge 1:1 Jahr ExzGefoerdertDummy using "$gendata/Drittmittel_DFG_Tabelle_DM2.dta" , update
	sort Jahr
	drop _merge
	save "$gendata/Drittmittel_DFG_Tabelle_DM2.dta" , replace
	
	
use "$data\dm_dfg_mittel_hilfsdaten2018.dta", clear

	collapse (sum) DM_DFG_Mittel, by(EinheitlicheID Jahr)
	collapse (sum) DM_DFG_Mittel, by(Jahr)
	sort Jahr
	replace DM_DFG_Mittel = DM_DFG_Mittel / 68
	replace DM_DFG_Mittel = DM_DFG_Mittel / 1000 // in million
	generate ExzGefoerdertDummy_U = 2
	merge 1:1 Jahr ExzGefoerdertDummy using "$gendata/Drittmittel_DFG_Tabelle_DM3.dta" , update
	sort Jahr
	drop _merge
	save "$gendata/Drittmittel_DFG_Tabelle_DM3.dta", replace
	
	
* Funded in all three funding lines
use "$data\dm_dfg_mittel_hilfsdaten2018.dta", clear

	keep if ExzDreiFLDummy_U == 1
	collapse (sum) DM_DFG_Mittel, by(EinheitlicheID Jahr ExzDreiFLDummy_U)
	collapse (sum) DM_DFG_Mittel, by(Jahr ExzDreiFLDummy_U)
	sort Jahr
	replace DM_DFG_Mittel = DM_DFG_Mittel / 14
	replace DM_DFG_Mittel = DM_DFG_Mittel / 1000 // in million
	generate ExzGefoerdertDummy_U = 3
	merge 1:1 Jahr ExzGefoerdertDummy using "$gendata/Drittmittel_DFG_Tabelle_DM4.dta" , update
	sort Jahr
	drop _merge
	save "$gendata/Drittmittel_DFG_Tabelle_DM4.dta", replace
********************************************************************************
********************************************************************************





** Merge data sets
	use "$gendata/Drittmittel_DFG_Tabelle_DM.dta", clear
	merge m:m Jahr ExzGefoerdertDummy_U using "$gendata/Drittmittel_DFG_Tabelle_DM2.dta", nolabel update
	drop _merge
	merge m:m Jahr ExzGefoerdertDummy_U using "$gendata/Drittmittel_DFG_Tabelle_DM3.dta", nolabel update
	drop _merge
	merge m:m Jahr ExzGefoerdertDummy_U using "$gendata/Drittmittel_DFG_Tabelle_DM4.dta", nolabel update
	drop _merge
	merge m:m Jahr ExzGefoerdertDummy_U using "$gendata/Drittmittel_DFG_Tabelle_Profs.dta", nolabel update
	drop _merge
	merge m:m Jahr ExzGefoerdertDummy_U using "$gendata/Drittmittel_DFG_Tabelle_Profs2.dta", nolabel update
	drop _merge
	merge m:m Jahr ExzGefoerdertDummy_U using "$gendata/Drittmittel_DFG_Tabelle_Profs3.dta", nolabel update
	drop _merge
	merge m:m Jahr ExzGefoerdertDummy_U using "$gendata/Drittmittel_DFG_Tabelle_Profs4.dta", nolabel update
	drop _merge
	merge m:m Jahr ExzGefoerdertDummy_U using "$gendata/Drittmittel_DFG_Tabelle_Stud.dta", nolabel update
	drop _merge
	merge m:m Jahr ExzGefoerdertDummy_U using "$gendata/Drittmittel_DFG_Tabelle_Stud2.dta", nolabel update
	drop _merge
	merge m:m Jahr ExzGefoerdertDummy_U using "$gendata/Drittmittel_DFG_Tabelle_Stud3.dta", nolabel update
	drop _merge
	merge m:m Jahr ExzGefoerdertDummy_U using "$gendata/Drittmittel_DFG_Tabelle_Stud4.dta", nolabel update
	drop _merge
	merge m:m Jahr ExzGefoerdertDummy_U using "$gendata/Drittmittel_DFG_Tabelle_Zit.dta", nolabel update
	drop _merge
	merge m:m Jahr ExzGefoerdertDummy_U using "$gendata/Drittmittel_DFG_Tabelle_Zit2.dta", nolabel update
	drop _merge
	merge m:m Jahr ExzGefoerdertDummy_U using "$gendata/Drittmittel_DFG_Tabelle_Zit3.dta", nolabel update
	drop _merge
	merge m:m Jahr ExzGefoerdertDummy_U using "$gendata/Drittmittel_DFG_Tabelle_Zit4.dta", nolabel update
	drop _merge
	merge m:m Jahr ExzGefoerdertDummy_U using "$gendata/Drittmittel_DFG_Tabelle_Pub.dta", nolabel update
	drop _merge
	merge m:m Jahr ExzGefoerdertDummy_U using "$gendata/Drittmittel_DFG_Tabelle_Pub2.dta", nolabel update
	drop _merge
	merge m:m Jahr ExzGefoerdertDummy_U using "$gendata/Drittmittel_DFG_Tabelle_Pub3.dta", nolabel update
	drop _merge
	merge m:m Jahr ExzGefoerdertDummy_U using "$gendata/Drittmittel_DFG_Tabelle_Pub4.dta", nolabel update
	drop _merge


label define foerderung 0 "nicht gefördert" 1 "gefördert" 2 "alle Unis" 3 "in 3 Linien gefördert"
label val ExzGefoerdertDummy_U foerderung

drop ExzDreiFLDummy_U
sort Jahr ExzGefoerdertDummy_U

cd "$gendata"
shell erase Drittmittel_DFG_Tabelle_DM.dta
shell erase Drittmittel_DFG_Tabelle_DM2.dta
shell erase Drittmittel_DFG_Tabelle_DM3.dta
shell erase Drittmittel_DFG_Tabelle_DM4.dta
shell erase Drittmittel_DFG_Tabelle_Profs.dta
shell erase Drittmittel_DFG_Tabelle_Profs2.dta
shell erase Drittmittel_DFG_Tabelle_Profs3.dta
shell erase Drittmittel_DFG_Tabelle_Profs4.dta
shell erase Drittmittel_DFG_Tabelle_Stud.dta
shell erase Drittmittel_DFG_Tabelle_Stud2.dta
shell erase Drittmittel_DFG_Tabelle_Stud3.dta
shell erase Drittmittel_DFG_Tabelle_Stud4.dta
shell erase Drittmittel_DFG_Tabelle_Zit.dta
shell erase Drittmittel_DFG_Tabelle_Zit2.dta
shell erase Drittmittel_DFG_Tabelle_Zit3.dta
shell erase Drittmittel_DFG_Tabelle_Zit4.dta
shell erase Drittmittel_DFG_Tabelle_Pub.dta
shell erase Drittmittel_DFG_Tabelle_Pub2.dta
shell erase Drittmittel_DFG_Tabelle_Pub3.dta
shell erase Drittmittel_DFG_Tabelle_Pub4.dta

drop Anteil
order Jahr Exz* Profs DM_DFG* Drittmittel* Zitationen StudierendeGesamt Publikationen
export excel using "$genexcel/Table2_full.xlsx", firstrow(variables) replace





********************************************************************************
	
* Cross tables
use "$data/daten_gesamt_92-15_Exzellenz_reputation.dta", clear

keep if Jahr == 2008 | Jahr == 2013

collapse (mean)	Linien_UJ, by(EinheitlicheID Jahr)

label define Linien_UJ_lbl 0 "keine Foerderung" 1 "eine Linie" 2 "zwei Linien" 3 "drei Linien"
label val Linien_UJ Linien_UJ_lbl
label var Linien_UJ "Foerderlinien"

label var Jahr "Foerderphasen"
label define jahr_lbl 2008 "Erste Phase" 2013 "Zweite Phase"
label val Jahr jahr_lbl

reshape wide Linien_UJ, i(EinheitlicheID) j(Jahr)
label var Linien_UJ2008 "Erste Phase"
label var Linien_UJ2013 "Zweite Phase"

tab Linien_UJ2008 Linien_UJ2013, chi

* Check for duplicates
duplicates report EinheitlicheID

cd "$tables"
asdoc tab Linien_UJ2008 Linien_UJ2013, replace /// 
	save(Table3b.doc) ///
	title(Number of universities by funding phase)

********************************************************************************
********************************************************************************

use "$data/daten_gesamt_92-15_Exzellenz_reputation.dta", clear
* Due to subject duplicates, drop all subjects that have missings on all relevant variables:
drop if Fachgruppe==.
drop if Profs==. & Drittmitteleinnahmen==. & StudierendeGesamt==. & Zitationen==.
* recode missings
recode Profs Drittmitteleinnahmen StudierendeGesamt Zitationen (.=0)

keep if Jahr == 2008 | Jahr == 2013

collapse (mean)  Exz_EC1_FJ Exz_EC2_FJ Exz_GS1_FJ Exz_GS2_FJ, by(EinheitlicheID LuFid Jahr)
reshape wide Exz_EC1_FJ Exz_EC2_FJ Exz_GS1_FJ Exz_GS2_FJ, i(EinheitlicheID LuFid) j(Jahr)

* Check duplicates
duplicates report LuFid EinheitlicheID

generate foerderung_1 = Exz_EC1_FJ2008 + Exz_GS1_FJ2008
generate foerderung_2 = Exz_EC2_FJ2013 + Exz_GS2_FJ2013
recode foerderung_1 foerderung_2 (.=0)


label var foerderung_1 "Erste Phase"
label var foerderung_2 "Zweite Phase"

label define anzahl_lbl 0 "keine Foerderung" 1 "eine Linie" 2 "zwei Linien"
label val foerderung_1 foerderung_2 anzahl_lbl

tab foerderung_1 foerderung_2, chi

cd "$tables"
asdoc tab foerderung_1 foerderung_2, mis replace /// 
	save(Table3a.doc) ///
	title(Number of subject fields by funding phase)


exit