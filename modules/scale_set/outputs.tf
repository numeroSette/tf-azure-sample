output "object" {
  description = "(optional) describe your variable"

  # azurerm_orchestrated_virtual_machine_scale_set.vm-scale-set
  # {
  #   additional_capabilities = list of object
  #   automatic_instance_repair = list of object
  #   boot_diagnostics = list of object
  #   capacity_reservation_group_id = string
  #   data_disk = list of object
  #   encryption_at_host_enabled = bool
  #   eviction_policy = string
  #   extension = set of object
  #   extension_operations_enabled = bool
  #   extensions_time_budget = string
  #   id = string
  #   identity = list of object
  #   instances = number
  #   license_type = string
  #   location = string
  #   max_bid_price = number
  #   name = string
  #   network_interface = list of object
  #   os_disk = list of object
  #   os_profile = list of object
  #   plan = list of object
  #   platform_fault_domain_count = number
  #   priority = string
  #   priority_mix = list of object
  #   proximity_placement_group_id = string
  #   resource_group_name = string
  #   single_placement_group = bool
  #   sku_name = string
  #   source_image_id = string
  #   source_image_reference = list of object
  #   tags = map of string
  #   termination_notification = list of object
  #   timeouts = {
  #     create = string
  #     delete = string
  #     read = string
  #     update = string
  #   }
  #   unique_id = string
  #   user_data_base64 = string
  #   zone_balance = bool
  #   zones = set of string
  # }
  # object

  value = azurerm_orchestrated_virtual_machine_scale_set.vm-scale-set
}
