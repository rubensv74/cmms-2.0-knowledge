param(
    [string]$OutputPath = ""
)

$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent $MyInvocation.MyCommand.Path

if ([string]::IsNullOrWhiteSpace($OutputPath)) {
    $OutputPath = Join-Path $Root "releases/AMEF_RCM_Experience_Center_v1.0.zip"
}

$OutputDirectory = Split-Path -Parent $OutputPath
New-Item -ItemType Directory -Force -Path $OutputDirectory | Out-Null

if (Test-Path $OutputPath) {
    Remove-Item $OutputPath -Force
}

$Items = @(
    "index.html",
    "mapa-maestro",
    "prototipos",
    "docs",
    "README.md",
    "manifest.json"
) | ForEach-Object { Join-Path $Root $_ }

Compress-Archive -Path $Items -DestinationPath $OutputPath -CompressionLevel Optimal
$Hash = (Get-FileHash -Algorithm SHA256 -Path $OutputPath).Hash.ToLowerInvariant()

Write-Host "Paquete creado: $OutputPath"
Write-Host "SHA256: $Hash"
