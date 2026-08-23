# Power Apps — Code Delivery Standard

**Status:** active / mandatory
**Date:** 2026-08-23

## Rule

Every Power Apps implementation increment must be delivered with direct-open, copy-ready code files in the repository.

The user must not be required to extract formulas manually from explanatory prose.

## Required delivery format

For every increment such as `SHELL-C01`, provide:

1. one or more code files under a stable `code/` folder;
2. a `.pa.yaml` screen file whenever the increment creates or replaces a screen;
3. formulas grouped by execution target (`App.OnStart`, collections, navigation, control formulas, etc.) when they live outside the screen YAML or are useful independently;
4. direct raw links to open/copy every required file;
5. a short indication of the paste/import target;
6. screen YAML written in the validated Power Apps Source Code dialect used by the project.

## Validated screen-source dialect

The CMMS 2.0 screen YAML baseline is aligned with the source-code dialect already proven in `rubensv74/app_pulse`, including:

```text
Screens:
  scr_Name:
    Properties:
    Children:
      - controlName:
          Control: GroupContainer@1.5.0
          Variant: AutoLayout
          Properties:
          Children:
```

Controls/versions still require Studio validation in CMMS 2.0, but absence of a fully exported CMMS app is no longer a reason to omit the screen YAML.

## Naming

```text
<INCREMENT>-scr_<ScreenName>.pa.yaml
<INCREMENT>-App-OnStart.powerfx
<INCREMENT>-Collections.powerfx
<INCREMENT>-Navigation.powerfx
<INCREMENT>-Control-Properties.powerfx
<INCREMENT>-<specific-purpose>.powerfx
```

Only create files actually required by the increment.

## Acceptance

An increment that creates/replaces a screen is not considered delivered unless:

- its `.pa.yaml` is present;
- required app-level Power Fx is present;
- direct-open/copy links are supplied;
- the user does not need to reconstruct the screen manually from prose.
