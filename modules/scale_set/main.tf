resource "azurerm_orchestrated_virtual_machine_scale_set" "vm-scale-set" {
  name                = "${var.resource_group.name}-${var.scale_set_name}-vm-scale-set"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
  instances           = var.desired_instances

  sku_name = "Standard_D4as_v4"

  boot_diagnostics {
    storage_account_uri = null
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  os_profile {
    custom_data = var.custom_data.rendered
    linux_configuration {
      admin_username                  = "azureuser"
      admin_password                  = "securePassword123!"
      disable_password_authentication = false
    }
  }

  network_interface {
    name    = "${var.resource_group.name}-nic"
    primary = true

    ip_configuration {
      name                                   = "${var.resource_group.name}-ip-configuration"
      subnet_id                              = var.web_subnet.id
      load_balancer_backend_address_pool_ids = [var.load_balancer_backend_addr_pool.id]
      primary                                = true
    }
  }

  platform_fault_domain_count = 1

  zones = ["1", "2", "3"]
}
