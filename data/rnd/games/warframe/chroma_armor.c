#include <stdio.h>

int main() {
    double baseArmor = 450;
    double baseScorn = 350/100;
    double eleWard = 145/100;
    double armorMod = 180/100;
    double strenghtMod = (99 + 77 + 55 + 69)/100;
    double calc = baseArmor * (1 + armorMod + baseScorn * (1 + strenghtMod));
    double dmgReduc = (calc)/(calc + 300);

    printf("strenght: %f\ncalculation: %f\ndmgReduc: %f", strenghtMod, calc, dmgReduc );
    
    return 0;
}
