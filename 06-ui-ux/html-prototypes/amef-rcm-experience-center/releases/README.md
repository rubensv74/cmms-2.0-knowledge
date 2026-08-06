# Releases

Esta carpeta recibe el paquete reproducible de distribución. El ZIP binario no se mantiene como fuente primaria dentro del repositorio.

## Windows

Desde PowerShell, situado en la carpeta `amef-rcm-experience-center`:

```powershell
.\package.ps1
```

## Linux o macOS

```bash
chmod +x package.sh
./package.sh
```

Ambos scripts generan:

```text
releases/AMEF_RCM_Experience_Center_v2.0.zip
releases/SHA256SUMS.txt
```

Al descomprimirlo, el punto único de entrada es `index.html` en la raíz.

## Entrega validada

- Versión: 2.0.0-conceptual
- Archivos: 26
- SHA256: `04fe654f20f5289f5aee4afcf77a34f9ba4172f66d42a1a319085d3a34aaab7b`

El checksum se mantiene fuera del ZIP para que el paquete pueda reproducirse exactamente desde las fuentes versionadas. El distribuible excluye la carpeta `releases` y los archivos auxiliares `index.repo.html`.