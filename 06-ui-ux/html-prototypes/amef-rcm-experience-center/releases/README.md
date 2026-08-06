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
releases/AMEF_RCM_Experience_Center_v2.1.zip
releases/SHA256SUMS.txt
```

Durante el empaquetado se incorporan a los cinco prototipos los recursos compartidos de las guías prácticas del flujo de negocio. Al descomprimirlo, el punto único de entrada es `index.html` en la raíz.

## Entrega validada

- Versión: 2.1.0-conceptual
- Archivos: 21
- SHA256: `e69d166ad22ed72ff2f3cf4862ef3dccdd790eeeada9d9ba4bac5c4d0b04107a`

El checksum se mantiene fuera del ZIP para evitar una referencia circular. El distribuible excluye la carpeta `releases`, los archivos auxiliares `index.repo.html` y las herramientas de construcción.
