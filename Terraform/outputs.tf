# ============================================================
# Sorties Terraform : Informations affichées après apply
# ============================================================

output "resource_group_name" {
  description = "Nom du Resource Group créé"
  value       = azurerm_resource_group.cyna_rg.name
}

output "saas_public_ip" {
  description = "IP publique de la VM SaaS"
  value       = azurerm_public_ip.saas_public_ip.ip_address
}

output "saas_private_ip" {
  description = "IP privée de la VM SaaS"
  value       = azurerm_network_interface.saas_nic.private_ip_address
}

output "veeam_private_ip" {
  description = "IP privée de la VM Veeam"
  value       = azurerm_network_interface.veeam_nic.private_ip_address
}

output "wsus_private_ip" {
  description = "IP privée de la VM WSUS"
  value       = azurerm_network_interface.wsus_nic.private_ip_address
}

output "vnet_id" {
  description = "ID du Virtual Network"
  value       = azurerm_virtual_network.cyna_vnet.id
}