# Passar OU i Grups a fitxers, que es pugui triar la ruta però que n'hi hagi una una per defecte. A més, que comprovi que el fitxer existeix.
param(
    [Parameter(Mandatory=$true)]
    [string]$fitxer = ".\projectemusicloud\Implementació d'Active Directory\Scripts Activitat Oral\Grups\ou_exercici9.csv",
    [Parameter(Mandatory=$true)]
    [string]$ruta   = "DC=musiccloud,DC=local"
)

function Comprovar-Ruta {
    try {
        Get-ADObject -Identity $ruta -ErrorAction Stop | Out-Null
        return $true
    }
    catch {
        return $false
    }
}
function Crear-OU {
    param([string]$nom)

    try {
        Get-ADOrganizationalUnit -Identity "OU=$nom,$ruta" -ErrorAction Stop | Out-Null
    }
    catch {
        New-ADOrganizationalUnit -Name $nom -Path $ruta -ErrorAction SilentlyContinue
    }
}

if (-not (Comprovar-Ruta)) {
    exit
}

if (-not (Test-Path $fitxer)) {
    exit
}

$OUs = Import-Csv $fitxer

foreach ($ou in $OUs) {
    Crear-OU -nom $ou.Nom
}