## CI/CD Automation for Deploying an App on Azure
This repository automates the [Bicep deployment](https://github.com/MaryKroustali/app_on_azure_iac) of the [Record Store Application](https://github.com/MaryKroustali/record_store_app) on Azure using GitHub Actions. Workflows located at [.github/workflows/](.github/workflows/):
  - [Deploy Infrastructure](.github/workflows/deploy_infra.yaml): Provisions the required infrastructure on Azure, including compute and database resources.
  - [Import Data to Database](.github/workflows/import_db_data.yaml): Automates the setup of Azure SQL Database with predefined data from a `.sql` file.
  - [Deploy Application Code](.github/workflows/deploy_app_code.yaml): Configures the Azure Web App with the application’s code to enable deployment.

### Authentication to Azure
To enable authentication from GitHub to Azure, set up Open ID connect as described in [Azure Login with OpenID Connect](https://learn.microsoft.com/en-us/azure/developer/github/connect-from-azure-openid-connect#prerequisites). The following repository secrets should be configured under **Repository Settings > Secrets and Variables > Actions > New Repository Secret**:
- `AZURE_CLIENT_ID`: Client ID for Azure authentication.
- `AZURE_TENANT_ID`: Tenant ID for the Azure subscription.
- `AZURE_SUBSCRIPTION_ID`: Subscription ID for Azure.

Additionally, the following secrets for Azure SQL Server authentication should be set:
- `SQL_SERVER_ADMIN_PASSWORD`: Admin username for Azure SQL Server.
- `SQL_SERVER_ADMIN_USERNAME`: Admin password for Azure SQL Server.

In workflows, these secrets are referenced using `${{ secrets.secret_name }}`.

## Next Steps
[private_app_on_azure](private_app_on_azure): Deploying the Record Store application on Azure with private connectivity.
