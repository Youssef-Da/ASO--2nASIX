# 2. Crear un script que crei una ou amb nomes el nom de la ou com a dada d'entrada
param(
    [Parameter(Mandatory=$true)]
    [string]$nomOU
)
$ruta = "DC=musiccloud,DC=local"

try {
    $OU = Get-ADOrganizationalUnit -Identity "OU=$nomOU,$ruta" -ErrorAction Stop
}
catch {
    $OU = $null
}

if (-not $OU) {
    New-ADOrganizationalUnit -Name $nomOU -Path $ruta
    Write-Host "La OU '$nomOU' s'ha creat a la ruta '$ruta'."
}
else {
    Write-Host "La OU '$nomOU' ja existeix a la ruta '$ruta'."
}