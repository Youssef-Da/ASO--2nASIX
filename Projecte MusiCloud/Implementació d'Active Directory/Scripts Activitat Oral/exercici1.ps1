# 1. Crear una script que crei una ou amb valors fixes, fent servir variables.
$nomOU = "Musiccloud"
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