# Combinatorics Cheat Sheet

## 🔁 Permutace (všechny prvky)
### Bez opakování
```
P(n) = n!
```
### S opakováním
```
P(n; n1, n2, ...) = n! / (n1! * n2! * ...)
```
### Cyklické (do kruhu)
```
Pc(n) = (n-1)!
```

---

## 🔀 Variace (pořadí záleží, část prvků)
### Bez opakování
```
V(n,k) = n! / (n-k)!
```
### S opakováním
```
V'(n,k) = n^k
```

---

## 🎯 Kombinace (pořadí nezáleží)
### Bez opakování
```
C(n,k) = n! / (k! * (n-k)!)
```
### S opakováním
```
C'(n,k) -> C(n+k-1,k) = n! / (k! * (n-k)!)
```

---

## 🔥 Rozhodovák
```
všechny prvky → permutace
část prvků:
    zálež na pořadí → variace
    nezálež na pořadí → kombinace
```

---
```
## 🧠 1 věta na vše
- pořadí → variace
- bez pořadí → kombinace
- všechno → permutace

