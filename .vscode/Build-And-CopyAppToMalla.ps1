param(
    [Parameter(Mandatory = $true)]
    [string]$WorkspaceFolder
)

$destFolder = 'C:\apps\Malla'
$appJsonPath = Join-Path $WorkspaceFolder 'app.json'
$appJson = Get-Content $appJsonPath -Raw | ConvertFrom-Json
$appFileName = "$($appJson.publisher)_$($appJson.name)_$($appJson.version).app"
$sourcePath = Join-Path $WorkspaceFolder $appFileName
$destPath = Join-Path $destFolder $appFileName

if (-not (Test-Path $sourcePath)) {
    Write-Error "No se encontró $appFileName en $WorkspaceFolder. Ejecuta AL: Package antes de copiar."
    exit 1
}

if (-not (Test-Path $destFolder)) {
    New-Item -ItemType Directory -Path $destFolder -Force | Out-Null
}

Copy-Item -Path $sourcePath -Destination $destPath -Force
Write-Host "Paquete copiado: $appFileName -> $destFolder"
