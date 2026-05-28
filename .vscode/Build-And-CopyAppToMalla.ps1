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
$startTime = Get-Date

Write-Host "Esperando paquete $appFileName tras AL: Package..."

# Esperar .app nuevo/actualizado en la raíz del proyecto (máx. 5 minutos)
$timeoutSeconds = 50
$elapsed = 0
$ready = $false
while ($elapsed -lt $timeoutSeconds) {
    if (Test-Path $sourcePath) {
        $fileInfo = Get-Item $sourcePath
        if ($fileInfo.LastWriteTime -ge $startTime.AddSeconds(-1)) {
            Start-Sleep -Seconds 2
            $ready = $true
            break
        }
    }
    Start-Sleep -Seconds 1
    $elapsed++
}

if (-not $ready) {
    Write-Error "No se generó $appFileName en $WorkspaceFolder tras $timeoutSeconds s. Revisa errores de AL: Package en la ventana Output (AL)."
    exit 1
}

if (-not (Test-Path $destFolder)) {
    New-Item -ItemType Directory -Path $destFolder -Force | Out-Null
}

Copy-Item -Path $sourcePath -Destination $destPath -Force
Write-Host "Paquete copiado: $appFileName -> $destFolder"
