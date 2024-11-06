using 'main.bicep'

param application = '' // will be overriden from workflow parameters
param sql_server_admin_username = '' // will be overriden from workflow parameters
@secure()
param sql_server_admin_password = '' // will be overriden from workflow parameters
param sql_db_name = 'chinook'
