# Public IP for Load Balancer
resource "azurerm_public_ip" "lb_public_ip" {
  name                = "${var.resource_group.name}-lb-public-ip"
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Load Balancer
resource "azurerm_lb" "lb" {
  name                = "${var.resource_group.name}-lb"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "${var.resource_group.name}-lb-frontend-public-ip"
    public_ip_address_id = azurerm_public_ip.lb_public_ip.id
  }
}

# Load Balancer HTTP Probe
resource "azurerm_lb_probe" "lb_http_probe" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "${var.resource_group.name}-lb-http-probe"
  port            = 80
}

# Backend Address Pool for Load Balancer
resource "azurerm_lb_backend_address_pool" "lb_backend_addr_pool" {
  name            = "${var.resource_group.name}-lb-backend-addr-pool"
  loadbalancer_id = azurerm_lb.lb.id
}

## Load Balancer Rule
resource "azurerm_lb_rule" "lb_rule" {
  loadbalancer_id                = azurerm_lb.lb.id
  name                           = "${var.resource_group.name}-lb-rule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = azurerm_lb.lb.frontend_ip_configuration[0].name
  disable_outbound_snat          = true
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.lb_backend_addr_pool.id]
  probe_id                       = azurerm_lb_probe.lb_http_probe.id
}

# Network Security Group for Inbound Traffic
resource "azurerm_network_security_group" "inbound_nsg" {
  name                = "${var.resource_group.name}-inbound-nsg"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name

  security_rule {
    name                         = "AllowFrontendInbound"
    priority                     = 100
    direction                    = "Inbound"
    access                       = "Allow"
    protocol                     = "Tcp"
    source_port_range            = "*"
    destination_port_range       = 80
    source_address_prefix        = "*"
    destination_address_prefixes = var.web_subnet.address_prefixes
  }
}

# Associate Inbound NSG with Subnet
resource "azurerm_subnet_network_security_group_association" "inbound_nsg_assoc" {
  subnet_id                 = var.web_subnet.id
  network_security_group_id = azurerm_network_security_group.inbound_nsg.id
}