function Set-JiraServerUrl {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string] $Uri
    )

    begin {}
    process {
        try {

            if ($Uri -match '^http://') {
                $Uri = $Uri -replace '^http://', 'https://'
            }
            elseif (-not ($Uri -match '^(http://|https://)')) {
                $Uri = "https://$Uri"
            }

            $null = Invoke-WebRequest -Uri $Uri -Method Get
            Write-Verbose "Configure global variables for JIRA server uri at '`$global:JIRA_SERVER_URI`'"
            $global:JIRA_SERVER_URI = $Uri
            return [PSCustomObject]@{
                Uri = $global:JIRA_SERVER_URI
            }
        }
        catch {
            throw "Unable to configure JIRA server uri. The error $($_.Exception)"
        }
    }

    end {}
}