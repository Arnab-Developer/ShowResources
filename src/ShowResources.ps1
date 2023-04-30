using namespace System.Collections.Generic

param([string] $ResourceGroupName)

class CustomGroup {
    [string] $ResourceGroupName
    [string] $Location
    [IEnumerable[CustomResource]] $Resources

    CustomGroup([string] $resourceGroupName, [string] $location) {
        $this.ResourceGroupName = $resourceGroupName
        $this.Location = $location
        $this.Resources = [List[CustomResource]]::new()
    }
}

class CustomResource {
    [string] $Name
    [string] $Location
    [string] $Type

    CustomResource([string] $name, [string] $location, [string] $type) {
        $this.Name = $name
        $this.Location = $location
        $this.Type = $type
    }
}

function Get-CustomGroups {
    $resourceGroups = [string]::IsNullOrWhiteSpace($ResourceGroupName) ? `
    (Get-AzResourceGroup) : (Get-AzResourceGroup -ResourceGroupName $ResourceGroupName)
    
    $customGroups = [List[CustomGroup]]::new()
    
    foreach ($resourceGroup in $resourceGroups) {
        $customGroup = [CustomGroup]::new($resourceGroup.ResourceGroupName, $resourceGroup.Location)
        $customGroups.Add($customGroup)
    
        $resources = Get-AzResource -ResourceGroupName $resourceGroup.ResourceGroupName
    
        if ($null -eq $resources) { continue }
    
        foreach ($resource in $resources) {
            $customResource = [CustomResource]::new($resource.Name, $resource.Location, $resource.Type)
            $customGroup.Resources.Add($customResource)
        }
    }

    return $customGroups
}

$customGroups = Get-CustomGroups
return $customGroups