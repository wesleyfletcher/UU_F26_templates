*********************************************************************************************
May 2022

** PUBLIC-USE LINKED MORTALITY FOLLOW-UP THROUGH DECEMBER 31, 2019 **

The following SAS code can be used to read the fixed-width format ASCII public-use Linked
Mortality Files (LMFs) from a stored location into a temporary SAS work dataset.  Basic 
frequencies are also produced.  
 
NOTE:  The format definitions given below will result in
       procedure output showing values that have been
       grouped as they are shown in the file layout
       documentation.

NOTE:  In order to read the public-use linked mortality ASCII file 
       into a permanent SAS dataset, please consult SAS documentation
       and modify the program accordingly.

NOTE:  As some variables are survey-specific, we have created two versions of the program. 
		One is for the National Health and Nutrition Examination Survey (NHANES), 
		and the other is for the National Health Interview Survey (NHIS).

*********************************************************************************************


To download and save the public-use LMFs to your hard drive, follow these steps:

*Step 1: Designate a folder on your hard drive to download the public-use LMF. 
		 In this example, the data will be saved to: "C:\PUBLIC USE DATA\".

*Step 2: To download the public-use LMF, go to the website: 
	     https://ftp.cdc.gov/pub/health_statistics/nchs/datalinkage/linked_mortality/.

         Right-click on the desired survey link and select "Save target as...".  A "Save As"
         screen will appear where you will need to select and input a location where to
         save the data file on your hard drive.  

         Also note that the "Save as type:" box should read "DAT File (*.dat)".  This will ensure
         that the data file is saved to your hard drive in the correct format.  

         In this example, the data file is saved in the folder, "C:\PUBLIC USE DATA\", and the 
         data file is saved as "<SURVEYNAME>_MORT_2019_PUBLIC.DAT". 





*****************;
*MACRO VARIABLES*;
*****************;

** This is the name of the survey. The program will pass this information to the appropriate places.
** You only need to enter it here ;
%LET SURVEY=NHANES_2003_2004 ; /* For example, NHIS_1986 or NHANES_1999_2000*/

** This is the file location where you have downloaded the public file on your computer.
** Don't forget the last "\".;
%LET INFILNM=C:\PUBLIC USE DATA\;


**************;
*NHIS VERSION*;
**************;

* Define variable values for reports;
PROC FORMAT;
   
  VALUE ELIGFMT
    1 = "Eligible"
    2 = "Under age 18, not available for public release"
    3 = "Ineligible" ;

  VALUE MORTFMT
    0 = "Assumed alive"
    1 = "Assumed deceased"
    . = "Ineligible or under age 18";

  VALUE FLAGFMT
    0 = "No - Condition not listed as a multiple cause of death"
    1 = "Yes - Condition listed as a multiple cause of death"  
    . = "Assumed alive, under age 18, ineligible for mortality follow-up, or MCOD not available";

  VALUE QRTFMT
    1 = "January-March"
    2 = "April-June"
    3 = "July-September"
    4 = "October-December" 
    . = "Ineligible, under age 18, or assumed alive";

  VALUE DODYFMT
    . = "Ineligible, under age 18, or assumed alive";

  VALUE $UCODFMT
		"001" = "Diseases of heart (I00-I09, I11, I13, I20-I51)"
		"002" = "Malignant neoplasms (C00-C97)"
		"003" = "Chronic lower respiratory diseases (J40-J47)"
		"004" = "Accidents (unintentional injuries) (V01-X59, Y85-Y86)"
		"005" = "Cerebrovascular diseases (I60-I69)"
		"006" = "Alzheimer's disease (G30)"
		"007" = "Diabetes mellitus (E10-E14)"
		"008" = "Influenza and pneumonia (J09-J18)"
		"009" = "Nephritis, nephrotic syndrome and nephrosis (N00-N07, N17-N19, N25-N27)"
		"010" = "All other causes (residual)" 
		"   " = "Ineligible, under age 18, assumed alive, or no cause of death data available" ;

RUN;


*Create a temporary SAS work dataset;
DATA &SURVEY.;		

INFILE "&INFILNM.&SURVEY._MORT_2019_PUBLIC.dat"  LRECL = 61 PAD MISSOVER ;

* INPUT VARIABLES;
INPUT
	PUBLICID		$1-14 	
	ELIGSTAT		15
	MORTSTAT		16
	UCOD_LEADING	$17-19
	DIABETES		20
	HYPERTEN		21
	DODQTR			22		
	DODYEAR			23-26	
	WGT_NEW			27-34	
	SA_WGT_NEW		35-42 	
     ;

* DEFINE VARIABLE LABELS;
LABEL
	PUBLICID		=	'NHIS public use ID'
	ELIGSTAT		=	'Eligibility Status for Mortality Follow-up'
	MORTSTAT		=	'Final Mortality Status'
	UCOD_LEADING	=	'Underlying Leading Cause of Death: Recode'
	DIABETES		=	'Diabetes Flag from Multiple Cause of Death (MCOD)'
	HYPERTEN		=	'Hypertension Flag from Multiple Cause of Death (MCOD)'
	DODQTR			=	'Quarter of Death: NHIS only'
	DODYEAR			=	'Year of Death: NHIS only'
	WGT_NEW			=	'Weight Adjusted for Ineligible Respondents: Person-level Sample Weight'
	SA_WGT_NEW		=	'Weight Adjusted for Ineligible Respondents: Sample Adult Sample Weight'
;
   * ASSOCIATE VARIABLES WITH FORMAT VALUES;
FORMAT    
	ELIGSTAT 		ELIGFMT.          
	MORTSTAT 		MORTFMT.
	UCOD_LEADING	UCODFMT.
	DIABETES 		FLAGFMT.          
	HYPERTEN 		FLAGFMT. 
	DODQTR   		QRTFMT.           
	DODYEAR  		DODYFMT.

;
RUN;

OPTIONS PAGENO=1;
TITLE1 "&SURVEY. PUBLIC-USE LINKED MORTALITY FILE";

*RUN PROC CONTENTS;
PROC CONTENTS DATA=&SURVEY. VARNUM; RUN;

*RUN FREQUENCIES;
PROC FREQ DATA=&SURVEY.;
TABLES 
	ELIGSTAT
	MORTSTAT 
	UCOD_LEADING 
	DIABETES
	HYPERTEN 
	DODQTR		
	DODYEAR		
	/ MISSING;
TITLE1 "&SURVEY. PUBLIC-USE LINKED MORTALITY FILE";
TITLE2 "UNWEIGHTED FREQUENCIES";

* USER NOTE: TO SEE UNFORMATTED VALUES IN THE FREQUENCY PROCEDURE, 
  UNCOMMENT THE STATEMENT "FORMAT _ALL_" BELOW ;
* FORMAT _ALL_;
RUN;



****************;
*NHANES VERSION*;
****************;

* Define variable values for reports;
PROC FORMAT;
  VALUE PREMISS 
	.='MISSING'
   	OTHER='PRESENT';

  VALUE ELIGFMT
    1 = "Eligible"
    2 = "Under age 18, not available for public release"
    3 = "Ineligible";

  VALUE MORTFMT
    0 = "Assumed alive"
    1 = "Assumed deceased"
    . = "Ineligible or under age 18";

  VALUE FLAGFMT
    0 = "No - Condition not listed as a multiple cause of death"
    1 = "Yes - Condition listed as a multiple cause of death"  
    . = "Assumed alive, under age 18, ineligible for mortality follow-up, or MCOD not available";

  VALUE $UCODFMT
		"001" = "Diseases of heart (I00-I09, I11, I13, I20-I51)"
		"002" = "Malignant neoplasms (C00-C97)"
		"003" = "Chronic lower respiratory diseases (J40-J47)"
		"004" = "Accidents (unintentional injuries) (V01-X59, Y85-Y86)"
		"005" = "Cerebrovascular diseases (I60-I69)"
		"006" = "Alzheimer's disease (G30)"
		"007" = "Diabetes mellitus (E10-E14)"
		"008" = "Influenza and pneumonia (J09-J18)"
		"009" = "Nephritis, nephrotic syndrome and nephrosis (N00-N07, N17-N19, N25-N27)"
		"010" = "All other causes (residual)" 
		"   " = "Ineligible, under age 18, assumed alive, or no cause of death data available";

RUN;


*Create a temporary SAS work dataset;

DATA &SURVEY.;		
INFILE "&INFILNM.&SURVEY._MORT_2019_PUBLIC.dat"  LRECL = 61 PAD MISSOVER ;

* INPUT VARIABLES;
INPUT
	
	SEQN			1-6 	
	ELIGSTAT		15
	MORTSTAT		16
	UCOD_LEADING	$17-19
	DIABETES		20
	HYPERTEN		21
	PERMTH_INT		43-45	
	PERMTH_EXM		46-48	
     ;

* DEFINE VARIABLE LABELS;
LABEL
	SEQN			=	'NHANES Respondent Sequence Number'
	ELIGSTAT		=	'Eligibility Status for Mortality Follow-up'
	MORTSTAT		=	'Final Mortality Status'
	UCOD_LEADING	=	'Underlying Leading Cause of Death: Recode'
	DIABETES		=	'Diabetes Flag from Multiple Cause of Death (MCOD)'
	HYPERTEN		=	'Hypertension Flag from Multiple Cause of Death (MCOD)'
	PERMTH_INT		=	'Number of Person-Months of Follow-up from NHANES Interview date'
	PERMTH_EXM		=	'Number of Person-Months of Follow-up from NHANES Mobile Examination Center (MEC) Date'
;

   * ASSOCIATE VARIABLES WITH FORMAT VALUES;
FORMAT    
	ELIGSTAT 		ELIGFMT.          
	MORTSTAT 		MORTFMT.
	UCOD_LEADING	UCODFMT.
	DIABETES 		FLAGFMT.          
	HYPERTEN 		FLAGFMT. 
	PERMTH_INT PERMTH_EXM PREMISS.
;
RUN;


OPTIONS PAGENO=1;
TITLE1 "&SURVEY. PUBLIC-USE LINKED MORTALITY FILE";

*RUN PROC CONTENTS;
PROC CONTENTS DATA=&SURVEY. VARNUM; RUN;

*RUN FREQUENCIES;
PROC FREQ DATA=&SURVEY.;
TABLES 
	ELIGSTAT
	MORTSTAT 
	UCOD_LEADING 
	DIABETES
	HYPERTEN 
	PERMTH_INT	
	PERMTH_EXM	

	/ MISSING;
TITLE1 "&SURVEY. PUBLIC-USE LINKED MORTALITY FILE";
TITLE2 "UNWEIGHTED FREQUENCIES";

* USER NOTE: TO SEE UNFORMATTED VALUES IN THE FREQUENCY PROCEDURE, 
  UNCOMMENT THE STATEMENT "FORMAT _ALL_" BELOW ;
* FORMAT _ALL_;
RUN;
