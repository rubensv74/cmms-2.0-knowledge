param(
    [string]$OutputPath = ""
)

$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
$Release = Join-Path $Root "releases"
$Stage = Join-Path $env:TEMP "AMEF_RCM_Experience_Center_v2.1"

if ([string]::IsNullOrWhiteSpace($OutputPath)) {
    $OutputPath = Join-Path $Release "AMEF_RCM_Experience_Center_v2.1.zip"
}

Remove-Item $Stage -Recurse -Force -ErrorAction SilentlyContinue
New-Item $Stage -ItemType Directory | Out-Null

@("README.md","manifest.json","index.html","mapa-maestro","prototipos","docs","assets") | ForEach-Object {
    Copy-Item (Join-Path $Root $_) -Destination $Stage -Recurse -Force
}

Get-ChildItem $Stage -Recurse -Filter "index.repo.html" | Remove-Item -Force

$Guides = [ordered]@{
    "01-comprender-problema" = "01"
    "02-evaluar-riesgo" = "02"
    "03-decision-rcm" = "03"
    "04-convertir-en-plan" = "04"
    "05-gobernar-mejorar" = "05"
}

foreach ($Entry in $Guides.GetEnumerator()) {
    $Path = Join-Path $Stage ("prototipos/{0}/index.html" -f $Entry.Key)
    $Html = Get-Content $Path -Raw -Encoding UTF8
    $Html = [regex]::Replace($Html, '<link[^>]+business-flow-guide\.css[^>]*>\s*', '')
    $Html = [regex]::Replace($Html, '<script[^>]+business-flow-guide\.js[^>]*></script>\s*', '')
    $Html = $Html.Replace('</head>', '<link rel="stylesheet" href="../../assets/business-flow-guide.css">' + "`n</head>")
    $Script = '<script src="../../assets/business-flow-guide.js" data-business-guide="{0}"></script>' -f $Entry.Value
    $Html = $Html.Replace('</body>', $Script + "`n</body>")
    Set-Content $Path -Value $Html -Encoding UTF8 -NoNewline
}

New-Item (Split-Path -Parent $OutputPath) -ItemType Directory -Force | Out-Null
Remove-Item $OutputPath -Force -ErrorAction SilentlyContinue
Compress-Archive -Path (Join-Path $Stage "*") -DestinationPath $OutputPath -CompressionLevel Optimal

$Hash = (Get-FileHash $OutputPath -Algorithm SHA256).Hash.ToLowerInvariant()
"$Hash  $(Split-Path -Leaf $OutputPath)" | Set-Content (Join-Path $Release "SHA256SUMS.txt")

Write-Host "Paquete creado: $OutputPath"
Write-Host "SHA256: $Hash"
