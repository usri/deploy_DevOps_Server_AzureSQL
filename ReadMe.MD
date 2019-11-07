# Deploy Azure DevOps Server
## Deploys Azure DevOps Server 2019 using Azure SQL Databases
## Quick Start

<a href="https://portal.azure.us/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fusri%2Fdeploy_DevOps_Server_AzureSQL%2Fmaster%2Faad-hybrid-lab%2Fdeploy.json" target="_blank"><img src="http://azuredeploy.net/deploybutton.png"/></a>

## Details
This template assumes that you are a US regulated entity with typical requirements for role seperation and security controls.  This template assumes you will be deploying into a pre-existing environment.  For deployment to be successful, please ensure the following pre-requisites:

* A virtual network exists and has VNET Service Endpoints enabled for Azure SQL & Azure Storage
* An Azure Key Vault exists and a corresponding secret also exists which contains the password of the Azure AD SQL Admin account defined in the template.
 * A user-assigned Azure Managed Identity has been created to serve as the identity of the Azure virtual machine that is deployed as part of this template.
* An Active Directory domain is avalaible for computer join operations and is accessible from within the specified virtual network.
 * As part of the template deployment, you must provide Active Directory domain information to enable the Azure DevOps Server to join your Active Directory domain.
* To automatically deploy all the required infrastructure, utilize our <a href="https://github.com/Microsoft/aad-hybrid-lab" target="_blank">AAD Hybrid Deployment template</a>.
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

## ToDo
* Update Azure Key Vault references & params
* Update Azure Customer VM Images with references & params

## NOTICE/WARNING
* This template is explicitly designed for a lab/classroom environment and is intended to offer a way to move forward by allowing you to import the code and make it your own, fully compliant with the organizations security controls which you represent.
 
## Contributing

This project welcomes contributions and suggestions.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.