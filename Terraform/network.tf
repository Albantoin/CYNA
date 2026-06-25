# ============================================================
# Réseau Azure : VNet, Subnets, NSG
# ============================================================

# Resource Group
resource "azurerm_resource_group" "cyna_rg" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    project     = "CYNA"
    environment = var.environment
    managed_by  = "Terraform"
  }
}

# Virtual Network
resource "azurerm_virtual_network" "cyna_vnet" {
  name                = "vnet-cyna-azure"
  address_space       = ["172.16.0.0/16"]
  location            = azurerm_resource_group.cyna_rg.location
  resource_group_name = azurerm_resource_group.cyna_rg.name
}

# Subnet pour les serveurs
resource "azurerm_subnet" "servers_subnet" {
  name                 = "snet-servers"
  resource_group_name  = azurerm_resource_group.cyna_rg.name
  virtual_network_name = azurerm_virtual_network.cyna_vnet.name
  address_prefixes     = ["172.16.1.0/24"]
}

# Subnet pour la passerelle VPN
resource "azurerm_subnet" "gateway_subnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.cyna_rg.name
  virtual_network_name = azurerm_virtual_network.cyna_vnet.name
  address_prefixes     = ["172.16.255.0/27"]
}

# Network Security Group
resource "azurerm_network_security_group" "cyna_nsg" {
  name                = "nsg-cyna-servers"
  location            = azurerm_resource_group.cyna_rg.location
  resource_group_name = azurerm_resource_group.cyna_rg.name

  security_rule {
    name                       = "Allow-SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-HTTPS"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-HTTP"
    priority                   = 1003
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Association NSG / Subnet
resource "azurerm_subnet_network_security_group_association" "servers_nsg_assoc" {
  subnet_id                 = azurerm_subnet.servers_subnet.id
  network_security_group_id = azurerm_network_security_group.cyna_nsg.id
}