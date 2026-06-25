# ============================================================
# VM SaaS Linux : Simulation de la plateforme CYNA
# ============================================================

# IP publique pour la VM SaaS
resource "azurerm_public_ip" "saas_public_ip" {
  name                = "pip-saas-cyna"
  resource_group_name = azurerm_resource_group.cyna_rg.name
  location            = azurerm_resource_group.cyna_rg.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Carte réseau virtuelle
resource "azurerm_network_interface" "saas_nic" {
  name                = "nic-saas-cyna"
  location            = azurerm_resource_group.cyna_rg.location
  resource_group_name = azurerm_resource_group.cyna_rg.name

  ip_configuration {
    name                          = "ipconfig-saas"
    subnet_id                     = azurerm_subnet.servers_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.saas_public_ip.id
  }
}

# VM Linux SaaS
resource "azurerm_linux_virtual_machine" "saas_vm" {
  name                  = "vm-saas-cyna"
  resource_group_name   = azurerm_resource_group.cyna_rg.name
  location              = azurerm_resource_group.cyna_rg.location
  size                  = var.vm_size
  admin_username        = var.admin_username
  network_interface_ids = [azurerm_network_interface.saas_nic.id]

  disable_password_authentication = true

  admin_ssh_key {
    username   = var.admin_username
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  # Script cloud-init pour installer Nginx au premier démarrage
  custom_data = base64encode(file("${path.module}/cloud-init.yaml"))

  tags = {
    role        = "saas-platform"
    environment = var.environment
  }
}