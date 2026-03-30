# Combinatorics Cheat Sheet

## 🔢 Faktoriál
```
n! = n * (n-1) * ... * 1
```

---

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
C'(n,k) = C(n+k-1,k)
```

---

## 🔥 Rozhodovák
```
bereš všechny? → permutace
bereš část:
    záleží na pořadí?
        ano → variace
        ne  → kombinace
    kombinace typ:
        objekty různé, bez opakování → C(n,k)
        objekty stejné, rozdělení do skupin → C(n+k-1,k)
opakování?
    ano → "s opakováním"
    ne  → "bez opakování"
```

---

## ⚡ Bonus triky
```
C(n,k) = C(n,n-k)
C(n+k-1,k) → hvězdičky a čárky
```

---

## 🧠 1 věta na vše
- pořadí → variace
- bez pořadí → kombinace
- všechno → permutace

