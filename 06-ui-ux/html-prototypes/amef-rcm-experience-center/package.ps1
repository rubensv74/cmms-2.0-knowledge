param(
    [string]$OutputPath = ""
)

$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
$Release = Join-Path $Root "releases"
$Stage = Join-Path $env:TEMP "AMEF_RCM_Experience_Center_v2.0"

if ([string]::IsNullOrWhiteSpace($OutputPath)) {
    $OutputPath = Join-Path $Release "AMEF_RCM_Experience_Center_v2.0.zip"
}

Remove-Item $Stage -Recurse -Force -ErrorAction SilentlyContinue
New-Item $Stage -ItemType Directory | Out-Null

@("README.md","manifest.json","index.html","mapa-maestro","prototipos","docs") | ForEach-Object {
    Copy-Item (Join-Path $Root $_) -Destination $Stage -Recurse -Force
}

Get-ChildItem $Stage -Recurse -Filter "index.repo.html" | Remove-Item -Force
New-Item (Split-Path -Parent $OutputPath) -ItemType Directory -Force | Out-Null
Remove-Item $OutputPath -Force -ErrorAction SilentlyContinue
Compress-Archive -Path (Join-Path $Stage "*") -DestinationPath $OutputPath -CompressionLevel Optimal

$Hash = (Get-FileHash $OutputPath -Algorithm SHA256).Hash.ToLowerInvariant()
"$Hash  $(Split-Path -Leaf $OutputPath)" | Set-Content (Join-Path $Release "SHA256SUMS.txt")

Write-Host "Paquete creado: $OutputPath"
Write-Host "SHA256: $Hash"