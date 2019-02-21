$EndPointName = 'EndPointMeaningfulName'

#Create Endpoint scriptblock
$scriptBlock = {
    #Endpoint Code

    }

#Create EndPoint variable
New-Variable -Name ("UDEndPoint" + $EndPointName -replace '\s') -Value (
    New-UDEndpoint -Id $EndPointName -Schedule $udSchedule30min -Endpoint $scriptBlock
    )
