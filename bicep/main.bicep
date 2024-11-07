targetScope='subscription'

param application string
param sql_server_admin_username string
@secure()
param sql_server_admin_password string
param sql_db_name string
param app_repo_url string

resource rg 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: 'rg-${application}'
  location: 'northeurope'
}

module asp 'modules/webapp/asp.bicep' = {
  scope: rg
  name: 'deploy-asp-${application}'
  params: {
    asp_name: 'asp-${application}'
    asp_sku: 'F1'
    asp_reserved: false // Windows OS required for .NET apps
  }
}

module app 'modules/webapp/app.bicep' = {
  scope: rg
  name: 'deploy-app-${application}'
  params: {
    app_name: 'app-${application}'
    app_service_plan_id: asp.outputs.id
    app_runtime_stack: 'dotnet'
    app_runtime_version: 'ASP.NET V4.8'
    app_repo_url: app_repo_url
  }
}

module sql_server 'modules/sql/server.bicep' = {
  scope: rg
  name: 'deploy-sql-${application}'
  params: {
    sql_server_admin_password: sql_server_admin_password
    sql_server_admin_username: sql_server_admin_username
    sql_server_name: 'sql-${application}'
  }
}

module sql_db 'modules/sql/database.bicep' = {
  scope: rg
  name: 'deploy-sql-db-${application}'
  params: {
    sql_db_name: sql_db_name
    sql_server_name: sql_server.outputs.name
  }
}
