function Invoke-JiraRestMethod {
    [CmdletBinding()]
    param (
        [string]$UriPath,

        [string]$Method = 'GET',

        [hashtable]$Headers = @{},

        [hashtable]$Body = @{}
    )

    try {

        if (-not [string]::IsNullOrWhiteSpace($global:JIRA_SERVER_URI)) {
            $Uri = $global:JIRA_SERVER_URI
        }
        else {
            throw "Unable to configure Authentication header. You must specify the JIRA SERVER URL by running command '`Set-JiraServerUrl`'"
        }

        if (-not [string]::IsNullOrWhiteSpace($global:JIRA_PAT)) {
            $headers = @{
                'Authorization' = "Bearer $global:JIRA_PAT"
                'Content-Type'  = 'application/json'
            }
        }

        if ($Method -eq 'POST' -or $Method -eq 'PUT') {
            $Body = $Body | ConvertTo-Json
        }

        $fullUri = '{0}/rest/api/2{1}' -f $Uri, $UriPath


        # Make the REST API call
        Write-Verbose "$Method $fullUri"
        Write-Verbose "Headers $($Headers | ConvertTo-Json -Depth 10))"
        Write-Verbose "Body $($body | ConvertTo-Json -Depth 10)"
        $response = Invoke-RestMethod -Uri $fullUri -Method $Method -Headers $Headers -Body $Body

        return $response
    }
    catch {
        throw "Failed to invoke JIRA REST method: $($_.Exception)"
    }
}