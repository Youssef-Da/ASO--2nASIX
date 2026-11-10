# Grups


Nota: en un grup es pot guardar usuaris, equips i grups
## Dos tipus
Seguretat:
    - Organitzar
    - Agrupar
Distribució:
    - Llistes de Distribució
    - Correu (Microsoft echange)


 No farem servir els de distribució
## Ambits (grups de seguretat)
Local domain - Per assignar permisos
    - Permeten objectes d'altres dominis
Global domain - Estructurals (per exemple un grup per un departament)
    - 1 limitació (nomes permet objectes del propi domini)
Universal domain - Es fara servir el minim possible i no es fara servir per assignar permisos. Per exemple un grup que afecta a tots els dominis com hara els informatics de tots els dominis.
Nota: Pots afegir un grup global dins un grup local


## Nom dels grups


Han de erespondre al ambit i a la funcionalitat
    - Ambit (GL, GG, GU)
    - Funció (GG_Informatica, GG_Usuaris.Informàtica, GG_Equips.Informàtica)


## Comanda
powershell
new-adgroup -name nom #nom del grup
            -samaccountname nom #nom identificatiu
            -path #on es guardara el grup 
            -groupscope [global|local|universal] #tipus de grup


get-adgroup #igual que amb les uo