# CMMS 2.0 — Component Catalog V1

**Estado:** `ACTIVE / PRE-STUDIO FOUNDATION`.

## Regla

`REUSE_CMMS → ADAPT_VERIFIED_BASE → EXTEND_SHARED → CREATE_SHARED → LOCAL_ONLY`.

No existe todavía una biblioteca CMMS Studio-validada completa. Por tanto este catálogo distingue necesidad prevista de componente y evidencia real; no convierte referencias externas en componentes CMMS validados.

## Lifecycle

- `VALIDATED_CMMS`: probado en la app CMMS real.
- `CMMS_RC`: candidato implementado, gate pendiente.
- `ADAPTATION_CANDIDATE`: debe adaptarse desde una referencia funcional verificada.
- `REFERENCE_ONLY`: patrón útil, no copiar automáticamente.
- `TO_VALIDATE`: necesidad/contrato conocido pero implementación real pendiente.
- `LEGACY`: no usar para trabajo nuevo salvo migración.

## Foundation prevista

| Capacidad | Estado | Baseline / regla |
|---|---|---|
| Sidebar / Navigation | ADAPTATION_CANDIDATE | evaluar primero AssetPlan/PULSE validados |
| Project/Case Context | ADAPTATION_CANDIDATE | separar contexto global/caso de negocio |
| Page Header | ADAPTATION_CANDIDATE | evaluar `cmp_PageHeaderPro` PULSE y equivalentes; adaptar al contrato CMMS |
| State Surface | ADAPTATION_CANDIDATE | EMPTY/ERROR/BLOCKED/WARNING explícitos |
| Skeleton Loader | ADAPTATION_CANDIDATE | loading localizado, no overlay global por defecto |
| KPI Card | REFERENCE_ONLY | introducir con primer consumer real |
| Data Grid | REFERENCE_ONLY | introducir con Data Explorer real |
| Action Toolbar | REFERENCE_ONLY | introducir con Operational Workbench real |
| Risk Matrix | TO_VALIDATE | debe renderizar perfil configurable, no 5x5 hardcodeado |
| RCM Decision Flow | TO_VALIDATE | explicación/evidencia/branch; sin scoring no aprobado |
| Audit Timeline | TO_VALIDATE | introducir cuando exista consumidor de trazabilidad |

## Reglas de creación/adaptación

Todo componente compartido debe documentar: source repository/path/SHA cuando se adapte; comportamiento conservado; delta CMMS; inputs/outputs/events; estados; dependencias; accesibilidad; tokens; test y estado de Studio.

No marcar `VALIDATED_CMMS` por existencia en GitHub. La validación requiere herramienta real.
