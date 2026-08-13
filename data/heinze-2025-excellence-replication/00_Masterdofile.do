/*==============================================================================
Replication files for peer review of the research article:

"Field size as a predictor of “excellence.” The selection of subject fields in 
Germany’s Excellence Initiative."
==============================================================================*/



* ======================================================================= *

* install ados
ssc install asdoc, replace
ssc install estout, replace


* ======================================================================= *
* Preparation

* 1) Define data path
global path "{data path}\"

* 2) make sure these folders exist within the data path:
global syntax 	 "${path}01_Syntax\"
global data   	 "${path}02_Data\"
global gendata	 "${path}03_Generated Datasets\"
global genexcel  "${path}04_Generated Excelfiles\"
global tables	 "${path}05_Tables\"

* 3) Doublecheck that the data sets (.dta) are in the "02_Data" folder and the replication files (.do) are in the "01_Syntax" folder

* ======================================================================= *
* 4) Run the following dofiles in Stata

do "${syntax}01_Syntax.do"
	/*	Replication files for:
		- Table 2
		- Table 3a, 3b
	*/

do "${syntax}02_Syntax.do"
	/*  Replication files for:
		- Table 4a, 4b
		- Appendix 7a, 7b, 7c, 7d
		- Appendix 8k, 8l
		- Appendix 9a, 9b, 9c, 9d
		- Appendix 10a, 10b
		- Appendix 11a, 11b, 11c, 11d, 11e, 11f, 11g
	*/
	
do "${syntax}02a_Syntax.do"
	/*  Replication files for:
		- Appendix 12
	*/
	
	
do "${syntax}03_Syntax (technical universities).do"
	/*  Replication files for:
		- Appendix 8b, 8d (Technical universities in Germany: n = 17)
	*/
	
do "${syntax}04_Syntax (non-technical universities).do"
	/*  Replication files for:
		- Appendix 8a and 8c (non-technical universities)
	*/
	
do "${syntax}05_Syntax (academic domains).do"
	/*  Replication Files for
		- Appendix 8e, 8f (natural science)
		- Appendix 8g, 8h (social science)
		- Appendix 8i, 8j (humanities)
		- Supplement (engineering)
	*/
	
beep
exit
