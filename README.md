# Azure Virtual Network Sample

In this quickstart, you learn about a Terraform script that creates an Azure resource group and a virtual network with two subnets. The script generates the names of the resource group and the virtual network by using a random pet name with a prefix. The script also shows the names of the created resources in output.

The script uses the Azure Resource Manager (azurerm) provider to interact with Azure resources. It uses the Random (random) provider to generate random pet names for the resources.

The script creates the following resources:

A resource group: A container that holds related resources for an Azure solution.

A virtual network: A fundamental building block for your private network in Azure.

Two subnets: Segments of a virtual network's IP address range where you can place groups of isolated resources.

## Prerequisites

Before starting, ensure you have the following:

1. **Azure Account**: An Azure account with an active subscription. If you don't have one, you can [create a free account here](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
    
2. **Azure CLI**: Installed and configured. Follow [this guide](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) based on your operating system.
    
3. **Terraform**: Installed. You can follow the instructions in the [Terraform documentation](https://developer.hashicorp.com/terraform/install) or the [Azure Quickstart guide](https://learn.microsoft.com/en-us/azure/developer/terraform/quickstart-configure).
    
4. **Azure Authentication**: Ensure you are authenticated to Azure via your Microsoft account. Refer to [this guide](https://learn.microsoft.com/en-us/azure/developer/terraform/authenticate-to-azure?tabs=bash#authenticate-to-azure-via-a-microsoft-account).
    
5. **Service Principal**: Create a Service Principal by following [these steps](https://learn.microsoft.com/en-us/azure/developer/terraform/authenticate-to-azure?tabs=bash#create-a-service-principal).


## Quickstart: Authenticate Terraform to Azure

### Setup your Service Principal

1. Ensure you have the right permissions and can use the Azure CLI. Follow these steps:

```shell
az login 
```
```shell
# Retrieving tenants and subscriptions for the selection...

[Tenant and subscription selection]

No     Subscription name               Subscription ID                       Tenant
-----  ------------------------------  ------------------------------------  -----------
[1] *  <azure_subscription_name>       <azure_subscription_id>               <azure_subscription_tenant_name>
```

2. Select your target subscription:

```shell
az account list --query "[?user.name=='<microsoft_account_email>'].{Name:name, ID:id, Default:isDefault}"
```
```shell
[
  {
    "Default": true,
    "ID": "<azure_subscription_id>",
    "Name": "<azure_subscription_name>"
  }
]
```

3. Create a Service Principal:

```shell
az ad sp create-for-rbac --name <service_principal_name> --role Contributor --scopes /subscriptions/<azure_subscription_id>
```
```shell
# Creating 'Contributor' role assignment under scope '/subscriptions/<azure_subscription_id>'
# The output includes credentials that you must protect. 
# Be sure that you do not include these credentials in your code or check the credentials into your source control
# For more information, see https://aka.ms/azadsp-cli
{
  "appId": "<service_principal_appid>",
  "displayName": "<service_principal_name>",
  "password": "<service_principal_password>",
  "tenant": "<azure_subscription_tenant_id>"
}
```

### Method 1: Setup Environment Variables (Recommended)

Once you have the Service Principal credentials, setup in your environment variables as shown below.

On Linux/Mac:

```shell
export ARM_SUBSCRIPTION_ID="<azure_subscription_id>"
export ARM_TENANT_ID="<azure_subscription_tenant_id>"
export ARM_CLIENT_ID="<service_principal_appid>"
export ARM_CLIENT_SECRET="<service_principal_password>"
```

On Windows Powershell:

```shell
$env:ARM_SUBSCRIPTION_ID="<azure_subscription_id>"
$env:ARM_TENANT_ID="<azure_subscription_tenant_id>"
$env:ARM_CLIENT_ID="<service_principal_appid>"
$env:ARM_CLIENT_SECRET="<service_principal_password>"
```

### Method 2: Use Azure Provider block's syntax (Not recommended)

You can specify your Azure subscription's authentication information [directly in the provider block](https://learn.microsoft.com/en-us/azure/developer/terraform/authenticate-to-azure?tabs=bash#specify-service-principal-credentials-in-a-terraform-provider-block). 

This method is not recommended for production environments due to security concerns.

```
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id   = "<azure_subscription_id>"
  tenant_id         = "<azure_subscription_tenant_id>"
  client_id         = "<service_principal_appid>"
  client_secret     = "<service_principal_password>"
}

# Your code goes here
```

> [!CAUTION] <br>
> The ability to specify your Azure subscription credentials in a Terraform configuration file can be convenient - especially when testing. However, it isn't advisable to store credentials in a clear-text file that can be viewed by non-trusted individuals.

## Quickstart: Running Scripts

### Initialize Terraform

Initialize your Terraform workspace. This step downloads and installs the providers defined in the configuration.

```console
terraform init -upgrade
```
```console
Initializing the backend...

Initializing provider plugins...
- Finding hashicorp/random versions matching "~> 3.0"...
- Finding hashicorp/azurerm versions matching "~> 3.0"...
- Using previously-installed hashicorp/azurerm v3.106.1
- Using previously-installed hashicorp/random v3.6.2

Terraform has been successfully initialized!
...
```

### Create a Terraform execution plan

Generate an execution plan to preview the changes Terraform will make to your infrastructure.

```console
terraform plan -out main.tfplan
```

### Show the Terraform execution plan

Optionally, display the execution plan to verify the actions Terraform will take.


```console
terraform show main.tfplan
```
```console
Terraform used the selected providers to generate the following execution plan. 
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # azurerm_resource_group.rg will be created
  + resource "azurerm_resource_group" "rg" {
      + id       = (known after apply)
      + location = "eastus"
      + name     = (known after apply)
    }

  # azurerm_subnet.my_terraform_subnet_1 will be created
  + resource "azurerm_subnet" "my_terraform_subnet_1" {
      + address_prefixes                               = [
          + "10.0.0.0/24",
        ]
      + enforce_private_link_endpoint_network_policies = (known after apply)
      + enforce_private_link_service_network_policies  = (known after apply)
      + id                                             = (known after apply)
      + name                                           = "subnet-1"
...

Plan: 5 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + resource_group_name  = (known after apply)
  + subnet_name_1        = "subnet-1"
  + subnet_name_2        = "subnet-2"
  + virtual_network_name = (known after apply)

```
### Apply a Terraform execution plan

Apply the changes required to reach the desired state of the configuration.

```console
terraform apply main.tfplan
```
```console
terraform apply main.tfplan 
random_pet.prefix: Creating...
random_pet.prefix: Creation complete after 0s [id=rg-octopus]
azurerm_resource_group.rg: Creating...
azurerm_resource_group.rg: Still creating... [10s elapsed]
azurerm_resource_group.rg: Creation complete after 12s [id=/subscriptions/7c901453-2e6a-4ca8-b902-2816a108e01e/resourceGroups/rg-octopus-rg]
azurerm_virtual_network.my_terraform_network: Creating...
azurerm_virtual_network.my_terraform_network: Creation complete after 9s [id=/subscriptions/7c901453-2e6a-4ca8-b902-2816a108e01e/resourceGroups/rg-octopus-rg/providers/Microsoft.Network/virtualNetworks/rg-octopus-vnet]
azurerm_subnet.my_terraform_subnet_1: Creating...
azurerm_subnet.my_terraform_subnet_2: Creating...
azurerm_subnet.my_terraform_subnet_1: Creation complete after 9s [id=/subscriptions/7c901453-2e6a-4ca8-b902-2816a108e01e/resourceGroups/rg-octopus-rg/providers/Microsoft.Network/virtualNetworks/rg-octopus-vnet/subnets/subnet-1]
azurerm_subnet.my_terraform_subnet_2: Still creating... [10s elapsed]
azurerm_subnet.my_terraform_subnet_2: Creation complete after 17s [id=/subscriptions/7c901453-2e6a-4ca8-b902-2816a108e01e/resourceGroups/rg-octopus-rg/providers/Microsoft.Network/virtualNetworks/rg-octopus-vnet/subnets/subnet-2]

Apply complete! Resources: 5 added, 0 changed, 0 destroyed.

Outputs:

resource_group_name = "rg-octopus-rg"
subnet_name_1 = "subnet-1"
subnet_name_2 = "subnet-2"
virtual_network_name = "rg-octopus-vnet"
```

## Verify the results



1. Get the Azure resource group name:

    ```console
    resource_group_name=$(terraform output -raw resource_group_name)
    ```

1. Get the virtual network name:

    ```console
    virtual_network_name=$(terraform output -raw virtual_network_name)
    ```

1. Use [`az network vnet show`](#) to display the details of your newly created virtual network:

    ```azurecli
    az network vnet show \
        --resource-group $resource_group_name \
        --name $virtual_network_name
    ```
    ```azurecli
    {
      "addressSpace": {
        "addressPrefixes": [
          "10.0.0.0/16"
        ]
      },
      "dhcpOptions": {
        "dnsServers": []
      },
      "enableDdosProtection": false,
      "id": "/subscriptions/<azure_subscription_id>/resourceGroups/rg-octopus-rg/providers/Microsoft.Network/virtualNetworks/rg-octopus-vnet",
      "location": "eastus",
      "name": "rg-octopus-vnet",
      "provisioningState": "Succeeded",
      "resourceGroup": "rg-octopus-rg",
      "resourceGuid": "818ea8c8-02c4-4b2b-be47-154327588fc9",
      "subnets": [
        {
          "addressPrefix": "10.0.0.0/24",
          "delegations": [],
          "etag": "W/\"d36fbf28-68a5-4e66-9d2f-8f35c0462d51\"",
          "id": "/subscriptions/<azure_subscription_id>/resourceGroups/rg-octopus-rg/providers/Microsoft.Network/virtualNetworks/rg-octopus-vnet/subnets/subnet-1",
          "name": "subnet-1",
        },
        ...
      ```
## Clean up resources

```bash
terraform plan -destroy -out main.destroy.tfplan
```

## Bonus: Store Terraform state in Azure Storage
By default, Terraform state is stored locally, which isn't ideal for the following reasons:

- Local state doesn't work well in a team or collaborative environment.
- Terraform state can include sensitive information.
- Storing state locally increases the chance of inadvertent deletion.

This bash script will do:
- Generate a Random Number
- Create an Azure storage account
- Use Azure storage to store remote Terraform state.

```bash
#!/bin/bash
UUID=$(cat /dev/urandom | env LC_ALL=C tr -dc 'a-z0-9' | fold -w 17 | head -n 1)
RESOURCE_GROUP_NAME=tfstate
STORAGE_ACCOUNT_NAME=tfstate$UUID
CONTAINER_NAME=tfstate

# Create resource group
az group create --name $RESOURCE_GROUP_NAME --location eastus

# Create storage account
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob

# Create blob container
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME
```
> [!TIP]
> Azure storage accounts require a globally unique name, if you receive a naming error, (same UUID generated), just run again and generate a new one :-)

example output:
```bash
./tfstate.sh
{
  "id": "/subscriptions/<azure_subscription_id>/resourceGroups/tfstate",
  "location": "eastus",
  "managedBy": null,
  "name": "tfstate",
  "properties": {
    "provisioningState": "Succeeded"
  },
  "tags": null,
  "type": "Microsoft.Resources/resourceGroups"
}
{
  "accessTier": "Hot",
  "accountMigrationInProgress": null,
  "allowBlobPublicAccess": false,
  "allowCrossTenantReplication": false,
  "allowSharedKeyAccess": null,
  "allowedCopyScope": null,
  "azureFilesIdentityBasedAuthentication": null,
  "blobRestoreStatus": null,
  "creationTime": "2024-06-04T09:10:46.979614+00:00",
  ...
```

## Authors
Originally created by [Azure Team](https://github.com/Azure/terraform)