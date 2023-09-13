terraform {

  required_version = ">= 1.3.3"
  
  backend "azurerm" {
    resource_group_name  = "tfpipeline-rg"
    storage_account_name = "tfpipelinesa"
    container_name       = "terraform"
    key                  = "mdc/enablemdc.tfstate"
  }

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>3.61"
    }
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}

