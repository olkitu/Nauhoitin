Nauhoitin
=========

Nauhoitin skriptin avulla voi kätevästi nauhoittaa televisiosta tulevia
ohjelmia.

Kanavien IP-osoitteet toimivat ainakin itselläni ;), pääkaupunkiseudun Sonera
Viihde -taloudessa. Skripti voi toimia myös esim Elisan verkossa.
Mikäli kanavat/IP-osoitteet ovat eri, niin ne pitää tietysti vaihtaa.

Vaatii toimiakseen
------------------

* cvlc  (vlc)
* bash

* Sonera Viihde sekä nettipiuha koneeseen (ei toimi perus boxilla langattomana)

Käyttö
------
```
./nauhoita.sh -c tv1 -t '2014-12-24 12:00' -d 0:30 -f julistus.ts
```

* Nauhoitettava kanava YLE TV 1
* Ajankohta 24. joulukuuta 2014 kello 12:00
* Nauhtoituksen kesto 30 minuuttia
* Tallennetaan tiedostoon julistus.ts

Lisenssi
--------

GNU General Public License v3

Vapaasti muokkaamaan ja kehittämään ;)

Tekijä
------
* Juho Vähäkangas < vahakangas at gmail com >
