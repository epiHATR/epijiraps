function Get-JiraProject {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string] $ProjectKey
    )

    begin {}
    process {
        if ([string]::IsNullOrWhiteSpace(($ProjectKey))) {
            Write-Verbose "Getting all project in the JIRA instance"
            $uriEnding = "/project"
        }
        else {
            Write-Verbose "Getting project by key $ProjectKey in the JIRA instance"
            $uriEnding = "/project/${ProjectKey}"
        }

        try {
            $projects = Invoke-JiraRestMethod -UriPath $uriEnding -Headers @{ 'Content-Type' = 'application/json' }
            return $projects
        }
        catch {
            throw $_.Exception
        }
    }

    end {}
}