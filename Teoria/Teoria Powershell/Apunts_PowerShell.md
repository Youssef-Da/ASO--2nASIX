# Apunts de PowerShell

Apunts elaborats a partir de les pràctiques de fitxers i carpetes, variables, tipus de dades, arrays, pipeline, Select-Object i Where-Object.

> A PowerShell, les ordres solen tenir la forma Verb + Nom, les variables comencen amb `$` i el pipeline `|` envia els resultats d'una ordre a la següent.

## Índex

1. [Investigar ordres i consultar l'ajuda](#1-investigar-ordres-i-consultar-lajuda)
2. [Fitxers i carpetes](#2-fitxers-i-carpetes)
3. [Variables](#3-variables)
4. [Tipus de dades](#4-tipus-de-dades)
5. [Arrays](#5-arrays)
6. [Pipeline](#6-pipeline)
7. [`Select-Object` i `Get-Member`](#7-select-object-i-get-member)
8. [`Where-Object` i els operadors](#8-where-object-i-els-operadors)
9. [Exemples de pipelines complets](#9-exemples-de-pipelines-complets)
10. [Pràctica de xarxa pendent de documentar](#10-pràctica-de-xarxa-pendent-de-documentar)
11. [Errors i confusions detectats](#11-errors-i-confusions-detectats)
12. [Taula de consulta ràpida](#12-taula-de-consulta-ràpida)


## 1. Investigar ordres i consultar l'ajuda

Quan no coneixes una ordre, pots descobrir-la sense haver-la d'executar primer.

### Cmdlets importants

```powershell
Get-Command *Item*
```

Busca ordres que continguin `Item`. Entre els resultats pots localitzar cmdlets com `New-Item`, `Remove-Item`, `Rename-Item`, `Copy-Item` i `Move-Item`.

```powershell
Get-Help New-Item
Get-Help New-Item -Examples
Get-Help New-Item -Parameter ItemType
```

- `Get-Help` mostra informació d'ajuda sobre un cmdlet.
- `-Examples` mostra exemples d'ús.
- `-Parameter ItemType` mostra informació del paràmetre indicat.

**Important:** . Recorda també que el nom del cmdlet segueix sovint el patró **verb + nom**, per exemple `Get-Service` o `Sort-Object`.

## 2. Fitxers i carpetes

Els cmdlets principals treballats a la pràctica són aquests:

| Acció | Cmdlet | Exemple |
|---|---|---|
| Crear un element | `New-Item` | `New-Item -Path 'C:\Prova' -ItemType Directory` |
| Canviar el nom | `Rename-Item` | `Rename-Item -Path 'C:\Prova' -NewName 'Prova2'` |
| Copiar | `Copy-Item` | `Copy-Item -Path 'C:\Origen\fitxer.txt' -Destination 'C:\Desti'` |
| Moure | `Move-Item` | `Move-Item -Path 'C:\Origen\fitxer.txt' -Destination 'C:\Desti'` |
| Eliminar | `Remove-Item` | `Remove-Item -Path 'C:\Prova\fitxer.txt'` |
| Llistar el contingut | `Get-ChildItem` | `Get-ChildItem -Path 'C:\Prova'` |

### Crear una carpeta

```powershell
New-Item -Path 'C:\Prova' -ItemType Directory
```

`-ItemType Directory` indica que volem crear una carpeta. Per crear un fitxer, el tipus habitual és `File`.

### Canviar el nom d'una carpeta o d'un fitxer

```powershell
Rename-Item -Path 'C:\Prova' -NewName 'ProvaNova'
```

`-Path` identifica l'element actual i `-NewName` indica el nom nou.

### Copiar, moure i eliminar

```powershell
Copy-Item -Path 'C:\Origen\Prova' -Destination 'C:\Desti'
Move-Item -Path 'C:\Origen\Prova' -Destination 'C:\Desti'
Remove-Item -Path 'C:\ProvaNova'
```

**Atenció:** comprova sempre que les rutes siguin correctes abans d'executar una ordre. `Remove-Item` pot eliminar dades; no l'executis sobre una ruta sense verificar-la. Si necessites copiar el contingut d'una carpeta amb els seus elements interiors, consulta l'ajuda per al paràmetre corresponent, com ara `-Recurse`.

## 3. Variables

Una variable guarda un valor o el resultat d'una ordre. El nom comença amb `$`.

### Crear i consultar variables

```powershell
$nom = 'Pere'
$servidor = 'SRV01'
$ip = '192.168.1.10'
$port = 443

$nom
$servidor
$ip
$port
```

L'assignació es fa amb `=`. Per mostrar el contingut, pots escriure el nom de la variable.

### Canviar-ne el valor

```powershell
$servidor = 'SRV01'
$servidor = 'SRV02'
$servidor
```

Després de la segona assignació, el valor actual de `$servidor` és `SRV02`.

### Fer operacions amb variables numèriques

```powershell
$num1 = 20
$num2 = 5

$suma = $num1 + $num2
$resta = $num1 - $num2
$multiplicacio = $num1 * $num2
$divisio = $num1 / $num2
```

En aquest exemple, els resultats són `25`, `15`, `100` i `4`.

### Variables dins d'un text: cometes dobles i simples

```powershell
$nom = 'Anna'
$servidor = 'SRV01'
Write-Host "L'usuari $nom està treballant amb el servidor $servidor"
```

Les **cometes dobles** permeten substituir les variables pels seus valors dins del text. En canvi:

```powershell
Write-Host 'Servidor: $servidor'
```

Amb **cometes simples**, `$servidor` es mostra literalment, sense substituir-se pel seu valor.

### Guardar el resultat d'una ordre

```powershell
$serveis = Get-Service
$processos = Get-Process
```

Les variables contenen els objectes retornats pels cmdlets: `$serveis` conté serveis i `$processos` conté processos. No necessàriament són un únic valor; poden contenir molts objectes.

També pots utilitzar una variable com a paràmetre d'una altra ordre:

```powershell
$nomServei = 'Spooler'
Get-Service -Name $nomServei
```

**Important:** `$serveis = Get-Service` desa el resultat de `Get-Service`; no desa automàticament un resultat ordenat. Per desar els serveis ordenats, cal assignar a la variable el pipeline complet.


## 4. Tipus de dades

El tipus de dada determina com interpreta PowerShell un valor i quines operacions hi fa.

### Tipus treballats

| Tipus | Exemple | Què representa |
|---|---|---|
| `String` | `'Servidor01'` | Text |
| `Int32` | `443` | Nombre enter |
| `Double` | `12.5` | Nombre amb decimals |
| `Boolean` | `$true`, `$false` | Valor lògic: cert o fals |

Per consultar el tipus:

```powershell
$nom = 'Servidor01'
$port = 443
$actiu = $true
$espai = 12.5

$nom.GetType()
$port.GetType()
$actiu.GetType()
$espai.GetType()
```

Per mostrar només el nom del tipus també pots utilitzar `.GetType().Name`.

### Nombres i textos no són el mateix

```powershell
$a = 10
$b = 5
$a + $b       # 15

$a = '10'
$b = '5'
$a + $b       # 105
```

Quan `$a` i `$b` són nombres, `+` fa una suma matemàtica. Quan són textos, `+` els concatena, és a dir, uneix les cadenes.

### El tipus pot canviar encara que el valor sembli igual

```powershell
$valor = 100
$valor.GetType().Name   #Int32

$valor = '100'
$valor.GetType().Name   #String
```

Visualment es pot veure `100` en tots dos casos, però un valor és numèric i l'altre és text.

### Especificar el tipus explícitament

```powershell
[int]$port = 443
[string]$portText = 443

$port.GetType().Name       # Int32
$portText.GetType().Name   # String
```

**Important:** que dos valors es mostrin igual no vol dir que tinguin el mateix tipus ni que es comportin igual en una operació.


## 5. Arrays

Un array és una col·lecció d'elements que es poden guardar en una mateixa variable.

### Crear un array

```powershell
$servidors = 'SRV01', 'SRV02', 'SRV03', 'SRV04'
$servidors
```

També pots crear-ne un a partir de variables existents:

```powershell
$servidor1 = 'SRV01'
$servidor2 = 'SRV02'
$servidor3 = 'SRV03'
$servidors = $servidor1, $servidor2, $servidor3
```

### Accedir als elements

**Els índexs comencen per zero**, no per u.

```powershell
$servidors[0]   # Primer element
$servidors[1]   # Segon element
$servidors[3]   # Quart element
```

### Comptar elements

```powershell
$servidors.Count
```

Afegir un element a l'array existent es pot fer així:

```powershell
$servidors += 'SRV05'
$servidors.Count
```

### Modificar un element

```powershell
$servidors = 'SRV01', 'SRV02', 'SRV03'
$servidors[1] = 'SRV-WEB01'
$servidors
```

Això canvia el segon element, perquè la seva posició és `1`.

### Arrays numèrics

```powershell
$ports = 22, 80, 443, 3389

$ports.Count  # Nombre d'elements
$ports[0]     # Primer port
$ports[-1]    # Últim element
$ports[0].GetType().Name  # Tipus del primer element
```

### Array i resultats de cmdlets

```powershell
$processos = Get-Process
$processos.Count
```

Això permet comptar els elements guardats a la variable. Més endavant, el pipeline també permet comptar els objectes amb `Measure-Object`.


## 6. Pipeline

El pipeline és una manera d'encadenar ordres. El símbol `|` envia els objectes que produeix una ordre a l'ordre següent.

```powershell
Get-Service | Sort-Object Name
```

- `Get-Service` obté els serveis.
- `|` passa els serveis a la següent ordre.
- `Sort-Object Name` els ordena segons la propietat `Name`.

Pots concatenar més de dues operacions:

```powershell
Get-Process |
    Sort-Object CPU -Descending |
    Select-Object -First 5
```

Recorregut: obtenir els processos → ordenar-los per `CPU` de major a menor → quedar-se amb els cinc primers.

### Ordenar

```powershell
Get-Service | Sort-Object Name
Get-Service | Sort-Object Status
Get-Service | Sort-Object Status -Descending
```

`Sort-Object` no crea els serveis ni els processos; rep objectes d'una altra ordre i els ordena segons la propietat indicada.

### L'ordre de les etapes és fonamental

Comparació:

```powershell
# Primer ordenar tots els processos i després seleccionar-ne cinc
Get-Process |
    Sort-Object CPU -Descending |
    Select-Object -First 5

# Primer agafar cinc processos i després ordenar només aquests cinc
Get-Process |
    Select-Object -First 5 |
    Sort-Object CPU -Descending
```

No fan el mateix. La primera ordre selecciona els cinc primers **després d'ordenar tots els processos**. La segona només ordena els cinc processos que s'han seleccionat al principi; no garanteix que siguin els cinc amb més CPU de tot el sistema.

### Desar un resultat de pipeline

```powershell
$serveisOrdenats = Get-Service | Sort-Object Name
$serveisOrdenats
```

La variable conté el resultat ordenat del pipeline. En canvi:

```powershell
$serveis = Get-Service
$serveis | Sort-Object Name
```

Aquí `$serveis` conserva els serveis tal com es van obtenir; l'expressió del pipeline en mostra una versió ordenada, però no reassigna el resultat a `$serveis`.

Per guardar el resultat ordenat a una variable, fes una assignació:

```powershell
$serveis = Get-Service | Sort-Object Name
```

### Seleccionar els elements més grans o més petits

Exemples amb nombres:

```powershell
$ports = 443, 22, 8080, 80, 3389

$ports | Sort-Object
$ports | Sort-Object -Descending
$ports | Sort-Object | Select-Object -First 2
$ports | Sort-Object -Descending | Select-Object -First 2
```

- `Sort-Object` ordena de menor a major per defecte en aquest exemple numèric.
- `-Descending` inverteix l'ordre.
- `Select-Object -First 2` retorna els dos primers elements que rep.
- `Select-Object -Last 2` retorna els dos últims elements que rep.

### Comptar elements amb `Measure-Object`

```powershell
Get-Process | Measure-Object
```

A la sortida, consulta la propietat `Count`. També pots guardar primer els objectes i consultar-ne la quantitat:

```powershell
$processos = Get-Process
$processos.Count
```

La primera forma passa els objectes a `Measure-Object`; la segona consulta el recompte dels objectes guardats a la variable.

### El pipeline no modifica automàticament l'origen

```powershell
$numeros = 40, 10, 30, 20
$numeros | Sort-Object
$numeros
```

La variable `$numeros` continua en l'ordre original. Si vols conservar el resultat ordenat, l'has de desar:

```powershell
$numerosOrdenats = $numeros | Sort-Object
```


## 7. `Select-Object` i `Get-Member`

### Seleccionar propietats

Els objectes retornats pels cmdlets tenen propietats. Amb `Select-Object`, pots decidir quines propietats vols mostrar.

```powershell
Get-Process | Select-Object Name, CPU
Get-Process | Select-Object Name, Id, CPU
```

En aquests exemples es mostren les propietats indicades de cada procés.

### Seleccionar objectes

`-First` i `-Last` seleccionen quants objectes passen:

```powershell
Get-Process | Select-Object -First 5
Get-Process | Select-Object -Last 3
```

**Diferència important:**

- `Select-Object Name, Id, CPU` selecciona **propietats** de cada objecte.
- `Select-Object -First 5` selecciona **objectes** de la col·lecció.

Pots combinar les dues coses:

```powershell
Get-Process |
    Sort-Object CPU -Descending |
    Select-Object -First 5 Name, Id, CPU
```

### Veure les propietats d'un objecte

```powershell
Get-Process |
    Select-Object -First 1 |
    Select-Object *
```

`Select-Object *` serveix per mostrar totes les propietats de l'objecte seleccionat.

Per investigar els membres i el tipus d'un objecte:

```powershell
Get-Process | Get-Member
```

`Get-Member` no és simplement una versió reduïda de `Select-Object *`: serveix per examinar el tipus d'objecte i els membres que exposa, incloent-hi propietats i mètodes. En canvi, `Select-Object *` mostra els valors de les propietats de l'objecte seleccionat.


## 8. `Where-Object` i els operadors

`Where-Object` filtra els objectes que passen pel pipeline. Només deixa continuar els elements que compleixen la condició.

### Operadors de comparació

| Operador | Significat | Exemple |
|---|---|---|
| `-eq` | Igual a | `$_ -eq 12` |
| `-ne` | Diferent de | `$_ -ne 20` |
| `-gt` | Major que | `$_ -gt 10` |
| `-lt` | Menor que | `$_ -lt 20` |
| `-ge` | Major o igual que | `$_ -ge 10` |
| `-le` | Menor o igual que | `$_ -le 20` |

### Filtrar nombres

```powershell
$numeros = 5, 20, 3, 40, 12, 8, 30

$numeros | Where-Object { $_ -gt 10 }  # Majors que 10
$numeros | Where-Object { $_ -lt 20 }  # Menors que 20
$numeros | Where-Object { $_ -eq 12 }  # Iguals a 12
$numeros | Where-Object { $_ -ne 20 }  # Diferents de 20
```

### Què vol dir `$_`?

`$_` representa **l'element actual** que `Where-Object` està examinant en aquell moment. Per exemple:

```powershell
$numeros = 5, 20, 3
$numeros | Where-Object { $_ -gt 10 }
```

El filtre comprova cada element: `5` no passa, `20` passa i `3` no passa. Només queda el `20`.

Quan filtres objectes, pots consultar-ne una propietat amb `$_.NomPropietat`. Per exemple, `$_.Status` és la propietat `Status` del servei actual.

### Filtrar serveis per estat

```powershell
Get-Service |
    Where-Object { $_.Status -eq 'Running' } |
    Select-Object Name, Status
```

Per mostrar els serveis que no estan en execució:

```powershell
Get-Service |
    Where-Object { $_.Status -ne 'Running' } |
    Select-Object Name, Status
```

El filtre descarta els objectes que no compleixen la condició; `Select-Object` rep els que han passat i en mostra només les propietats indicades.

### Combinar condicions

Es poden combinar condicions amb `-and` (totes les condicions han de ser certes) i `-or` (n'hi ha prou que una sigui certa).

```powershell
$numeros = 1, 5, 10, 15, 20, 25, 30, 40

# Entre 10 i 30, inclosos
$numeros | Where-Object { $_ -ge 10 -and $_ -le 30 }

# Menors que 10 o majors que 30
$numeros | Where-Object { $_ -lt 10 -or $_ -gt 30 }
```



## 9. Exemples de pipelines complets

### Els cinc processos amb més CPU, mostrant només tres propietats

```powershell
Get-Process |
    Sort-Object CPU -Descending |
    Select-Object -First 5 Name, Id, CPU
```

### Filtrar, ordenar i seleccionar

```powershell
Get-Process |
    Where-Object { $_.CPU -gt 5 -and $_.Id -gt 1000 } |
    Sort-Object CPU -Descending |
    Select-Object -First 5 Name, Id, CPU
```

Etapes:

1. `Get-Process` obté els processos.
2. `Where-Object` deixa només els que tenen `CPU > 5` **i** `Id > 1000`.
3. `Sort-Object` els ordena de major a menor segons `CPU`.
4. `Select-Object -First 5` es queda amb cinc objectes i en mostra `Name`, `Id` i `CPU`.

### Guardar els deu processos amb més CPU

```powershell
$topProcessos = Get-Process |
    Sort-Object CPU -Descending |
    Select-Object -First 10

$topProcessos
$topProcessos.Count
```

La variable `$topProcessos` conté el resultat final, no tots els processos del sistema: com a màxim, hi guarda els deu elements seleccionats.

### Treballar amb elements de fitxers i carpetes

La pràctica demana ordenar la sortida de `Get-ChildItem`, seleccionar els elements més grans o més petits i guardar-ne una selecció. El patró del pipeline és:

```powershell
Get-ChildItem |
    Sort-Object Length -Descending |
    Select-Object -First 3
```

Aquest exemple ordena segons `Length` i retorna els tres primers. Tingues present que `Length` és la mida del fitxer; no representa necessàriament la mida total d'una carpeta i dels seus continguts.



## 10. Errors i confusions detectats

Aquesta secció recull errors de sintaxi i de raonament que apareixen als fitxers o en les explicacions de les pràctiques, amb la manera de corregir-los.

### 10.1 Sintaxi incompleta de `Move-Item`

La comanda documentada té cometes mal col·locades, una ruta incompleta i manca el paràmetre `-Destination`. Escriu l'origen i la destinació com a arguments separats:

```powershell
Move-Item -Path 'C:\Users\youssef\Downloads\test' -Destination 'C:\Users\Youssef'
```

Adapta les rutes als directoris que existeixen realment al teu equip.

### 10.2 Confondre `Sort-Object` amb `Select-Object`

A les notes s'arriba a explicar que els cinc primers processos no són necessàriament els de més CPU perquè «no hi ha el `Select-Object` que ordena». Això barreja les funcions:

- `Sort-Object` **ordena**.
- `Select-Object -First 5` **selecciona cinc elements** de l'entrada que rep.

Ordre correcta per obtenir els cinc primers segons CPU descendent:

```powershell
Get-Process |
    Sort-Object CPU -Descending |
    Select-Object -First 5
```

### 10.3 Seleccionar abans d'ordenar quan es busquen els valors més alts

Aquest pipeline funciona sintàcticament, però no resol el problema dels cinc processos amb més CPU de tot el sistema:

```powershell
Get-Process |
    Select-Object -First 5 |
    Sort-Object CPU -Descending
```

`Sort-Object` només rep els cinc processos seleccionats prèviament, no tots els processos. **Primer cal ordenar i després seleccionar.**

### 10.4 Error en comptar els objectes que arriben a `Sort-Object`

En el cas `Select-Object -First 5 | Sort-Object ...`, `Sort-Object` rep cinc objectes (o menys si n'hi ha menys disponibles), no tots els processos. En el cas `Sort-Object ... | Select-Object -First 5`, `Sort-Object` rep tots els processos produïts per `Get-Process`.

### 10.5 Creure que ordenar pel pipeline modifica la variable original

Aquesta ordre només mostra els nombres ordenats; no reassigna el resultat a `$numeros`:

```powershell
$numeros | Sort-Object
```

Per desar la nova ordenació:

```powershell
$numerosOrdenats = $numeros | Sort-Object
```

La mateixa idea s'aplica a serveis, processos, ports i altres col·leccions.

### 10.6 Interpretar `Get-Member` com si només mostrés menys propietats

`Get-Member` i `Select-Object *` tenen finalitats diferents:

- `Get-Member` inspecciona el tipus i els membres de l'objecte (propietats, mètodes, etc.).
- `Select-Object *` mostra els valors de totes les propietats de l'objecte seleccionat.

No són simplement dues visualitzacions amb més o menys informació; serveixen per investigar aspectes diferents de l'objecte.