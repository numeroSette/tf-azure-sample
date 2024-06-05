# providers.tf
# This file defines the required providers for the Terraform configuration and sets up the backend for storing the Terraform state in Azure Storage.
# Reference: https://learn.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage?tabs=azure-cli

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }

  # Uncomment the following block to enable remote state storage in Azure Storage.
  # backend "azurerm" {
  #     resource_group_name  = "tfstate"
  #     storage_account_name = "<your storage account name>"
  #     container_name       = "tfstate"
  #     key                  = "terraform.tfstate"
  # }
}

provider "azurerm" {
  features {}
}

# Uncomment the following block to create a resource group for storing Terraform state.
# resource "azurerm_resource_group" "tfstate" {
#   name     = "tfstate"
#   location = "eastus"
# }
