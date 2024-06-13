# Introduction
This is a Powershell module for JIRA REST API

# Installation
```powershell
Import-Module /path/to/module/EpiJiraPS.psd1 -Force
```

# Explorer Commands

### Set JIRA server instance
```powershell
Set-JiraServerUrl -Uri <https://yourjisa.example.com>
```

### Authentication
```powershell
Set-JiraAuthCredential -AccessToken <your JIRA Personal Access Token>
```

### Other commands
```powershell
(Get-Module -Name EpiJiraPs).ExportedCommands
```