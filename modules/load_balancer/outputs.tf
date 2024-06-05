output "object" {
  description = "(optional) describe your variable"

  # azurerm_lb_backend_address_pool.lb_backend_addr_pool
  # {
  #   backend_ip_configurations = list of string
  #   id = string
  #   inbound_nat_rules = list of string
  #   load_balancing_rules = list of string
  #   loadbalancer_id = string
  #   name = string
  #   outbound_rules = list of string
  #   timeouts = {
  #     create = string
  #     delete = string
  #     read = string
  #     update = string
  #   }
  #   tunnel_interface = list of object
  #   virtual_network_id = string
  # }
  # object

  value = {
    load_balancer_backend_addr_pool = azurerm_lb_backend_address_pool.lb_backend_addr_pool
  } 
}
