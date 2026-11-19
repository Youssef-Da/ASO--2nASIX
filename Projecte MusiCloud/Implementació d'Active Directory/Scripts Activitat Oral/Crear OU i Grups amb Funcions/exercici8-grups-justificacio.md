# Explicació de l'script crear Grups amb funcions

Vaig començar de la mateixa idea que l'script d'OU, paràmetres per `nomGrup` i `ruta` amb valor per defecte. Però els grups a Active Directory necessiten dues dades que les OU no tenen: l'scope i la categoria, obligatòries per `New-ADGroup`. Per això vaig afegir `$scope` i `$categoria` com a paràmetres opcionals amb els valors  per defecte `Global` i `Security`, seguint el mateix criteri que `$ruta`

**Primera versió**

La primera versió que vaig fer passava `$ruta`, `$scope` i `$categoria` com a paràmetres de la funció `Crear-Grup`, igual que havia fet amb `Comprovar-Ruta` a l'script d'OU. Això volia dir que cada variable estava definida dues vegades, un cop a dalt, al `param` de l'script, i un altre cop com a paràmetre de la funció que l'havia de rebre per poder-la fer servir. Em vaig adonar que això era innecessari, com que les funcions estan dins del mateix script, poden llegir directament les variables de `$ruta`, `$scope` i `$categoria` del scope exterior sense que calgui passar-les literalment. Vaig simplificar totes dues funcions perquè no rebin cap d'aquests tres paràmetres.

**Treure el bucle de dins la funció**

A la primera versió també tenia el `foreach` dins de `Crear-Grup`, rebent tot l'array `$nomGrup` de cop. Vaig veure que això no quedava bé, si la funció ja s'anomena Crear-Grup, hauria de crear un únic grup. Vaig canviar-ho perquè `Crear-Grup` rep un sol `[string]$nom` i crea només aquell grup. El `foreach` passa a estar fora de totes les funcions, al final de l'script, i és qui decideix quantes vegades es crida `Crear-Grup`.

Amb això cada funció es queda amb el mínim de paràmetres possible.

**`Comprovar-Ruta` sense paràmetres**

Pel mateix motiu del punt 2, vaig treure el paràmetre `$ruta` de `Comprovar-Ruta`, la funció llegeix directament la variable `$ruta` de l'script, no cal que l'hi passi jo.

**`Crear-Grup`, `try/catch` i `ErrorAction SilentlyContinue`**

Igual que amb les OU, `Get-ADGroup -Identity` llança una excepció si el grup no existeix, així que era necessari el `try/catch`. Si el `try` falla, el `catch` l'intenta crear amb `New-ADGroup`. Vaig posar `-ErrorAction SilentlyContinue` a `New-ADGroup` perquè, si tot i així la creació falla per algun altre motiu per exemple un nom invàlid, l'script continuï amb la resta de grups de la llista en lloc d'aturar-se.

**L'`if` final igual que a l'script d'OU**

Es manté la mateixa lògica, si la ruta de destí no existeix, no té sentit ni intentar crear cap grup, així que `exit` directament abans d'entrar al `foreach`.