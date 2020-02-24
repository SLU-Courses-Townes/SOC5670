/* 
* TODO: 1. Place the .txt data file and the dictionary file you downloaded in the work folder, or enter the full path to these files!
*       2. You may have to increase memory using the 'set mem' statement. It is commented out in the code bellow.
*
* If you have any questions or need assistance contact info@socialexplorer.com.
*/

///set mem 512m
set more off
clear
infile using "R12438420.dct", using("F:\SOC5670\Assignments\Homework01\data\data02\part02\R12438420_SL140.txt")


*compute midpoint values for each income category  aka as Yi.
gen  mp01=5000
gen  mp02=12499
gen  mp03=17499
gen  mp04=22499
gen  mp05=27499
gen  mp06=32499
gen  mp07=37499
gen  mp08=42499
gen  mp09=47499
gen  mp10=54499
gen  mp11=67499
gen  mp12=87499
gen  mp13=112499
gen  mp14=137499
gen  mp15=174999
gen  mp16=325000

*Compute total income in each category. This will allow us to calculate average income.
gen I01=A14001_002*mp01
gen I02=A14001_003*mp02
gen I03=A14001_004*mp03
gen I04=A14001_005*mp04
gen I05=A14001_006*mp05
gen I06=A14001_007*mp06
gen I07=A14001_008*mp07
gen I08=A14001_009*mp08
gen I09=A14001_010*mp09
gen I10=A14001_011*mp10
gen I11=A14001_012*mp11
gen I12=A14001_013*mp12
gen I13=A14001_014*mp13
gen I14=A14001_015*mp14
gen I15=A14001_016*mp15
gen I16=A14001_017*mp16
gen INC=(I01+I02+I03+I04+I05+I06+I07+I08+I09+I10+I11+I12+I13+I14+I15+I16)
gen AVEINC=INC/A14001_001

*Compute Part 1 of the formula - Proportion Breakdown within Neighborhood for Income Groups.
gen P01=A14001_002/A14001_001
gen P02=A14001_003/A14001_001
gen P03=A14001_004/A14001_001
gen P04=A14001_005/A14001_001
gen P05=A14001_006/A14001_001
gen P06=A14001_007/A14001_001
gen P07=A14001_008/A14001_001
gen P08=A14001_009/A14001_001
gen P09=A14001_010/A14001_001
gen P10=A14001_011/A14001_001
gen P11=A14001_012/A14001_001
gen P12=A14001_013/A14001_001
gen P13=A14001_014/A14001_001
gen P14=A14001_015/A14001_001
gen P15=A14001_016/A14001_001
gen P16=A14001_017/A14001_001
gen PTOT=(P01+P02+P03+P04+P05+P06+P07+P08+P09+P10+P11+P12+P13+P14+P15+P16)

*Compute Part 2 of the formula Yi/m m=average income.
gen T101=mp01/AVEINC
gen T102=mp02/AVEINC
gen T103=mp03/AVEINC
gen T104=mp04/AVEINC
gen T105=mp05/AVEINC
gen T106=mp06/AVEINC
gen T107=mp07/AVEINC
gen T108=mp08/AVEINC
gen T109=mp09/AVEINC
gen T110=mp10/AVEINC
gen T111=mp11/AVEINC
gen T112=mp12/AVEINC
gen T113=mp13/AVEINC
gen T114=mp14/AVEINC
gen T115=mp15/AVEINC
gen T116=mp16/AVEINC

*Compute Part 3 of the formula ln(Yi/m) m=average income.
gen T201=ln(T101)
gen T202=ln(T102)
gen T203=ln(T103)
gen T204=ln(T104)
gen T205=ln(T105)
gen T206=ln(T106)
gen T207=ln(T107)
gen T208=ln(T108)
gen T209=ln(T109)
gen T210=ln(T110)
gen T211=ln(T111)
gen T212=ln(T112)
gen T213=ln(T113)
gen T214=ln(T114)
gen T215=ln(T115)
gen T216=ln(T116)

*Compute Part 4 of the formula Part01*Part02*Part03.
gen T301=P01*T101*T201
gen T302=P02*T102*T202
gen T303=P03*T103*T203
gen T304=P04*T104*T204
gen T305=P05*T105*T205
gen T306=P06*T106*T206
gen T307=P07*T107*T207
gen T308=P08*T108*T208
gen T309=P09*T109*T209
gen T310=P10*T110*T210
gen T311=P11*T111*T211
gen T312=P12*T112*T212
gen T313=P13*T113*T213
gen T314=P14*T114*T214
gen T315=P15*T115*T215
gen T316=P16*T116*T216

*Create your income inequality score
gen theil=(T301+T302+T303+T304+T305+T306+T307+T308+T309+T310+T311+T312+T313+T314+T315+T316)

*EDUCATION ATTAINMENT.
gen E02=A12001_002/A12001_001
gen E03=A12001_003/A12001_001
gen E04=A12001_004/A12001_001
gen E05=A12001_005/A12001_001
gen E06=A12001_006/A12001_001
gen E07=A12001_007/A12001_001
gen E08=A12001_008/A12001_001


gen ed_hs=(E03+E04+E05+E06+E07+E08)
gen ed_bs=(E05+E06+E07+E08)
gen ed_gd=(E06+E07+E08)
gen edtot=ed_hs+ed_bs+ed_gd

*percent poverty=living in poverty/Population for Whom Poverty Status Is Determined
gen pov=(A13004_002+A13004_003+A13004_004)/(A13004_001)

*percent no health insurance=o Health Insurance Coverage/Total
gen nhi=A20001_002/A20001_001

gen mhi=A14006_001
gen gini=A14028_001

export excel FIPS theil edtot pov nhi mhi  using "F:\SOC5670\Assignments\Homework01\data\data02\part02\part02.xls", firstrow(variables) nolabel replace, 

save "F:\SOC5670\Assignments\Homework01\data\data02\part02\hw01_part02.dta", replace

exit
