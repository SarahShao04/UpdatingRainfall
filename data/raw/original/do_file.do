tsset ccode year

*generate country fixed effects*
tab ccode, gen(Iccode)

*generate country time trend*
local i=1
while (`i'< 41){
quietly gen Iccyear`i' = Iccode`i'*year
label variable Iccyear`i' "Country-Specific Time Trend for Iccode`i'"
local i = `i' + 1
}

*generate time fixed effects*
tab year, gen(time)


*Table III: Rainfall and Polity Change*

ivreg2 polity_change lgpcp_l lgpcp_l2 Iccode* Iccyear* time*  ,  cluster(ccode) partial(Iccode* Iccyear* time*) 
ivreg2 polity_change lgpcp_l lgpcp_l2 Iccode* Iccyear* time* if polity!=-77 & polity_l!=-77  , cluster(ccode) partial(Iccode* Iccyear* time*)
ivreg2 exconst_change lgpcp_l lgpcp_l2  Iccode* Iccyear* time*  , cluster(ccode) partial(Iccode* Iccyear* time*)
ivreg2 polcomp_change  lgpcp_l lgpcp_l2  Iccode* Iccyear* time* , cluster(ccode) partial(Iccode* Iccyear* time*)
ivreg2 exrec_change  lgpcp_l lgpcp_l2 Iccode* Iccyear* time* , cluster(ccode) partial(Iccode* Iccyear* time*)


*Table IV: Rainfall, Per Capita GDP, and Country Specific Recessions*

ivreg2 lgdp_l2 lgpcp_l2 Iccode* time* Iccyear* if polity_change!=., cluster(ccode) partial(Iccode* Iccyear* time*)
ivreg2 lgdp_l2 lgpcp_l2 lgpcp_l3 Iccode* time* Iccyear* if polity_change!=. , cluster(ccode) partial(Iccode* Iccyear* time*)
ivreg2 lgdp_l2 lgpcp_l2 lgpcp_l3 lgpcp_l4 Iccode* time* Iccyear* if polity_change!=. , cluster(ccode) partial(Iccode* Iccyear* time*)
ivreg2 lgdp_l2 lgpcp_l2 lgpcp_l2_polity2l2 polity2l2 Iccode* time* Iccyear* if polity_change!=. , cluster(ccode) partial(Iccode* Iccyear* time*)

ivreg2 recession_l2 lgpcp_l2 Iccode* time* Iccyear* if polity_change!=.,cluster(ccode) partial(Iccode* Iccyear* time*)
ivreg2 recession_l2 lgpcp_l2 lgpcp_l3 Iccode* time* Iccyear* if polity_change!=. , cluster(ccode) partial(Iccode* Iccyear* time*)
ivreg2 recession_l2 lgpcp_l2 lgpcp_l3 lgpcp_l4 Iccode* time* Iccyear* if polity_change!=. , cluster(ccode) partial(Iccode* Iccyear* time*)
ivreg2 recession_l2 lgpcp_l2 lgpcp_l2_polity2l2 polity2l2  Iccode* time* Iccyear* if polity_change!=. , cluster(ccode) partial(Iccode* Iccyear* time*)

*Table V: Income Shocks and Polity change*

ivreg2 polity_change Iccode* Iccyear* time* ( lgdp_l2 =  lgpcp_l2 ), cluster(ccode) partial(Iccode* Iccyear* time*) ffirst
ivreg2 polity_change Iccode* Iccyear* time* ( lgdp_l2 =  lgpcp_l2 ) if polity!=-77 & polity_l!=-77 , partial(Iccode* Iccyear* time*) ffirst  cluster(ccode)
ivreg2 polity_change  lgdp_l2 Iccode* Iccyear* time*,  cluster(ccode) partial(Iccode* Iccyear* time*) 
ivreg2 exconst_change Iccode* Iccyear* time* (lgdp_l2 =  lgpcp_l2 ) , cluster(ccode) partial(Iccode* Iccyear* time*) ffirst
ivreg2 polcomp_change Iccode* Iccyear* time* ( lgdp_l2 =  lgpcp_l2 ) , cluster(ccode) partial(Iccode* Iccyear* time*) ffirst
ivreg2 exrec_change Iccode* Iccyear* time* ( lgdp_l2 =  lgpcp_l2 ) , cluster(ccode) partial(Iccode* Iccyear* time*) ffirst


*Table VI: Country Specific Recessions and Polity Change*

ivreg2 polity_change Iccode* Iccyear* time* ( recession_l2 =  lgpcp_l2 ), cluster(ccode) partial(Iccode* Iccyear* time*) 
ivreg2 polity_change Iccode* Iccyear* time* ( recession_l2 =  lgpcp_l2 ) if polity!=-77 & polity_l!=-77  ,cluster(ccode) partial(Iccode* Iccyear* time*) 
ivreg2 polity_change  recession_l2 Iccode* Iccyear* time*,  cluster(ccode) partial(Iccode* Iccyear* time*)
ivreg2 exconst_change Iccode* Iccyear* time* (recession_l2 =  lgpcp_l2 ) , cluster(ccode) partial(Iccode* Iccyear* time*) 
ivreg2 polcomp_change Iccode* Iccyear* time* ( recession_l2 =  lgpcp_l2 ) , cluster(ccode) partial(Iccode* Iccyear* time*) 
ivreg2 exrec_change Iccode* Iccyear* time* ( recession_l2 =  lgpcp_l2 ) , cluster(ccode) partial(Iccode* Iccyear* time*) 


*Table VI: Democratic Convergence

ivreg2 polity_change polity2l lgpcp_l lgpcp_l2 Iccode* Iccyear* time*, cluster(ccode) partial(Iccode* Iccyear* time*) 
xtabond2 polity_change polity2l lgpcp_l lgpcp_l2 Iccode* Iccyear* time*, gmm(polity2l) robust iv( lgpcp_l lgpcp_l2 Iccode* Iccyear* time*)
ivreg2 polity_change polity2l Iccode* Iccyear* time* ( lgdp_l2 =  lgpcp_l2 ),  cluster(ccode) partial(Iccode* Iccyear* time*) ffirst
ivreg2 polity_change polity2l Iccode* Iccyear* time* ( recession_l2 =  lgpcp_l2 ), cluster(ccode) partial(Iccode* Iccyear* time*) ffirst

ivreg2 polity_change polity2l polity2l2 lgpcp_l lgpcp_l2 Iccode* Iccyear* time*, cluster(ccode) partial(Iccode* Iccyear* time*) 
xtabond2 polity_change polity2l polity2l2  lgpcp_l lgpcp_l2 Iccode* Iccyear* time*, gmm(polity2l polity2l2 ) robust iv(lgpcp_l lgpcp_l2 Iccode* Iccyear* time*)
ivreg2 polity_change polity2l polity2l2  Iccode* Iccyear* time* ( lgdp_l2 =  lgpcp_l2 ),  cluster(ccode) partial(Iccode* Iccyear* time*) ffirst
ivreg2 polity_change polity2l polity2l2  Iccode* Iccyear* time* ( recession_l2 =  lgpcp_l2 ), cluster(ccode) partial(Iccode* Iccyear* time*) ffirst


*Table VIII: Rainfall and Polity Transitions *
ivreg2 trans_democ  lgpcp_l lgpcp_l2 Iccode* Iccyear* time* , cluster(ccode) partial(Iccode* Iccyear* time*) 
ivreg2 trans_democ_epst lgpcp_l lgpcp_l2 Iccode* Iccyear* time* , cluster(ccode) partial(Iccode* Iccyear* time*) 
ivreg2 trans_autoc lgpcp_l lgpcp_l2 Iccode* Iccyear* time*,  cluster(ccode) partial(Iccode* Iccyear* time*) 
ivreg2 coup  lgpcp_l lgpcp_l2 Iccode* Iccyear* time* if trans_autoc!=.,cluster(ccode) partial(Iccode* Iccyear* time*) 

*Table IX: Income Shocks and Transitions to Democracy*

ivreg2 trans_democ lgdp_l2 Iccode* Iccyear* time*, cluster(ccode) partial(Iccode* Iccyear* time*) 
ivreg2 trans_democ Iccode* Iccyear* time* (lgdp_l2 =lgpcp_l2), cluster(ccode) partial(Iccode* Iccyear* time*) ffirst
ivreg2 trans_democ Iccode* Iccyear* time* (recession_l2 =  lgpcp_l2), cluster(ccode) partial(Iccode* Iccyear* time*) ffirst
ivreg2 trans_democ_epst lgdp_l2 Iccode* Iccyear* time*, cluster(ccode) partial(Iccode* Iccyear* time*) 
ivreg2 trans_democ_epst Iccode* Iccyear* time* (lgdp_l2 =lgpcp_l2), cluster(ccode) partial(Iccode* Iccyear* time*) ffirst
ivreg2 trans_democ_epst Iccode* Iccyear* time* (recession_l2 =  lgpcp_l2), cluster(ccode) partial(Iccode* Iccyear* time*) ffirst

*Table X. Rain, Agriculture, GDP, and Democratic Change*
sum agri_gdp_av, detail
ivreg2 lgdp_l2 lgpcp_l2 lgpcp_l3 Iccode* Iccyear* time* if agri_gdp_av<34.7 &polity_change!=.  , cluster(ccode) partial(Iccode* Iccyear* time*) 
ivreg2 polity_change lgpcp_l lgpcp_l2 Iccode* Iccyear* time* if agri_gdp_av<34.7 ,cluster(ccode) partial(Iccode* Iccyear* time*)
ivreg2 polity_change lgpcp_l lgpcp_l2 Iccode* Iccyear* time* if agri_gdp_av<34.7 &exconst_ch!=., cluster(ccode) partial(Iccode* Iccyear* time*)
ivreg2 trans_democ lgpcp_l lgpcp_l2 Iccode* Iccyear* time* if agri_gdp_av<34.7 ,cluster(ccode) partial(Iccode* Iccyear* time*)
ivreg2 trans_democ_epst lgpcp_l lgpcp_l2 Iccode* Iccyear* time* if agri_gdp_av<34.7 ,cluster(ccode) partial(Iccode* Iccyear* time*)

ivreg2 lgdp_l2 lgpcp_l2 lgpcp_l3 Iccode* Iccyear* time* if agri_gdp_av>34.7 &polity_change!=. , cluster(ccode) partial(Iccode* Iccyear* time*)
ivreg2 polity_change lgpcp_l lgpcp_l2 Iccode* Iccyear* time* if agri_gdp_av>34.7 ,cluster(ccode) partial(Iccode* Iccyear* time*)
ivreg2 polity_change lgpcp_l lgpcp_l2 Iccode* Iccyear* time* if agri_gdp_av>34.7 &exconst_ch!=., cluster(ccode) partial(Iccode* Iccyear* time*)
ivreg2 trans_democ lgpcp_l lgpcp_l2 Iccode* Iccyear* time* if agri_gdp_av>34.7 ,cluster(ccode) partial(Iccode* Iccyear* time*)
ivreg2 trans_democ_epst lgpcp_l lgpcp_l2 Iccode* Iccyear* time* if agri_gdp_av>34.7 ,cluster(ccode) partial(Iccode* Iccyear* time*)

