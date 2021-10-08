log using log_day1, replace

cd "C:\Users\where\files\are\located"

clear
import delimited mroz 
sum

rename hourstotalin1975 hours
drop if wage == .
gen fulltime = hours>40*52

regress wage educ
predict fitted
scatter wage educ || line fitted educ

hist wage

gen lwage = log(wage)


reg lwage educ exper
eststo clear
eststo m1: quietly reg lwage educ
eststo m2: quietly reg lwage educ exper

esttab
esttab m1 m2 using RegResults.rtf, label nonumber title("Education Effects on Wage") mtitle("Model 1" "Model 2") replace


clear
input famid str4 name inc
2 "Art" 22000
1 "Bill" 30000
3 "Paul" 25000
end
save dads, replace
list 



clear
input famid str4 name inc
1 "Bess" 15000
3 "Pat" 50000
2 "Amy" 18000
end
save moms, replace
list 

clear
use dads
append using moms 
list 


clear
use dads
rename name DadName
rename inc DadInc
merge 1:1 famid using moms 
list 


log close
translate log_day1.smcl log_day1.pdf
