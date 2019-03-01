#For the variables to be available in the endpoints, their names should be passed to 'New-UDDashboard -EndpointInitialization'
#This is a catch-all to automatically get all variables with a name starting with UDEPVar.

$UDSpecialUDEndpointInitialization = New-UDEndpointInitialization -Variable @(
    $(Get-Variable -Name UDEPVar* | select -ExpandProperty Name)
    )

#load EndpointInitModules configuration, if available
#This will load specified modules to the all endpoints

$Config_EndpointInitModules = (Join-Path  (Join-Path $Cache:DashboardRootPath 'Config') 'config_EndpointInitModules.json' )
if (Test-Path $Config_EndpointInitModules -ea 0) {
    try {
        $UDEPVarEndpointInitModules = @( Get-Content $Config_EndpointInitModules | ConvertFrom-Json )
        }
    catch {
        $UDEPVarEndpointInitModules = @()
        }
    }

#load modules listed in EndpointInitModules
#Thanks to https://forums.universaldashboard.io/u/Rob for the working example!
foreach ($thisModule in $UDEPVarEndpointInitModules) {
    try {
        $UDSpecialUDEndpointInitialization.ImportPSModule($thisModule)
        }
    catch {
        Write-UDLog -Message "Failed to import module $thisModule"
        }
    }