param (
    [string]$username, 
    [string]$targetsrv,
    [string]$keyVaultName,
    [string]$managedIdentity
)

#Query Azure Key Vault for SQL Admin password
$response = Invoke-WebRequest -Uri 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https%3A%2F%2Fvault.usgovcloudapi.net' -UseBasicParsing -Method GET -Headers @{Metadata="true"}
$content = $response.Content | ConvertFrom-Json
$KeyVaultToken = $content.access_token
$akv_Content = (Invoke-WebRequest -Uri 'https://' + $keyVaultName + '.vault.usgovcloudapi.net/secrets/AzDevOps2019SqlPass?api-version=2016-10-01' -UseBasicParsing -Method GET -Headers @{Authorization="Bearer $KeyVaultToken"}).content
$value = ($akv_Content | ConvertFrom-JSON).value
$Password = $value

$targetsrvfull = $targetsrv + ".database.usgovcloudapi.net"

#Create query strings to update databases
$masterUpdate = "CREATE USER " + $managedIdentity + " FROM EXTERNAL PROVIDER;ALTER ROLE [dbmanager] ADD MEMBER " + $managedIdentity +";"
$dbUpdate = "CREATE USER " + $managedIdentity + " FROM EXTERNAL PROVIDER;ALTER ROLE [db_owner] ADD MEMBER " + $managedIdentity + ";ALTER USER " + $managedIdentity + " WITH DEFAULT_SCHEMA=dbo;"


#Update Master database
sqlcmd -S $targetsrvfull -d master -Q $masterUpdate -G -U $username -P $Password -l 30

#Update default configuration database
sqlcmd -S $targetsrvfull -d AzureDevOps_Configuration -Q $dbUpdate -G -U $username -P $Password -l 30

#Update default collection database
sqlcmd -S $targetsrvfull -d AzureDevOps_DefaultCollection -Q $dbUpdate -G -U $username -P $Password -l 30