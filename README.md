# PSTaskFramework Starter

Starter kit for [PSTaskFramework](https://github.com/mrfootoyou/PSTaskFramework): a PowerShell task runner with `build.ps1` and the vendored `scripts/PSTaskFramework` module.

## Requirements

- PowerShell 7.4+

## Quick start

```powershell
./build.ps1 list
```

That lists available tasks. Run a task with `./build.ps1 <task-name>`.

## Contents

- `build.ps1` — entrypoint / task runner
- `scripts/PSTaskFramework/` — framework modules and helpers

Sourced from https://github.com/mrfootoyou/PSTaskFramework.
