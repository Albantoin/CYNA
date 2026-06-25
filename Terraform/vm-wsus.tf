# ============================================================
# VM WSUS : Serveur de mises à jour Windows
# ============================================================

resource "azurerm_network_interface" "wsus_nic" {
  name                = "nic-wsus-cyna"
  location            = azurerm_resource_group.cyna_rg.location
  resource_group_name = azurerm_resource_group.cyna_rg.name

  ip_configuration {
    name                          = "ipconfig-wsus"
    subnet_id                     = azurerm_subnet.servers_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "wsus_vm" {
  name                  = "vm-wsus-cyna"
  resource_group_name   = azurerm_resource_group.cyna_rg.name
  location              = azurerm_resource_group.cyna_rg.location
  size                  = "Standard_B2ms"
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  network_interface_ids = [azurerm_network_interface.wsus_nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }

  tags = {
    role        = "update-server"
    environment = var.environment
  }
}