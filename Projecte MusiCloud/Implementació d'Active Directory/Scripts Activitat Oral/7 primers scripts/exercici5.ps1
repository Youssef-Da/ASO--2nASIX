# 5. El nom de l'OU sigui obligatori i que la ruta si no s'especifica prengui un valor per defecte.
param(
    [Parameter(Mandatory=$true)]
    [string]$nomOU,
    [Parameter(Mandatory=$false)]
    [string]$ruta = "DC=musiccloud,DC=local"
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