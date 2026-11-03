# 7. L'script ha de crear totes les OU que jo li digui que estiguin en un lloc determinat, per exemple jo tinc Musicloud tinc Usuaris, dins d'users tinc departaments. L'script ha de crear tots els departaments pero si jo vull crear els departaments. Si jo li dic que la meva ruta es d'equips haura de crear clients i servidors
param(
    [Parameter(Mandatory=$true)]
    [string[]]$nomOU,
    [Parameter(Mandatory=$false)]
    [string]$ruta = "DC=musiccloud,DC=local"
)

try {
    Get-ADObject -Identity $ruta -ErrorAction Stop | Out-Null
}
catch {
    Write-Host "La ruta '$ruta' no existeix. Comprova la ruta i torna-ho a intentar."
    exit 1
}

foreach ($nom in $nomOU) {

    try {
        $OU = Get-ADOrganizationalUnit -Identity "OU=$nom,$ruta" -ErrorAction Stop
        Write-Host "La OU '$nom' ja existeix a la ruta '$ruta'. No cal crear-la."
    }
    catch {
        try {
            New-ADOrganizationalUnit -Name $nom -Path $ruta -ErrorAction Stop
            Write-Host "La OU '$nom' s'ha creat a la ruta '$ruta'."
        }
        catch {
            Write-Host "No s'ha pogut crear la OU '$nom': $($_.Exception.Message)"
        }
    }
} 