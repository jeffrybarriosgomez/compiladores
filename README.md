**Autómatas y lenguajes formales**

Jeffry Jose Barrios Gomez 

Juan Jose Medina Benitez

Ian Steve Miranda Angulo

Angel David Rodriguez Botello


**ALCANCES:**

la siguiente gramática está pensada para reconocer DCL REVOKE, utilizando la sintaxis del IBM DB2 V10 y así limitar los accesos a tablas o vistas de una base de datos.

**LIMITACIONES:**

Dentro de la limitación podemos encontrar las siguientes:

1. Los privilegios que puede revocar son los siguientes (**SELECT, INSERT, DELETE, UPDATE, ALL**) puede ser uno o más privilegios 
1. Las palabras reservadas deberán estar escritas en mayúsculas
1. Se puede revocar (**USER, ROLE, GRUOP**) a usuarios para tablas especificas

**SUPOSICIONES:**

Algunos ejemplos de las sentencias testeadas, se pueden analizar una o mas sentencias se encuentran dentro del archivo test.txt

**ENTORNO**

Este analizador esta desarrollado utilizando los paquetes Jflex y Jcup para en análisis semántico y sintáctico en lenguaje Java version 17 open java con el IDE de desarrollo Netbean 19

**GRAMATRICA**
````
<<INICIO>> --> <<SC>>
<<SC>>---> revoke <<LP> on <<TABLE>> from <<US>> ; <<MR>
<<LP>>------> <<PV>> <<MP>>
<<MP>>------> λ | , <<PV>> <<MP>>
<<PV>>------> select | insert | update | delete | all 
<<TABLE>>---> Id | nombre . Id
<<RG>>------> user | group | role 
<<US>>------> Id | <<RG>> Id <<MU>>
<<MU>>------> λ | , <<RG>> Id <<MU>>
<<MR>>------> λ | <<SC>>
````
**FIRST**
````
first(INICIO)    = first(SC)
first(SC)       = first(revoke)
first(LP)       = first(PV)
first(PV)       = {select, insert, update, delete, all}
first(MP)       = λ U first(,)
first(TABLE)       = first(Id) U first(nombre)
first(RG)       = {user, group, role}
first(US)       = first(Id) U first(RG)
first(MU)       = λ U first(,)
first(MR)       = λ U first(SC)

first(INICIO) = first(SC) = {revoke}
first(LP) = first(PV) = {select, insert, update, delete, all}
first(MP)   = {λ , <,>}
first(TABLE)    = {Id , nombre}
first(RG)   = {user, group, role}
first(US)   = {Id, user, group, role}
first(MU) = {λ , <,>}
first(MR) = {λ , revoke}
````
**FOLLOW**
````
follow(INICIO) = {$}
follow(SC) = {revoke, $}
follow(LP)  ={on}
follow(MP) = {on}
follow(PV)  ={, <,> on}
follow(TABLE)  ={from}
follow(RG)   ={Id}
follow(US)  ={;}
follow(MU) = {;}
follow(MR) = {revoke, $}
````
