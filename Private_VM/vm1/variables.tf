variable "location" {
  default     = "East US"
}
variable "resource_group_name" {}
variable "virtual_network_name" {}
variable "subnet_name" {}
variable "nic_name" {}
variable "vm_name" {}
variable "vm_disk_name" {}
/*# Key Vault ID
variable "key_vault_id" {
  description = "Azure Key Vault ID for fetching secrets."
  type        = string
} */

