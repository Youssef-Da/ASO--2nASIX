# 7. L'script ha de crear totes les OU que jo li digui que estiguin en un lloc determinat, per exemple jo tinc Musicloud tinc Usuaris, dins d'users tinc departaments. L'script ha de crear tots els departaments pero si jo vull crear els departaments. Si jo li dic que la meva ruta es d'equips haura de crear clients i servidors
param(
    [Parameter(Mandatory=$true)]
    [string[]]$nomOU,

    [Parameter(Mandatory=$false)]
    [string]$ruta = "DC=musiccloud,DC=local"
)

Import-Module ActiveDirectory

function Crear-OU {
    param([string]$nom, [string]$path)

    try {
        Get-ADOrganizationalUnit -Identity "OU=$nom,$path" -ErrorAction Stop | Out-Null
        Write-Host "La OU '$nom' ja existeix a '$path'."
    }
    catch {
        New-ADOrganizationalUnit -Name $nom -Path $path
        Write-Host "La OU '$nom' s'ha creat a '$path'."
    }
}

$parts   = $ruta -split ','
$base    = (@($parts | Where-Object { $_ -like 'DC=*' })) -join ','
$ouParts = @($parts | Where-Object { $_ -like 'OU=*' })

try {
    Get-ADObject -Identity $base -ErrorAction Stop | Out-Null
}
catch {
    Write-Host "El domini '$base' no existeix. Comprova la ruta i torna-ho a intentar."
    exit 1
}

[array]::Reverse($ouParts)
$actual = $base
foreach ($p in $ouParts) {
    Crear-OU -nom ($p -replace '^OU=', '') -path $actual
    $actual = "$p,$actual"
}

foreach ($nom in $nomOU) {
    Crear-OU -nom $nom -path $actual
}