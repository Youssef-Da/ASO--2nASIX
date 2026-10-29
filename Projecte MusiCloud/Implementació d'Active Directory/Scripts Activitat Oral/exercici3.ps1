# 3. Crear un script on el nom i la ruta son variables

param(
    [Parameter(Mandatory=$true)]
    [string]$nomOU,
    [Parameter(Mandatory=$true)]
    [string]$ruta
)

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