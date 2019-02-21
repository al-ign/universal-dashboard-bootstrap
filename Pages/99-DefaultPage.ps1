$PageTitle = 'Home'


#Create UDPage Content
$scriptBlock = {
    #Your content here
    New-UDCard -Id 'Home'  -content { 
        New-UDLayout -Columns 2 -Content {
            New-UDParagraph -Text "Hello there!"
            New-UDParagraph -Text "Universal Dashboardi"
            

            if ((Get-Variable UDPageStatusPageList -ValueOnly).Name -eq 'Status Page List') {
                New-UDParagraph -Content {
                    New-UDLink -Text 'List of all pages available in this dashboard' -Url 'Status-Page-List'
                    }
                }

            if ((Get-Variable UDPageExampleDynamicPageProcessList -ValueOnly).url -eq '/ExampleDynamicPageProcessList') {
                New-UDParagraph -Content {
                    New-UDLink -Text 'Check this dynamic page - a process list!' -Url 'ExampleDynamicPageProcessList'
                    }
                }

            }#End UDLayout
        }#End UDCard
    #footer
    New-UDParagraph -Text "This page was generated at $(Get-Date)"
    } #End UDPage ScriptBlock
        
#Create UDPage variable
New-Variable -Name ("UDPage" + $PageTitle -replace '\s') -Value (
    New-UDPage -Name $PageTitle -Content $scriptBlock -DefaultHomePage
    )
