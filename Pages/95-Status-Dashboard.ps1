$PageTitle = 'Status Dashboard'


#Create UDPage Content
$scriptBlock = {
    #Your content here
    New-UDCard -Id 'StatusInfo1'  -content { 
        New-UDLayout -Columns 2 -Content {
            New-UDButton -Text "Test toast" -OnClick {
                Show-UDToast -Message ('Toast message!') 
                }

            New-UDButton -Text "Stop-UDDashboard" -Icon recycle -OnClick {
                Get-UDDashboard | Stop-UDDashboard
                }

            if ($cache:DashboardRootPath) {
                New-UDParagraph -Content {
                    '$cache:DashboardRootPath is ' + $cache:DashboardRootPath
                    }
                }

            New-UDParagraph -Text "Process is running under $($env:USERNAME) with PID $($PID)"

            }
        }#End UDCard

    $arrProp = @('Name','Port','Running')
    New-UDTable -Title $PageTitle `
            -Headers $arrProp `
            -ArgumentList @($arrProp) `
            -Endpoint {
                $arrProp = $ArgumentList
                Get-UDDashboard  | Select-Object Name, Port, @{N='Running';E={[string]$_.Running}} | Out-UDTableData -Property $arrProp
                }
    
    #footer
    New-UDParagraph -Text "This page was generated at $(Get-Date)"
    } #End UDPage ScriptBlock
        
#Create UDPage variable
New-Variable -Name ("UDPage" + $PageTitle -replace '\s') -Value (
    New-UDPage -Name $PageTitle -Content $scriptBlock
    )
