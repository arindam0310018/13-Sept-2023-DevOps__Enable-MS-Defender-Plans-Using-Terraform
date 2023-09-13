#############################
## Enable Defender Plans:-
#############################

########################################################
## Defender CSPM (Cloud Security Posture Management):-
########################################################

resource "azurerm_security_center_subscription_pricing" "az-mdc-cspm" {
  tier          = var.tier
  resource_type = var.resourcetype-cspm

  extension {
      additional_extension_properties = {
          ExclusionTags = jsonencode([])
            }
            name = "AgentlessVmScanning"
        }
  extension {
      additional_extension_properties = {}
            name = "AgentlessDiscoveryForKubernetes"
        }
  extension {
      additional_extension_properties = {}
            name = "ContainerRegistriesVulnerabilityAssessments"
        }
  extension {
      additional_extension_properties = {}
            name = "SensitiveDataDiscovery"
        }
}

#################################################
## CWP (Cloud Workload Protection) for Servers:-
#################################################

resource "azurerm_security_center_subscription_pricing" "az-mdc-servers" {
  tier          = var.tier
  resource_type = var.resourcetype-vm
  subplan       = "P2"

  extension {
    additional_extension_properties = {
        ExclusionTags = jsonencode([])
            }
            name  = "AgentlessVmScanning"
      } 
}

#################################################
## CWP (Cloud Workload Protection) for:-
## App Service
## Databases
## API
#################################################

resource "azurerm_security_center_subscription_pricing" "az-mdc-appservice-db-api" {
  count         = length(var.resourcetype-appservice-db-api)
  tier          = var.tier
  resource_type = var.resourcetype-appservice-db-api[count.index]
}

#################################################
## CWP (Cloud Workload Protection) for:-
## Databases

## This Block was added because of below Errors:-

# Error: setting Pricing (Subscription: "210e66cb-55cf-424e-8daa-6cad804ab604"
# Pricing Name: "CosmosDbs"): pricings.PricingsClient#Update: Failure responding to request: StatusCode=409 -- Original Error: autorest/azure: Service returned an error. Status=409 Code="Conflict" Message="Another update operation is in progress"
# with azurerm_security_center_subscription_pricing.az-mdc-appservice-db-api[4],
# on enable-defender-plans.tf line 57, in resource "azurerm_security_center_subscription_pricing" "az-mdc-appservice-db-api":
# 57: resource "azurerm_security_center_subscription_pricing" "az-mdc-appservice-db-api" {

# Error: setting Pricing (Subscription: "210e66cb-55cf-424e-8daa-6cad804ab604"
# Pricing Name: "SqlServerVirtualMachines"): pricings.PricingsClient#Update: Failure responding to request: StatusCode=409 -- Original Error: autorest/azure: Service returned an error. Status=409 Code="Conflict" Message="Another update operation is in progress"
# with azurerm_security_center_subscription_pricing.az-mdc-appservice-db-api[2],
# on enable-defender-plans.tf line 57, in resource "azurerm_security_center_subscription_pricing" "az-mdc-appservice-db-api":
# 57: resource "azurerm_security_center_subscription_pricing" "az-mdc-appservice-db-api" {

#################################################
resource "azurerm_security_center_subscription_pricing" "az-mdc-db" {
  count         = length(var.resourcetype-db)
  tier          = var.tier
  resource_type = var.resourcetype-db[count.index]

  depends_on = [
    azurerm_security_center_subscription_pricing.az-mdc-appservice-db-api
 ]
}

#################################################
## CWP (Cloud Workload Protection) for Storage:-
#################################################

resource "azurerm_security_center_subscription_pricing" "az-mdc-storage" {
  tier          = var.tier
  resource_type = var.resourcetype-sa
  subplan       = "DefenderForStorageV2"

  extension {
      additional_extension_properties = {
          CapGBPerMonthPerStorageAccount = "5000"
            }
          name  = "OnUploadMalwareScanning"
        }
  extension {
      additional_extension_properties = {}
          name  = "SensitiveDataDiscovery"
        }
}

####################################################
## CWP (Cloud Workload Protection) for Containers:-
####################################################

resource "azurerm_security_center_subscription_pricing" "az-mdc-containers" {
  tier          = var.tier
  resource_type = var.resourcetype-containers

  extension {
      additional_extension_properties = {}
          name  = "AgentlessDiscoveryForKubernetes"
        }
  extension {
      additional_extension_properties = {}
          name  = "ContainerRegistriesVulnerabilityAssessments"
        }
}

####################################################
## CWP (Cloud Workload Protection) for Keyvaults:-
####################################################

resource "azurerm_security_center_subscription_pricing" "az-mdc-kv" {
  tier          = var.tier
  resource_type = var.resourcetype-kv
  subplan       = "PerKeyVault"
}

###############################################
## CWP (Cloud Workload Protection) for ARM :-
###############################################

resource "azurerm_security_center_subscription_pricing" "az-mdc-arm" {
  tier          = var.tier
  resource_type = var.resourcetype-arm
  subplan       = "PerApiCall"
}
