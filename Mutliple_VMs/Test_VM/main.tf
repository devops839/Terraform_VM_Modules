module "testvm" {
  source = "../Modules"
  rg = var.rg
  location = var.location
  vnet = var.vnet
  subnet = var.subnet
  nic = var.nic
  vm_name = var.vm_name
  admin_username = var.admin_username
  admin_password = var.admin_password
}