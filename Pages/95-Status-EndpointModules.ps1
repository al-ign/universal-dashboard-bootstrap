$PageTitle = 'Status Endpoint Modules'


#Create UDPage Content
$scriptBlock = {
    #Your content here
    
    $arrProp = @('Name','Path')

    New-UDTable -Title $PageTitle `
            -Headers $arrProp `
            -ArgumentList @($arrProp) `
            -Endpoint {
                $arrProp = $ArgumentList
                  @( Get-Module -ListAvailable ) | Out-UDTableData -Property $arrProp
                }
    
    #footer
    New-UDParagraph -Text "This page was generated at $(Get-Date)"
    } #End UDPage ScriptBlock
        
#Create UDPage variable
New-Variable -Name ("UDPage" + $PageTitle -replace '\s') -Value (
    New-UDPage -Name $PageTitle -Content $scriptBlock
    )
