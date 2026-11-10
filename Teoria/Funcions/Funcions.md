# Apunts de PowerShell: paràmetres i funcions

## 1. Paràmetres de l'script (`param`)

Els paràmetres permeten passar informació a un script quan l'executem, sense haver de modificar el codi.

El bloc `param()` s'ha de col·locar al principi de l'script, abans de les instruccions.

```powershell
param(
    [Parameter(Mandatory = $true)]
    [string]$text,

    [Parameter(Mandatory = $true)]
    [string]$text2
)
```

**Què significa cada element?**

- `param()`: indica que declararem els paràmetres que rebrà l'script.
- `[Parameter(Mandatory = $true)]`: fa que el paràmetre sigui obligatori. Si no li proporcionem un valor, PowerShell ens el demanarà.
- `[string]`: indica que el valor ha de ser de tipus cadena de text.
- `$text` i `$text2`: són els noms de les variables on es guardaran els valors rebuts.

**Com executem l'script?**

Per exemple, si el fitxer es diu `Exemple.ps1`:

```powershell
.\Exemple.ps1 -text "Hola" -text2 "Mon"
```

En aquest cas:
- `$text` contindrà `"Hola"`.
- `$text2` contindrà `"Mon"`.

**Important:** els paràmetres de l'script i els paràmetres d'una funció són independents, encara que tinguin el mateix nom.

---

## 2. Funcions (`function`)

Una funció és un bloc de codi que podem executar quan el necessitem. Ens permet reutilitzar instruccions sense haver-les d'escriure diverses vegades.

La seva estructura bàsica és:

```powershell
function Nom-Funcio {

    param(
        [Parameter(Mandatory = $true)]
        [string]$parametre1,

        [Parameter(Mandatory = $true)]
        [string]$parametre2
    )

    # Instruccions que executarà la funció
    Write-Host "Hola, soc una funció"
}
```

**Parts principals:**

1. `function`: paraula reservada que indica que estem declarant una funció.
2. `Nom-Funcio`: nom que donem a la funció.
3. `param()`: declara els paràmetres que necessita la funció.
4. Les instruccions que hi ha dins de les claus `{ }`: són les ordres que s'executaran quan cridem la funció.

**Com cridem una funció?**

Després de declarar-la, podem executar-la utilitzant el seu nom i passant-li els paràmetres:

```powershell
Nom-Funcio -parametre1 "Hola" -parametre2 "Mon"
```

El símbol `-` indica el nom del paràmetre al qual assignem cada valor.

---

## 3. Àmbit de les variables (Scope)

L'àmbit d'una variable determina des d'on podem accedir-hi i on tenen efecte els seus canvis.

En PowerShell, una funció té el seu propi àmbit local. També pot accedir a variables declarades en àmbits superiors, com ara el de l'script.

### Exemple 1: variables fora i dins d'una funció

```powershell
# PARÀMETRES DE L'SCRIPT
param(
    [Parameter(Mandatory = $true)]
    [string]$text,

    [Parameter(Mandatory = $true)]
    [string]$text2
)

# VARIABLE DECLARADA A L'ÀMBIT DE L'SCRIPT
[string]$nom = "Miquel"


# DECLARACIÓ DE LA FUNCIÓ
function Write-Message {

    # PARÀMETRES PROPIS DE LA FUNCIÓ
    param(
        [Parameter(Mandatory = $true)]
        [string]$text,

        [Parameter(Mandatory = $true)]
        [string]$text2
    )

    # VARIABLE LOCAL DE LA FUNCIÓ
    [string]$nom = "Maria"

    # Mostrem el valor de la variable local
    Write-Host "Dins de la funció: $nom"

    # Mostrem els dos paràmetres rebuts
    Write-Host "$text --- $text2"
}


# CRIDEM LA FUNCIÓ
Write-Message -text $text -text2 "Diferent"


# MOSTREM LA VARIABLE DE L'ÀMBIT DE L'SCRIPT
Write-Host "Fora de la funció: $nom"
```

### Què està passant?

**1. Declarem `$nom = "Miquel"` fora de la funció.**

Aquesta variable pertany a l'àmbit de l'script.

**2. Declarem una altra variable `$nom = "Maria"` dins de la funció.**

Encara que les dues variables tinguin el mateix nom, són variables de diferents àmbits.

La funció crea la seva pròpia variable local `$nom`, que conté `"Maria"`.

**3. Executem la funció.**

```powershell
Write-Message -text $text -text2 "Diferent"
```

Li passem dos valors:
- `$text`: rep el valor que havia rebut l'script.
- `$text2`: rep el text `"Diferent"`.

**4. Sortim de la funció i tornem a consultar `$nom`.**

La variable local de la funció no modifica la variable de l'script. Per tant, fora de la funció continua tenint el valor `"Miquel"`.

### Resultat de l'exemple

Si executem l'script amb:

```powershell
.\Exemple.ps1 -text "Hola" -text2 "Mon"
```

Obtindrem:

```text
Dins de la funció: Maria
Hola --- Diferent
Fora de la funció: Miquel
```

**IDEA IMPORTANT:**

Les variables declarades dins d'una funció són locals a aquesta funció. Si modifiquem una variable dins de la funció, no estem modificant automàticament la variable que té el mateix nom en l'àmbit de l'script.

> Nota: una variable declarada fora d'una funció no és necessàriament una variable global. En aquest exemple pertany a l'àmbit de l'script. PowerShell també permet especificar explícitament l'àmbit global amb `$global:nom`.

---

## 4. Retornar informació d'una funció

Fins ara hem utilitzat `Write-Host` per mostrar missatges per pantalla. Però cal distingir dues coses:

- `Write-Host`: mostra informació a la consola.
- `Write-Output`: envia informació com a resultat de la funció, de manera que la podem guardar en una variable o reutilitzar.

També podem escriure directament una expressió dins de la funció perquè el seu resultat s'enviï al pipeline.

### Exemple 2: retornar un valor i reutilitzar-lo

```powershell
# PARÀMETRES DE L'SCRIPT
param(
    [Parameter(Mandatory = $true)]
    [string]$text,

    [Parameter(Mandatory = $true)]
    [string]$text2
)


# FUNCIÓ QUE GENERA I RETORNA UN MISSATGE
function Get-Message {

    param(
        [Parameter(Mandatory = $true)]
        [string]$text,

        [Parameter(Mandatory = $true)]
        [string]$text2
    )

    # Retornem una cadena de text
    return "$text --- $text2"
}


# FUNCIÓ QUE REP I MOSTRA UN MISSATGE
function Write-Message {

    param(
        [Parameter(Mandatory = $true)]
        [string]$text
    )

    # Mostrem el valor que ha rebut
    Write-Host "La funcio ha rebut: $text"
}


# CRIDEM UNA FUNCIÓ DINS DE L'ALTRA
Write-Message -text (Get-Message -text $text -text2 "Diferent")
```

### Què està passant?

**1. Executem la funció `Get-Message`.**

```powershell
Get-Message -text $text -text2 "Diferent"
```

Aquesta funció rep dos paràmetres i construeix un missatge.

**2. La funció retorna el resultat.**

```powershell
return "$text --- $text2"
```

La paraula `return` fa que la funció retorni el valor i finalitzi la seva execució.

El resultat serà, per exemple:

```text
Hola --- Diferent
```

**3. Utilitzem el resultat com a paràmetre d'una altra funció.**

```powershell
Write-Message -text (Get-Message -text $text -text2 "Diferent")
```

Aquesta instrucció pot semblar complicada, però funciona de la manera següent:

- Primer s'executa `Get-Message`.
- Aquesta funció retorna el missatge `"Hola --- Diferent"`.
- El resultat es passa al paràmetre `-text` de `Write-Message`.
- Finalment, `Write-Message` mostra el missatge per pantalla.

**Resultat:**

```text
La funcio ha rebut: Hola --- Diferent
```

**IDEA IMPORTANT:** podem executar una funció dins d'una altra instrucció i aprofitar el valor que retorna com si fos una variable.

---

## 5. Errors i conceptes que cal recordar

En els exemples originals hi havia algunes coses que podien provocar confusió:

| Concepte | Explicació |
|---|---|
| `param()` de l'script | Defineix els paràmetres que rep el fitxer `.ps1`. |
| `param()` d'una funció | Defineix els paràmetres que rep aquella funció. |
| `[string]` | Especifica que el paràmetre és de tipus text. |
| `Mandatory = $true` | Indica que el paràmetre és obligatori. |
| `Write-Host` | Mostra informació a la consola, però no retorna un resultat normal al pipeline. |
| `Write-Output` | Envia informació al pipeline perquè es pugui reutilitzar. |
| `return` | Retorna un valor i finalitza l'execució de la funció. |
| Àmbit local | Àmbit propi d'una funció. |
| Àmbit de l'script | Àmbit on es declaren les variables de l'script. |

### Per què no funcionava correctament el segon exemple original?

Hi havia una crida semblant a aquesta:

```powershell
Write-Message -text (Write-Message -text $text -text2 "Diferent")
```

Aquesta instrucció tenia dos problemes:

1. La funció només tenia declarat el paràmetre `-text`, però s'intentava passar també `-text2`. PowerShell no reconeix aquest segon paràmetre si no està declarat a la funció.
2. S'estava cridant la mateixa funció dins d'ella mateixa (una crida recursiva). A més, si utilitzem `Write-Host`, no obtenim un valor de retorn normal per passar-lo a la crida exterior.

Per això, quan volem aprofitar el resultat d'una funció dins d'una altra, és important que la primera retorni un valor mitjançant `return`, `Write-Output` o una expressió que generi sortida al pipeline.

---

## 6. Resum final

- **`param()`** serveix per definir els paràmetres que rep un script o una funció.
- **`function`** serveix per crear blocs de codi reutilitzables.
- **Els paràmetres de l'script i els de les funcions són independents.**
- **Les variables locals** pertanyen a l'àmbit de la funció.
- **Les variables de l'script** poden ser accessibles des de les funcions, però una assignació local no modifica automàticament la variable de l'script.
- **`Write-Host`** serveix per mostrar missatges.
- **`return`** serveix per retornar un resultat i finalitzar la funció.
- Podem **cridar una funció des d'una altra funció** i aprofitar el valor que retorna.

