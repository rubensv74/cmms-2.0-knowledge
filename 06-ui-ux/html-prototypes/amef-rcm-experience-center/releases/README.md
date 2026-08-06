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
- SHA256: `5d552c8236a99c9ce7df9ee34fb3a858a77c9148c11281d04d31c89145b4c6ce`

El paquete excluye la carpeta `releases` y los archivos auxiliares `index.repo.html`, por lo que no contiene ZIP anidados ni fuentes intermedias.