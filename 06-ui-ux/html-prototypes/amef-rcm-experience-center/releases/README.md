# Releases

Esta carpeta recibe el paquete generado para distribución.

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

`releases/AMEF_RCM_Experience_Center_v1.0.zip`

Al descomprimirlo, el punto único de entrada es el archivo `index.html` de la raíz. El ZIP generado no se mantiene como fuente primaria: debe poder reproducirse desde los HTML y documentos versionados.
