# Random Pet Name Generator
resource "random_pet" "prefix" {
  prefix = var.definitions.prefix
  length = 1
}

locals {
  resource_group_name     = random_pet.prefix.id
  resource_group_location = var.definitions.location
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name       = local.resource_group_name
  location   = local.resource_group_location

  depends_on = [ random_pet.prefix ]
}
