/* 
* TODO: 1. Place the .txt data file and the dictionary file you downloaded in the work folder, or enter the full path to these files!
*       2. You may have to increase memory using the 'set mem' statement. It is commented out in the code bellow.
*
* If you have any questions or need assistance contact info@socialexplorer.com.
*/

///set mem 512m
capture log close
set more off
clear
infile using "R12432906.dct", using("F:\SOC5670\Labs\data\lab01\R12432906_SL140.txt")
log using analysis.log, replace

*Sex Ratio
gen sr=A02001_002/A02001_003

*Dependency Ratio
gen depc=A01001_002+A01001_003+A01001_004
gen age=A01001_005+A01001_006+A01001_007+A01001_008+A01001_009+A01001_010
gen deps=A01001_011+A01001_012+A01001_013  
gen check=(depc+age+deps)-A01001_001

gen dp=(depc+deps)/age

*Child Dependency Ratio
gen cdp=depc/age

*Senior Dependency Ratio
gen sdp=deps/age

*Ageing Index
gen ai=deps/depc

*Racial Diversity Score
** Step One - Calulate Percents for each racial group
gen oth=A04001_005+A04001_007+A04001_008+A04001_009
gen pwht=A04001_003/A04001_001
gen pblk=A04001_004/A04001_001
gen pasn=A04001_006/A04001_001
gen phis=A04001_010/A04001_001
gen poth=oth/A04001_001
gen ptot=pwht+pblk+pasn+phis+poth

**Step Two - Calculate Scores for each racial grup
gen ewht=pwht*ln(pwht)
gen eblk=pblk*ln(pblk)
gen easn=pasn*ln(pasn)
gen ehis=phis*ln(phis)
gen eoth=poth*ln(poth)

**Step Three - Write code to convert missing to zero
recode ewht(mis = 0)
recode eblk(mis = 0)
recode easn(mis = 0)
recode ehis(mis = 0)
recode eoth(mis = 0)

**Calculate Entropy
gen e=abs(ewht+eblk+easn+ehis+eoth)/ln(5)

*Recode some variables
gen wht=A04001_003
gen blk=A04001_004
gen asn=A04001_006
gen lat=A04001_010
gen tot=A04001_001

mean check ptot

*Export to an excel file to merge with shapefile
export excel FIPS dp cdp sdp ai e wht blk lat oth tot pwht pblk using "F:\SOC5670\Labs\data\lab01\part01.xls", firstrow(variables) nolabel replace, 

*Create a new Stata datbase
save "F:\SOC5670\Labs\data\lab01\stl_part01.dta", replace

log close

exit

