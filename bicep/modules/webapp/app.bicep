@description('Resource Name.')
param app_name string

@description('Resource Location.')
param app_location string = resourceGroup().location

@description('Resource ID of the associated App Service plan.')
param app_service_plan_id string

@description('Name of branch to use for deployment.)
param app_branch string = 'main'

@description('Runtime stack is used to determine the workflow file content for code base apps.)
param app_runtime_stack string

@description('Runtime version is used to determine what build version to set in the workflow file.)
param app_runtime_version string

@description('Repository or source control URL.')
param app_repo_url string

resource app_service 'Microsoft.Web/sites@2023-12-01' = {
  name: app_name
  location: app_location
  properties: {
    serverFarmId: app_service_plan_id
  }
}

resource symbolicname 'Microsoft.Web/sites/sourcecontrols@2024-04-01' = {
  name: 'web'
  parent: app_service
  properties: {
    branch: app_branch
    gitHubActionConfiguration: {
      codeConfiguration: {
        runtimeStack: app_runtime_stack
        runtimeVersion: app_runtime_version
      }
      generateWorkflowFile: false
      isLinux: false
    }
    isGitHubAction: true
    repoUrl: app_repo_url
  }
}

output domain string = app_service.properties.defaultHostName
