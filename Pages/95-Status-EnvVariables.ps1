$PageTitle = 'Status Env Variables'


#Create UDPage Content
$scriptBlock = {
    #Your content here

    $arrProp = @('Name','Value')

    New-UDTable -Title $PageTitle `
            -Headers $arrProp `
            -ArgumentList @($arrProp) `
            -Endpoint {
                $arrProp = $ArgumentList
                gci Env: | Select-Object Name,@{N='Value';E={[string]$_.Value}} |  Out-UDTableData -Property $arrProp
                }
    #footer
    New-UDParagraph -Text "This page was generated at $(Get-Date)"
    } #End UDPage ScriptBlock
        
#Create UDPage variable
New-Variable -Name ("UDPage" + $PageTitle -replace '\s') -Value (
    New-UDPage -Name $PageTitle -Content $scriptBlock
    )
