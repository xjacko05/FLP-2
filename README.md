# FLP 2022/2023 - logický projekt: Prolog

## Popis projektu

Program napísaný v jazyku Prolog implementujúci hľadanie Hamiltonovských kružníc v grafe. Pri implementácií bol využitý SWI-Prolog verzia 9.0.4 (pri použití s verziou 6.6.1 (server merlin) funkčnosť nezmenená).

## Popis implementácie

Program implementuje plnú funkcionalitu podľa zadania, formát vstupov je taktiež v súlade so zadaním (program očakáva oddelenie riadkov pomocou znaku LF). Formát výstupov je taktiež podľa zadania (poradie hrán a poradie vrcholov v rámci hrán zodpovedá výslednej ceste, nie vstupu).

Program v rámci spracovania vstupu pridá do knowledge base jednotlivé hrany a unikátne vrcholy. Hľadanie kružníc funguje na princípe otestovania všetkých možných ciest, ktoré prechádzajú všetkými vrcholmi v rámci daného grafu. Možné kružnice sú generované ako permutácie zoznamu vrcholov. Generované permutácie sú fitrované na duplicitu z hľadiska offsetu ("rotáciou zoznamu by vznikol iný, už navštívený zoznam) a reverzu (zoznam je reverzný voči inému = rovnaká cesta, len iným smerom). Po vygenerovaní je daná kružnica otestovaná, či je na základe vstupných dát podľa nej grafom prejsť.

## Testovanie

Pre testovanie funkčnosti implementácie bolo vytvorených 7 testov.

1. Načíta krivku a vypíše ju naspäť na stdout
2. Pre danú krivku vygeneruje nový KeyPair
3. Vytvorí podpis pomocou vygenerovaného kľúča
4. Overí podpis so správnym kľúčom
5. Overí podpis s nesprávnym kľúčom
6. Overí poskytnutý podpis pomocou poskytnutého kľuča (rovnaké ako v zadaní)
7. Overí nesprávny podpis pomocou poskytnutého kľuča (rovnaké ako v zadaní)

Pre prípad záujmu sú vstupy a výstupy testov zachované až do vykonania ```make clean```.

## Použitie

Preklad:
```bash
make
```

Binárny súbor `flp22-log` je následne možné spustiť:
```bash
flp22-log <[input-file]
```

Spustenie testov:
```bash
make test
```

Pre upratanie po preklade a spustení testov:
```bash
make clean
```