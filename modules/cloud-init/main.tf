# Reference: https://registry.terraform.io/providers/hashicorp/cloudinit/latest/docs/data-sources/config
data "cloudinit_config" "frontend" {

  part {
    filename     = var.frontend_config_file
    content_type = "text/cloud-config"

    # Reference: https://developer.hashicorp.com/terraform/language/functions/templatefile#examples
    content = templatefile(var.frontend_config_file, {frontend_vms_listener_port = 80})
  }

}

data "cloudinit_config" "app" {

  part {
    filename     = var.app_config_file
    content_type = "text/cloud-config"

    # Reference: https://developer.hashicorp.com/terraform/language/functions/templatefile#examples
    content = templatefile(var.app_config_file, {frontend_vms_listener_port = 80})
  }

}

data "cloudinit_config" "database" {

  part {
    filename     = var.database_config_file
    content_type = "text/cloud-config"

    # Reference: https://developer.hashicorp.com/terraform/language/functions/templatefile#examples
    content = templatefile(var.database_config_file, {frontend_vms_listener_port = 80})
  }

}