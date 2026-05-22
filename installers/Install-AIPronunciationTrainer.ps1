# ============================================================================
# AI Pronunciation Trainer — One-Click Installer (Windows)
# Source: https://github.com/Thiagohgl/ai-pronunciation-trainer
# ============================================================================

param(
    [string]$InstallDir = (Join-Path $HOME "ai-pronunciation-trainer")
)

$ErrorActionPreference = "Stop"

Write-Host "`n🎤  AI Pronunciation Trainer — Installer" -ForegroundColor Cyan

$RepoUrl = "https://github.com/Thiagohgl/ai-pronunciation-trainer.git"

# ─── Prerequisites ───────────────────────────────────────────────────────────
Write-Host "`nChecking prerequisites..." -ForegroundColor Cyan

# Python
$Python = $null
foreach ($cmd in @("python", "python3", "py")) {
    try {
        $ver = & $cmd --version 2>&1
        if ($ver -match "Python 3") { $Python = $cmd; break }
    } catch {}
}
if (-not $Python) {
    Write-Host "X Python 3 not found. Download it from https://www.python.org/downloads/" -ForegroundColor Red
    exit 1
}
$pyVer = (& $Python --version 2>&1) -replace "Python ",""
Write-Host "  Python $pyVer ... OK" -ForegroundColor Green

# Git
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "X Git not found. Download it from https://git-scm.com/" -ForegroundColor Red
    exit 1
}
Write-Host "  git ... OK" -ForegroundColor Green

# FFmpeg
if (-not (Get-Command ffmpeg -ErrorAction SilentlyContinue)) {
    Write-Host "! FFmpeg not found." -ForegroundColor Yellow
    Write-Host "  Please install it manually:" -ForegroundColor Yellow
    Write-Host "  1. Download from https://ffmpeg.org/download.html (Windows build)" -ForegroundColor Yellow
    Write-Host "  2. Extract the archive and add the 'bin' folder to your PATH." -ForegroundColor Yellow
    Write-Host "  3. Re-run this installer after adding FFmpeg to PATH." -ForegroundColor Yellow
    exit 1
}
Write-Host "  ffmpeg ... OK" -ForegroundColor Green

# ─── Clone Repository ────────────────────────────────────────────────────────
Write-Host "`nCloning repository to $InstallDir..." -ForegroundColor Cyan
if (Test-Path (Join-Path $InstallDir ".git")) {
    Write-Host "  Directory already exists — pulling latest changes..." -ForegroundColor Yellow
    git -C $InstallDir pull --ff-only
} else {
    git clone $RepoUrl $InstallDir
}

# ─── Virtual Environment ─────────────────────────────────────────────────────
Write-Host "`nCreating virtual environment..." -ForegroundColor Cyan
& $Python -m venv (Join-Path $InstallDir ".venv")
$VenvPy  = Join-Path $InstallDir ".venv\Scripts\python.exe"
$VenvPip = Join-Path $InstallDir ".venv\Scripts\pip.exe"

# ─── Install Dependencies ────────────────────────────────────────────────────
Write-Host "`nInstalling Python dependencies (this may take a few minutes)..." -ForegroundColor Cyan
& $VenvPip install --upgrade pip --quiet
& $VenvPip install -r (Join-Path $InstallDir "requirements.txt") `
    --extra-index-url https://download.pytorch.org/whl/cpu `
    --quiet

# ─── Create Launcher ─────────────────────────────────────────────────────────
$LauncherPath = Join-Path $InstallDir "start.bat"
$LauncherContent = @"
@echo off
cd /d "$InstallDir"
echo Starting AI Pronunciation Trainer at http://127.0.0.1:3000
"$VenvPy" webApp.py
pause
"@
Set-Content -Path $LauncherPath -Value $LauncherContent

# ─── Done ────────────────────────────────────────────────────────────────────
Write-Host "`n✅ Installation Complete!" -ForegroundColor Green
Write-Host "  Install location : $InstallDir"
Write-Host "  To start         : double-click  start.bat  or run it from a terminal"
Write-Host "  Then open        : http://127.0.0.1:3000  in Chrome`n"
