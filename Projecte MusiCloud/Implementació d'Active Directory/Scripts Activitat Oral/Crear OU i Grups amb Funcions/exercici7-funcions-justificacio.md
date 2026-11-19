# Explicació de l'script Crear OU amb funcions

Abans d'escriure l'script, vaig identificar els requisits que havia de complir:
- El nom de l'OU és obligatori.
- La ruta és opcional, amb un valor per defecte DC=musiccloud,DC=local, perquè en la majoria de casos vull crear a l'arrel del domini.
- L'script ha d'estar organitzat amb funcions.
- Ha de funcionar sense errors encara que l'OU ja existeixi o la ruta no sigui vàlida.

**Definir els paràmetres**

Vaig separar els dos paràmetres segons si eren imprescindibles o no:
- `$nomOU` com a `[string[]]`  i no `[string]`, perquè així l'script accepta tant un sol nom com una llista de noms en una sola execució sense haver de fer l'script dues vegades.
Exemple: `-nomOU "Direccio"` o `-nomOU "Direccio","Administracio"`, 
- `$ruta` amb `Mandatory=$false` i un valor per defecte, per no obligar l'usuari a escriure sempre la mateixa ruta.

**Separar la lògica en dues funcions**

Vaig dividir el problema en dues preguntes diferents, cada una amb la seva funció:
- La ruta on vull crear existeix? → `Comprovar-Ruta`
- Com creo una OU de manera segura? → `Crear-OU`

Dividir-ho així fa que cada funció tingui una única responsabilitat i es pugui provar o reutilitzar per separat.

**`Comprovar-Ruta`: per què utilitzo `try/catch`**

`Get-ADObject -Identity` dona error si l'objecte no existeix, no retorna simplement `$null`. Per això cal el `try/catch` en comptes d'un `IF` normal. Dins del `try` intento obtenir l'objecte, si falla el `catch` ho recull i la funció retorna `$false` en lloc de deixar petar l'script.

**`Crear-OU`: per què comprovo abans de crear**

Si cridés directament `New-ADOrganizationalUnit` sense comprovar res, l'script fallaria cada cop que es tornés a executar sobre una OU que ja existeix. Per evitar-ho primer intento obtenir l'OU amb `Get-ADOrganizationalUnit`, si no la trobo llavors la creo amb `New-ADOrganizationalUnit`.

Això fa que l'script el pugui executar tantes vegades com vulgui sense que falli ni dupliqui res.

**El `foreach` dins de `Crear-OU`**

Com que `$nomOU` pot contenir diversos noms, feia falta repetir el mateix procés per a cadascun. Vaig posar el `foreach` dins la funció perquè és la pròpia funció qui sap què s'ha de fer amb cada nom individual.

**L'`if` final**

Abans de crear cap OU, l'script comprova que la ruta de destí existeix amb la funció `Comprovar-Ruta`. Si no existeix, no té sentit ni intentar-ho directament `exit`. Així evito errors en cadena de `New-ADOrganizationalUnit` quan el problema real és que la ruta és incorrecta.