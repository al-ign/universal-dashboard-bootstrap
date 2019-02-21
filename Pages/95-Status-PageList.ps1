$PageTitle = 'Status Page List'


#Create UDPage Content
$scriptBlock = {
        #Your content here

        $arrProp = 'Name', 'Url', 'Dynamic', 'View'
        $tableEndpoint = {
            $arrProp = $ArgumentList
            $Cache:UDListPages | % {
                $thisPage = $_
                if ($thisPage.dynamic) {
                    $thisPage | select Name, Url,
                    @{N='Dynamic';E={[string]$_.Dynamic}},
                    @{N='View';E={New-UDLink -Text "Go to" -Url ('..' + $_.Url)}} 
                    }
                else {
                    $thisPage | select Name, Url, 
                    @{N='Dynamic';E={[string]$_.Dynamic}},
                    @{N='View';E={New-UDLink -Text "Go to" -Url ('../' + ($_.Name -replace ' ','-') )}} 
                    }
                } |  Out-UDTableData -Property $arrProp
            }

        New-UDTable -Title $PageTitle `
                -Headers $arrProp `
                -ArgumentList @($arrProp) `
                -Endpoint $tableEndpoint
        #footer
        New-UDParagraph -Text "This page was generated at $(Get-Date)"
        } #End UDPage ScriptBlock

#Create UDPage variable
New-Variable -Name ("UDPage" + $PageTitle -replace '\s') -Value (
    New-UDPage -Name $PageTitle -Content $scriptBlock
    )
