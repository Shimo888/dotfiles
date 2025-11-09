# PowerShell setup script for Windows

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ConfigFile = Join-Path $ScriptDir "config.json"

Write-Host "🚀 Starting dotfiles setup for Windows..." -ForegroundColor Cyan

if (-not (Test-Path $ConfigFile)) {
    Write-Host "❌ Config file not found: $ConfigFile" -ForegroundColor Red
    exit 1
}

$config = Get-Content $ConfigFile | ConvertFrom-Json

function Create-Symlink {
    param(
        [string]$Source,
        [string]$Target
    )
    
    if (Test-Path $Target) {
        $item = Get-Item $Target -Force
        
        if ($item.Attributes -band [System.IO.FileAttributes]::ReparsePoint) {
            $currentSource = $item.Target
            if ($currentSource -eq $Source) {
                Write-Host "  ✓ $Target is already correctly linked" -ForegroundColor Green
                return
            }
        }
        
        Write-Host "  ⚠️  $Target already exists" -ForegroundColor Yellow
        $response = Read-Host "    Do you want to backup and replace it? (y/N)"
        
        if ($response -eq 'y' -or $response -eq 'Y') {
            $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
            $backup = "$Target.backup.$timestamp"
            Move-Item -Path $Target -Destination $backup -Force
            Write-Host "  📦 Backed up to $backup" -ForegroundColor Yellow
        } else {
            Write-Host "  ⏭️  Skipped $Target" -ForegroundColor Gray
            return
        }
    }
    
    $sourceItem = Get-Item $Source
    if ($sourceItem.PSIsContainer) {
        New-Item -ItemType SymbolicLink -Path $Target -Target $Source -Force | Out-Null
    } else {
        New-Item -ItemType SymbolicLink -Path $Target -Target $Source -Force | Out-Null
    }
    
    Write-Host "  ✓ Created symlink: $Target -> $Source" -ForegroundColor Green
}

function Process-Files {
    param(
        [array]$Files
    )
    
    foreach ($file in $Files) {
        $sourcePath = Join-Path $ScriptDir $file
        $targetPath = Join-Path $env:USERPROFILE $file
        
        if (-not (Test-Path $sourcePath)) {
            Write-Host "  ⚠️  Source file not found: $sourcePath" -ForegroundColor Yellow
            continue
        }
        
        Create-Symlink -Source $sourcePath -Target $targetPath
    }
}

Write-Host ""
Write-Host "📝 Processing common files..." -ForegroundColor Cyan
if ($config.common) {
    Process-Files -Files $config.common
}

Write-Host ""
Write-Host "📝 Processing Windows specific files..." -ForegroundColor Cyan
if ($config.windows) {
    Process-Files -Files $config.windows
}

Write-Host ""
Write-Host "✨ Setup completed successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "💡 Next steps:" -ForegroundColor Yellow
Write-Host "   - Review the symlinks created in your home directory"
Write-Host "   - You may need to restart your terminal or applications"
Write-Host ""
Write-Host "⚠️  Note: Creating symlinks on Windows requires administrator privileges" -ForegroundColor Yellow
Write-Host "   If you encountered permission errors, please run PowerShell as Administrator" -ForegroundColor Yellow
