#Import-Module C:\shares\www\dashboard\UniversalDashboard.Community.psd1
cd $PSScriptRoot

#Enable-UDLogging -Console

#Cleanup Variables:
Get-Variable -Name UDEndPoint* | Remove-Variable
Get-Variable -Name UDPage* | Remove-Variable
$global:DefaultVIServer = $null
$global:DefaultVIServers = $null

#Stop running dashboard
Get-UDDashboard | % {
    Write-Host "Stopping running dashboard"
    $_ | Stop-UDDashboard
    }

#init Splat for dashboard start
$splatUDDashboardStart = @{}
$splatUDDashboardNew = @{}

#declare dashboard path, because we can't rely on the $PWD
$cache:DashboardRootPath = $PSScriptRoot

#load pages
Get-ChildItem (Join-Path $cache:DashboardRootPath 'Pages') -Recurse -Filter *.ps1 | Sort-Object Name | % {
    Write-Host "Loading UD page: $($_.FullName)"
    . $_.FullName
    }

#get all endpoints
$UDListEndPoints  = @( Get-Variable -Name UDEndPoint* -ValueOnly )

if ($UDListEndPoints) {
    write-host Listing UDListEndPoints $UDListEndPoints.Count
    $UDListEndPoints | select Name, Method | ft
    #Add to splat list
    $splatUDDashboardStart += @{EndPoint = $UDListEndPoints}
    }

#get all pages
$UDListPages = @( Get-Variable -Name UDPage* -ValueOnly | Sort-Object Name)

if ($UDListPages) {
    write-host Listing dashBoardPages $UDListPages.Count
    $UDListPages | Select-Object Name, Url, @{N='ComponentsCount';E={($_.Components).Count}}, Type | ft
    #Add to splat list
    $splatUDDashboardNew += @{Pages = $UDListPages}
    #for the status page
    $Cache:UDListPages = $UDListPages
    }

#add to splat if defined
#Consult 90-PostInit.ps1
if ($UDSpecialUDEndpointInitialization) {
    $splatUDDashboardNew += @{EndpointInitialization=$UDSpecialUDEndpointInitialization}
    }

#create dashboard
$UDDashBoard = New-UDDashboard -Title 'DashBoard' @splatUDDashboardNew

$splatUDDashboardStart += @{Dashboard=$UDDashBoard}

if ($psISE) {
        $UDDashboardPort = 10010
        Write-Host "Running in detached mode on port $UDDashboardPort"
        Start-UDDashboard -Port $UDDashboardPort @splatUDDashboardStart 
        }
    else {
        $UDDashboardPort = 10000
        Write-UDLog "Running in attached mode on port $UDDashboardPort"
        Start-UDDashboard -Port $UDDashboardPort @splatUDDashboardStart -Wait
        #Get-UDDashboard | Stop-UDDashboard
        }
