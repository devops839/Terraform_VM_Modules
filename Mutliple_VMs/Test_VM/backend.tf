terraform {
  backend "azurerm" {
    resource_group_name  = "rgsa"
    storage_account_name = "demosa839"                    
    container_name       = "tfstate"                     
    key                  = "prod.terraform.tfstate"     
  }
}
