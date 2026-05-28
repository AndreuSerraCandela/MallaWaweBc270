# Instala Ctrl+Shift+B = AL: Package + copiar .app a Malla en los atajos de usuario de Cursor.
$keybindingsPath = Join-Path $env:APPDATA 'Cursor\User\keybindings.json'
$binding = @{
    key      = 'ctrl+shift+b'
    command  = 'runCommands'
    args     = @{
        commands = @(
            'al.package',
            @{
                command = 'workbench.action.tasks.runTask'
                args    = 'Copiar .app a Malla'
            }
        )
    }
    when     = 'alExtensionActive'
}

if (-not (Test-Path (Split-Path $keybindingsPath -Parent))) {
    Write-Error "No se encontró la carpeta de Cursor en $keybindingsPath"
    exit 1
}

$content = if (Test-Path $keybindingsPath) { Get-Content $keybindingsPath -Raw } else { "// Place your key bindings in this file to override the defaults`n[]" }

$bindingBlock = @'
    {
        "key": "ctrl+shift+b",
        "command": "runCommands",
        "args": {
            "commands": [
                "al.package",
                {
                    "command": "workbench.action.tasks.runTask",
                    "args": "Copiar .app a Malla"
                }
            ]
        },
        "when": "alExtensionActive"
    }
'@

if ($content -match '"key"\s*:\s*"ctrl\+shift\+b"') {
    Write-Host 'El atajo ctrl+shift+b ya está configurado.'
    exit 0
}

$otherBindings = @()
if ($content -match '"key"\s*:\s*"ctrl\+i"') {
    $otherBindings += @'
    {
        "key": "ctrl+i",
        "command": "composerMode.agent"
    },
'@
}

$newContent = @"
// Place your key bindings in this file to override the defaults
[
$($otherBindings -join "`n")
$bindingBlock
]
"@

Set-Content -Path $keybindingsPath -Value $newContent.TrimEnd() -Encoding UTF8
Write-Host "Atajo instalado en: $keybindingsPath"
Write-Host "Reinicia Cursor o recarga la ventana (Ctrl+Shift+P -> Developer: Reload Window)."
