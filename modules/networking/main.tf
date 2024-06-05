resource "azurerm_virtual_network" "vnet" {
  name                = "${var.resource_group.name}-default-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
  
}

locals {
  vnet_name = azurerm_virtual_network.vnet.name
}

# Subnet
# Reference: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet
resource "azurerm_subnet" "web_subnet" {
  name                 = "${var.resource_group.name}-web-subnet"
  resource_group_name  = var.resource_group.name
  virtual_network_name = local.vnet_name
  address_prefixes     = ["10.0.0.0/24"]

  depends_on = [ azurerm_virtual_network.vnet ]
}

# Subnet
# Reference: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet
resource "azurerm_subnet" "app_subnet" {
  name                 = "${var.resource_group.name}-app-subnet"
  resource_group_name  = var.resource_group.name
  virtual_network_name = local.vnet_name
  address_prefixes     = ["10.0.1.0/24"]

  depends_on = [ azurerm_virtual_network.vnet ]
}

# Subnet
# Reference: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet
resource "azurerm_subnet" "database_subnet" {
  name                 = "${var.resource_group.name}-database-subnet"
  resource_group_name  = var.resource_group.name
  virtual_network_name = local.vnet_name
  address_prefixes     = ["10.0.2.0/24"]

  depends_on = [ azurerm_virtual_network.vnet ]
}