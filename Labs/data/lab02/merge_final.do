clear
set more off

use "F:\SOC5670\Labs\data\gis\geo_stl.dta" 

sort FIPS

save "F:\SOC5670\Labs\data\gis\geo_stl01.dta", replace

use "F:\SOC5670\Labs\data\lab02\stl_part02.dta" 

sort FIPS

merge 1:1 FIPS using "F:\SOC5670\Labs\data\gis\geo_stl01.dta"

keep if keep==1

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
*       theil |        614    .3002117    .0847341   .1283958   .6564058
*       edtot |        614    1.353836    .3409433   .5843374   2.449892
*         mhi |        614    63109.49     28748.2      11769     209096






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

export excel FIPS index01 index02  using "F:\SOC5670\Labs\data\lab02\final.xls", firstrow(variables) nolabel replace, 

save "F:\SOC5670\Labs\data\lab02\mas_stl.dta", replace
