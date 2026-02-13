# PEERMUSIC DEMO System Launcher
# This script starts the server and opens the browser automatically

$port = 8000
$url = "http://localhost:$port"

# Get current directory
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $scriptDir

# Check if server is already running
$existingProcess = Get-NetTCPConnection -LocalPort $port -ErrorAction SilentlyContinue
if ($existingProcess) {
    Write-Host "Server is already running at $url" -ForegroundColor Yellow
    Start-Process $url
    exit
}

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   PEERMUSIC DEMO System" -ForegroundColor White
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Start server in background job
Write-Host "[1/2] Starting server..." -ForegroundColor Green
$job = Start-Job -ScriptBlock {
    param($dir, $port)
    Set-Location $dir
    python -m http.server $port
} -ArgumentList $scriptDir, $port

# Wait for server to be ready
Write-Host "[2/2] Waiting for server to start..." -ForegroundColor Green
Start-Sleep -Seconds 2

# Open browser
Write-Host "[3/3] Opening browser..." -ForegroundColor Green
Start-Process $url

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   Server is running!" -ForegroundColor Green
Write-Host "   URL: $url" -ForegroundColor White
Write-Host ""
Write-Host "   Press any key to stop server..." -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Keep window open and wait for key press
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

# Cleanup
Write-Host "Stopping server..." -ForegroundColor Yellow
Stop-Job -Job $job
Remove-Job -Job $job
Write-Host "Server stopped." -ForegroundColor Green
