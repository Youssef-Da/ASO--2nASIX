# 8. L'script amb funcions per crear grups
param(
    [Parameter(Mandatory=$true)]
    [string[]]$nomGrup,
    [string]$ruta = "DC=musiccloud,DC=local",
    [string]$scope = "Global",
    [string]$categoria = "Security"
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