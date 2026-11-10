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

function Crear-Grup {
    param([string]$nom)

    try {
        Get-ADGroup -Identity $nom -ErrorAction Stop | Out-Null
    }
    catch {
        New-ADGroup -Name $nom -Path $ruta -GroupScope $scope -GroupCategory $categoria -ErrorAction SilentlyContinue
    }
}
