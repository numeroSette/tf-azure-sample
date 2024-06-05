output "object" {
  description = "(optional) describe your variable"

## azurerm_virtual_network.vnet
# {
#   address_space = list of string
#   bgp_community = string
#   ddos_protection_plan = list of object
#   dns_servers = list of string
#   edge_zone = string
#   encryption = list of object
#   flow_timeout_in_minutes = number
#   guid = string
#   id = string
#   location = string
#   name = string
#   resource_group_name = string
#   subnet = set of object
#   tags = map of string
#   timeouts = {
#     create = string
#     delete = string
#     read = string
#     update = string
#   }
# }
# object

## azurerm_subnet.web-subnet

# {
#   address_prefixes = list of string
#   delegation = list of object
#   enforce_private_link_endpoint_network_policies = bool
#   enforce_private_link_service_network_policies = bool
#   id = string
#   name = string
#   private_endpoint_network_policies_enabled = bool
#   private_link_service_network_policies_enabled = bool
#   resource_group_name = string
#   service_endpoint_policy_ids = set of string
#   service_endpoints = set of string
#   timeouts = {
#     create = string
#     delete = string
#     read = string
#     update = string
#   }
#   virtual_network_name = string
# }
# object

  value = {
    web_subnet = azurerm_subnet.web_subnet
    app_subnet = azurerm_subnet.app_subnet
    database_subnet = azurerm_subnet.database_subnet
  }
}
