# ============================================================
# Variables du projet CYNA : Déploiement Azure
# ============================================================

variable "subscription_id" {
  description = "ID de l'abonnement Azure"
  type        = string
  sensitive   = true
}

variable "client_id" {
  description = "Client ID du Service Principal"
  type        = string
  sensitive   = true
}

variable "client_secret" {
  description = "Secret du Service Principal"
  type        = string
  sensitive   = true
}

variable "tenant_id" {
  description = "Tenant ID Azure"
  type        = string
  sensitive   = true
}

variable "location" {
  description = "Région Azure"
  type        = string
  default     = "West Europe"
}

variable "resource_group_name" {
  description = "Nom du Resource Group"
  type        = string
  default     = "rg-cyna-prod"
}

variable "environment" {
  description = "Environnement (dev, prod)"
  type        = string
  default     = "prod"
}

variable "admin_username" {
  description = "Nom de l'utilisateur admin"
  type        = string
  default     = "cynaadmin"
}

variable "admin_password" {
  description = "Mot de passe admin (pour les VMs Windows)"
  type        = string
  sensitive   = true
}

variable "vm_size" {
  description = "Taille des VMs"
  type        = string
  default     = "Standard_B2s"
}