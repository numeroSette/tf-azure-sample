output "object" {
  description = "(optional) describe your variable"

  # azurerm_resource_group.rg
  # {
  #   id = string
  #   location = string
  #   managed_by = string
  #   name = string
  #   tags = map of string
  #   timeouts = {
  #     create = string
  #     delete = string
  #     read = string
  #     update = string
  #   }
  # }
  # object

  value = {
    name     = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
  }
}
