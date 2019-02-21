$PageTitle = 'Example Dynamic Page Process List'


#Create UDPage Endpoint
$scriptBlock = {
    #Your content here
    $arrProp = 'Id ProcessName VirtualMemorySize64 Path' -split ' '

    New-UDGrid -Title $PageTitle -Headers $arrProp -Properties $arrProp -ArgumentList $arrProp -Endpoint  {
        $arrProp = $ArgumentList
        $process = Get-Process 
        $process | Select-Object $arrProp | % {$_.Id =  (New-UDLink -Text $_.Id -Url ('ExampleDynamicPageProcessDetail/' + $_.Id)); $_ } | Out-UDGridData
        } #End UDGrid

    #footer
    New-UDParagraph -Text "This page was generated at $(Get-Date)"
    } #End UDPage ScriptBlock


#Create proper URL
$PageUrl = '/{0}' -f $PageTitle -replace '\s'

#Create UDPage variable
New-Variable -Name ("UDPage" + $PageTitle -replace '\s') -Value (
    New-UDPage -Url $PageUrl -Endpoint $scriptBlock
    )
