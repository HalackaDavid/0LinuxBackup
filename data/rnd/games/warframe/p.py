HP=851+5*225+(370*0.2)
strg=309
guardian_armor=HP*5*strg/100/100/3
nourishE=1+0.6*strg/100
Edrain=3
#print((guardian_armor*0.45*nourishE))
print((500-guardian_armor)-(guardian_armor*0.45*nourishE*Edrain))
