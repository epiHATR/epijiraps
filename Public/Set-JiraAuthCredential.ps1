function Set-JiraAuthCredential {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string] $AccessToken,

        [Parameter(Mandatory = $false)]
        [string] $Uri = ""
    )

    begin {}
    process {
        if (-not [string]::IsNullOrWhiteSpace($Uri)) {
            $null = Set-JiraServerUrl $Uri
        }

        if ([string]::IsNullOrWhiteSpace($global:JIRA_SERVER_URI)) {
            throw "Unable to configure Authentication header. You must specify the JIRA SERVER URL by running command '`Set-JiraServerUrl`'"
        }
        try {
            Write-Verbose 'Verifying Personal Access Token ...'
            $global:JIRA_PAT = $AccessToken        
            $null = Invoke-JiraRestMethod -Method GET -UriPath '/myself' -Headers @{ 'Content-Type' = 'application/json' }
        }
        catch {
            Write-Verbose "UnAuthorized"
            throw "Unable to login using Personal Access Token. Error $($_.Exception)"
        }
        Write-Verbose "Authorized Successfully"
    }

    end {}
}