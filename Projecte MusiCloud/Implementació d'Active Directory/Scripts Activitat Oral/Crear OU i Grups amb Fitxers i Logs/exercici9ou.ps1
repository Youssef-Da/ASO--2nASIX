# Passar OU i Grups a fitxers, que es pugui triar la ruta però que n'hi hagi una una per defecte. A més, que comprovi que el fitxer existeix.
param(
    [Parameter(Mandatory=$true)]
    [string]$fitxer = ".\projectemusicloud\Implementació d'Active Directory\Scripts Activitat Oral\Grups\ou_exercici9.csv",
    [Parameter(Mandatory=$true)]
    [string]$ruta   = "DC=musiccloud,DC=local",
    [string]$log = ".\Projecte MusiCloud\Implementació d'Active Directory\Scripts Activitat Oral\Crear OU i Grups amb Fitxers i Logs\registre.log"
)

function Escriure-log {
    param([string]$missatge)
    $data = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Add-Content -Path $log -Value "$data [LOG] $missatge"
}

function Comprovar-Ruta {
    try {
        Get-ADObject -Identity $ruta -ErrorAction Stop | Out-Null
        return $true
    }
    catch {
        Escriure-log "La ruta especificada no existeix: $ruta"
        return $false
    }
}
function Crear-OU {
    param([string]$nom)

    try {
        Get-ADOrganizationalUnit -Identity "OU=$nom,$ruta" -ErrorAction Stop | Out-Null
        Escriure-Log "L'OU '$nom' ja existeix a la ruta '$ruta'"
    }
    try {
        New-ADOrganizationalUnit -Name $nom -Path $ruta -ErrorAction SilentlyContinue
        Escriure-Log "S'ha creat l'OU '$nom' a la ruta '$ruta'"
    }
}

Escriure-Log "Inici de l'execució del script"

if (-not (Comprovar-Ruta)) {
    exit
}

if (-not (Test-Path $fitxer)) {
    Escriure-Log "ERR" "No s'ha trobat el fitxer '$fitxer'"
    exit
}

$OUs = Import-Csv $fitxer

foreach ($ou in $OUs) {
    Crear-OU -nom $ou.Nom
}