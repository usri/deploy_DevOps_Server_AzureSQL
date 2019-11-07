# Deploy Azure DevOps Server
## Deploys Azure DevOps Server 2019 using Azure SQL Databases
## Quick Start

<a href="https://portal.azure.us/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fusri%2Fdeploy_DevOps_Server_AzureSQL%2Fmaster%2Fazuredeploy.json" target="_blank"><img src="http://azuredeploy.net/AzureGov.png"/></a>

## Details
This template assumes that you are a US regulated entity with typical requirements for role seperation and security controls.  This template assumes you will be deploying into a pre-existing environment.  For deployment to be successful, please ensure the following pre-requisites:

* A virtual network exists and has VNET Service Endpoints enabled for Azure SQL & Azure Storage
* An Azure Key Vault exists and a corresponding secret also exists which contains the password of the Azure AD SQL Admin account defined in the template.
 * A user-assigned Azure Managed Identity has been created to serve as the identity of the Azure virtual machine that is deployed as part of this template.
* An Active Directory domain is avalaible for computer join operations and is accessible from within the specified virtual network.
 * As part of the template deployment, you must provide Active Directory domain information to enable the Azure DevOps Server to join your Active Directory domain.
* To automatically deploy all the required infrastructure, utilize our <a href="https://github.com/Microsoft/aad-hybrid-lab" target="_blank">AAD Hybrid Deployment template</a>.  NOTE:  You do not need to configure Azure AD Connect piece of the hybrid deployment template. 
 * After deploying the hybrid infrastructure, please enable VNET Service Endpoings on the resulting VNET - Azure SQL & Azure Storage

This template deploys the following infrastructure:

* Azure SQL Server
 * Azure SQL Database - DevOps Configuration
 * Azure SQL Database - DevOps Default Collection
* Azure VM - Azure DevOps Server 2019
 * Utilizes Azure Managed Identities to connect to Azure SQL
 * Utlizes Azure Key Vault for password information

## Notes
* The NSG is defined for reference, but is isn't production-ready as holes are also opened for RDP, and public IPs are allocated
* One VM size is specified for all VMs

## Additional Resources
* <a href="https://docs.microsoft.com/en-us/azure/devops/server/install/install-azure-sql?view=azure-devops" target="_blank">Azure DevOps Server 2019 on Azure SQL Official Documentation</a>
* <a href="https://docs.microsoft.com/en-us/sql/tools/sqlcmd-utility?view=sql-server-ver15" target="_blank">SQLCMD</a> - Used to update Azure SQL Server & Databases with permissions for the Azure DevOps Server Managed Identity.  Part of base image.
* <a href="https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver15" target="_blank">SQL Management Studio</a> - Installed to allow easy management of Azure SQL, plus installs ODBC drivers needed to allow SQL CMD to function correctly.  Part of base image.
* <a href="https://visualstudio.microsoft.com/downloads" target="_blank">Azure DevOps Server 2019</a> - Allows developers to bring all the ideals of DevOps to life via the implmentation of CI/CD pipelines, build agents, version control, and so much more.  Part of base image.
* <a href="https://www.azul.com/downloads/zulu-community/?&architecture=x86-64-bit&package=jdk" target="_blank">Java 8 JDK</a> - If not already installed, Azure DevOps Server will attempt to download and install when implmenting search services as part of normal system configuration.



## ToDo
* Update Azure Key Vault references & params
* Update Azure Customer VM Images with references & params

## NOTICE/WARNING
* This template is explicitly designed for a lab/classroom environment and is intended to offer a way to move forward by allowing you to import the code and make it your own, fully compliant with the organizations security controls which you represent.
 
## Contributing

This project welcomes contributions and suggestions.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) with any additional questions or comments.