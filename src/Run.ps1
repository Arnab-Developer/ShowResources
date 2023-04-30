param([string] $ResourceGroupName)

&"$PSScriptroot\ShowResources.ps1" -ResourceGroupName $ResourceGroupName | ConvertTo-Json -Depth 3 > resources.json