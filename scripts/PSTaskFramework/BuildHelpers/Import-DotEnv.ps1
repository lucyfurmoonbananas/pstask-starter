<#
.SYNOPSIS
    Part of the PSTaskFramework.
.NOTES
    SPDX-License-Identifier: Unlicense
    Source: http://github.com/mrfootoyou/pstaskframework
#>
#Requires -Version 7.4

param()

function parseDotEnvLine {
    <#
    .DESCRIPTION
        Parses a single key=value pair from a .env file line.
    #>
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [string] $Line,
        [string[]] $Options = @(),
        [System.Collections.IDictionary] $InterpolationVariables
    )
    process {
        if ($Line -match '^\s*($|#)') { return }
        $name, $value = $Line.Split('=', 2)
        [PSCustomObject]@{ Name = $name.Trim(); Value = $value.Trim() }
    }
}

function Import-DotEnv {
    <#
    .SYNOPSIS
        Load .env files as environment variables or PowerShell variables.
    .DESCRIPTION
        Loads all name-value pairs from one or more .env files.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position = 0)]
        [string[]] $Path,
        [string] $Prototype,
        [string] $CreationAction = 'Stop',
        [switch] $NoClobber,
        [switch] $AsVariables,
        [string[]] $Options = @(),
        [System.Collections.IDictionary] $InterpolationVariables
    )
    foreach ($file in $Path) {
        Get-Content $file | parseDotEnvLine -Options $Options | ForEach-Object {
            if ($AsVariables) { return [PSVariable]::new($_.Name, $_.Value) }
            Set-Item -LiteralPath "env:$($_.Name)" -Value $_.Value -Force:(!$NoClobber)
        }
    }
}
