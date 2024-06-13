function Get-JiraIssue {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string] $Key,

        [Parameter(Mandatory = $true)]
        [string] $ProjectKey
    )

    begin {}
    process {
        Write-Verbose "Getting JIRA issue by key $Key in project $ProjectKey"
    }

    end {}
}