variable "resource_group" {
    description = "(optional) describe your variable"
}

variable "web_subnet" {
    description = "(optional) describe your variable"
}

variable "load_balancer_backend_addr_pool" {
    description = "(optional) describe your variable"
    default = {
        id = ""
    }
}

variable "desired_instances" {
    description = "(optional) describe your variable"
    default = 1
}

variable "custom_data" {
    description = "(optional) describe your variable"
}

variable "scale_set_name" {
    description = "(optional) describe your variable"
}