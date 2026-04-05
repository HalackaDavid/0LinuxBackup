b_ar=0
r_ar=5

for i in range(6):
    strg=100+77+99+55+(r_ar*15)
    ward=55*strg/100
    hp_formula=1036+(370*ward/100)+(255*b_ar)
    scorn=350*strg/100
    fury=275*strg/100
    vexh=1*5*strg/100/100
    print(f"HP:    {hp_formula}\nStrg:  {strg}\nScorn: {scorn}\nFury:  {fury}\nVexH:  {vexh}\n")
    
    b_ar+=1
    r_ar-=1
