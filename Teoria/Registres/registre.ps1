#Script registrar informació en un fitxer de registre

$data = Get-Date -Format "dd/MM/yyyy HH:mm:ss"

Add-Content `
    -Path ".\registre.log" `
    -Value "$data [INFO] Execució 'registre.ps1'"

#INFO, WARN, ERR, VERBOSE, DEBUG

Write-Error "$data [ERR] Invalid name" 2>> ".\registre.log"
Write-Warning "$data [WARN] Variable set to default value"


#Funcio

function escriure-text {
    write-output "Output"
    write-information "Information"
    write-error "Error"
    get-content "registre.log"
}

$InformationPreference = "Continue"
$resultat = escriure-text
Write-Output "*********************************"
$resultat

# El try i el cathch

try {
    Get-Content -path "Fitxer que no existeix" -ErrorAction Stop
} catch {
    Write-Error "$data [ERR] Error en llegir el fitxer" 2>>registre.log
    exit
}