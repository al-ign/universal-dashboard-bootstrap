$PageTitle = 'Dynamic Page with Parameter'
$PageParameter = 'PageParameter'

#Create UDPage Endpoint
$scriptBlock = {
    param ($PageParameter)
    #Your content here
    if ($PageParameter) {
        New-UDParagraph -Text ('PageParameter is: ' + $PageParameter + ' END')
        }
    else {
        New-UDParagraph -Text ('PageParameter was empty')
        }
        
    #footer
    New-UDParagraph -Text "This page was generated at $(Get-Date)"
    } #End UDPage ScriptBlock

#Create proper URL depending on PageParameter
if ($PageParameter.Length -gt 0) {
    $PageUrl = '/{0}/:{1}' -f $PageTitle, $PageParameter -replace '\s'
    }
else {
    $PageUrl = '/{0}' -f $PageTitle -replace '\s'
    }

#Create UDPage variable
New-Variable -Name ("UDPage" + $PageTitle -replace '\s') -Value (
    New-UDPage -Url $PageUrl -Endpoint $scriptBlock
    )
