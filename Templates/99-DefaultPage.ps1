$PageTitle = 'Home'


#Create UDPage Content
$scriptBlock = {
    #Your content here
    New-UDCard -Id 'Home'  -content { 
        New-UDLayout -Columns 2 -Content {
            New-UDParagraph -Text "Hello there!"
            New-UDParagraph -Text "Universal Dashboardi"
            }
        }#End UDCard
    #footer
    New-UDParagraph -Text "This page was generated at $(Get-Date)"
    } #End UDPage ScriptBlock
        
#Create UDPage variable
New-Variable -Name ("UDPage" + $PageTitle -replace '\s') -Value (
    New-UDPage -Name $PageTitle -Content $scriptBlock -DefaultHomePage
    )
