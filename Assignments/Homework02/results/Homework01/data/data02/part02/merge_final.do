clear
set more off

use "F:\SOC5670\Assignments\Homework01\data\data02\part02\gis\geo_sprfd.dta" 

sort FIPS

save "F:\SOC5670\Assignments\Homework01\data\data02\part02\gis\geo_sprfd01.dta", replace

use "F:\SOC5670\Assignments\Homework01\data\data02\part02\hw01_part02.dta" 

sort FIPS

merge 1:1 FIPS using "F:\SOC5670\Assignments\Homework01\data\data02\part02\gis\geo_sprfd01.dta"

keep if indicatorK==1

*keep if tot17>15

*Data Normalization =x-MIN/MAX/MIN replace min and max values.

*gen ed_sc15(ED_TOT-min)/(max-min)
*gen mhi_sc15=(log(mhi15)-log(min))/(log(max)-log(min))
*Income Inequality Scale - High values are bad and low values are good
*gen inc_sc15=(theil15-min)/(max-min)
*Recode income Inequality Scale - High values are good and low values are bad
*gen rinc_sc15=1-inc_sc15
*gen index01=(ed_sc15+rinc_sc15+mhi_sc15)/3


summarize theil edtot mhi




*    Variable |        Obs        Mean    Std. Dev.       Min        Max
*-------------+---------------------------------------------------------
*       theil |         91    .3055228    .0842762   .1846180   .6913345
*       edtot |         91    1.257332    .2306614   .8183042   1.888767
*         mhi |         91    47143.13    17056.52       7373     105217






*Education Scale - High values are good and low values are bad
gen ed_sc=(edtot-.5843374)/(2.449892-.5843374)

*Income Inequality Scale - High values are bad and low values are good
gen inc_sc=(theil-.128396)/(.6564058-.128396)

*Recode income Inequality Scale - High values are good and low values are bad
gen rinc_sc1=1-inc_sc

*Median Income - High is good and low is bad
gen mhi_sc=(log(mhi)-log(11769))/(log(209096)-log(11769))
 

*High is good and low is bad - all variables are equal
gen index01=(ed_sc+rinc_sc+mhi_sc)/3

*High is good and low is bad - education is 50%, inequality is 25% and income is 25%
gen index02=(ed_sc*.5)+(rinc_sc*.25)+(mhi_sc*.25)

export excel FIPS index01 index02  using "F:\SOC5670\Assignments\Homework01\data\data02\part02\final.xls", firstrow(variables) nolabel replace, 

save "F:\SOC5670\Assignments\Homework01\data\data02\part02\mas_sprfd.dta", replace
