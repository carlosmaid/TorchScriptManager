﻿param (
    [Parameter(Mandatory=$true)][string]$mode
 )

if ( "$mode" -eq "Release" )
{
    $zipPath = Join-Path (pwd) "ScriptManager.zip"
}
else
{
    $zipPath = Join-Path (pwd) "$mode.zip"
}
$binPath = Join-Path (pwd) "bin\x64\$mode\"

if (Test-Path $binPath)
{
    if (Test-Path $zipPath)
    {
        Write-Host "Deleting existing archive at $zipPath"
        Remove-Item $zipPath
    }
    Add-Type -Assembly System.IO.Compression.FileSystem
    [System.IO.Compression.ZipFile]::CreateFromDirectory($binPath, $zipPath)
    Write-Host "Plugin archived at $zipPath"
}
else
{
    Write-Host "Folder $binPath doesn't exist, skipping archive"
}