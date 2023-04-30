# Show resources

This is a PowerShell script to show resources in an Azure subscription. This script has dependency on Azure PowerShell `Az` module.

Open a PowerShell terminal and login to Azure.

```powershell
Connect-AzAccount
```

Set proper Azure subscription.

```powershell
Set-AzContext <subscription id>
```

Navigate to the repository folder and execute the `Run.ps1` script.

```powershell
.\src\Run.ps1
```

This will create a new `resources.json` file in the root of the repository folder. Open the `json` file in any text editor to view the resources.