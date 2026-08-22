# Power Apps — Code Delivery Standard

**Status:** active / mandatory
**Date:** 2026-08-22

## Rule

Every Power Apps implementation increment must be delivered with direct-open, copy-ready code files in the repository.

The user must not be required to extract formulas manually from explanatory prose.

## Required delivery format

For every increment such as `SHELL-C01`, provide:

1. one or more code files under a stable `code/` folder;
2. formulas grouped by execution target (`App.OnStart`, screen/control properties, collections, navigation, etc.);
3. direct links to open each code file;
4. short indication of where each file must be pasted/applied;
5. no generated YAML until the real Power Apps source schema/dialect has been validated.

## Naming

```text
<INCREMENT>-App-OnStart.powerfx
<INCREMENT>-Control-Properties.powerfx
<INCREMENT>-Collections.powerfx
<INCREMENT>-Navigation.powerfx
<INCREMENT>-<specific-purpose>.powerfx
```

Only create files that are actually required by the increment.

## Acceptance

An increment is not considered delivered if the implementation code exists only inside chat prose or documentation and has no direct-copy repository file.
