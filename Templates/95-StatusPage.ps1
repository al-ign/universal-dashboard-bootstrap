$PageTitle = 'Status Page for'


#Create UDPage Content
$scriptBlock = {
    #Your content here

        #Define an array of property names for UDGrid/UDTable
        $arrProp = @('Name','Value')



        <#
        New-UDGrid -Title $PageTitle -Headers $arrProp -Properties $arrProp -Endpoint  {
                Get-Variable | Select-Object Name,@{N='Value';E={[string]$_.Value}} | Out-UDGridData
            } #End UDGrid
        #>


        <#
        New-UDTable -Title $PageTitle `
                -Headers $arrProp `
                -ArgumentList @($arrProp) `
                -Endpoint {
                    $arrProp = $ArgumentList
                    Get-Variable | Select-Object Name,@{N='Value';E={[string]$_.Value}} |  Out-UDTableData -Property $arrProp
                    }
        #>
        
    #footer
    New-UDParagraph -Text "This page was generated at $(Get-Date)"
    } #End UDPage ScriptBlock
        
#Create UDPage variable
New-Variable -Name ("UDPage" + $PageTitle -replace '\s') -Value (
    New-UDPage -Name $PageTitle -Content $scriptBlock
    )
