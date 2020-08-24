Param(
  [string]$ManifestPath = "$PSScriptRoot\PSSimpleLogging\PSSimpleLogging.psd1",
  [Parameter(Mandatory=$true)]
  [string]$NuGetApiKey,
  [string]$ReleaseNotes = "No longer using aliases for Sort-Object, Where-Object, or Select-Object",
  [int]$Major = 1,
  [int]$Minor = 0
)

[datetime]$Now = Get-Date
[int]$Revision = (New-TimeSpan –Start "01/01/2000 00:00" –End $Now).Days
[int]$Patch = [math]::Round((New-TimeSpan –Start $Now.Date –End $Now).TotalSeconds/2)
[version]$ModuleVersion = "{0}.{1}.{2}.{3}" -f $Major,$Minor,$Revision,$Patch

Write-Host ("Date: {0}" -f $Now)
Write-Host ("ManifestPath: {0}" -f $ManifestPath)
Write-Host ("ModuleVersion: {0}" -f $ModuleVersion)

Update-ModuleManifest $ManifestPath -ModuleVersion $ModuleVersion -ReleaseNotes $ReleaseNotes

Publish-Module -Name $ManifestPath -NuGetApiKey $NuGetApiKey
