# variable "resource_group_prefix" {
#   type = string
#   default = "rg"
#   description = "Prefix of the resource group name that's will be combined with a random ID"

# }

# variable "resource_group_location" {
#   type = string
#   default = "eastus"
#   description = "The location where resource group will created"
# }

variable "definitions" {
  type        = map(string)
  description = "(optional) describe your variable"

  default = {
    prefix   = "rg"
    location = "eastus"
  }
  
}


