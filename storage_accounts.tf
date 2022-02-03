terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
  required_version = ">= 0.13"
}

resource "azurerm_resource_group" "resource_group_infra" {
  #Required
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}
resource "azurerm_storage_account" "storage_account_npd" {
  #Required
  name                          = var.storage_account_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  account_tier                  = var.account_tier
  account_replication_type      = var.account_replication_type
  #Optional
  access_tier                   = var.access_tier
  account_kind                  = var.account_kind
  enable_https_traffic_only     = var.enable_https_traffic_only
  min_tls_version               = var.min_tls_version
  is_hns_enabled                = var.is_hns_enabled
  allow_blob_public_access      = var.allow_blob_public_access  
}

#Create "containers" for datalake storage account
resource "azurerm_storage_container" "containers" {
  for_each              = var.containers
  storage_account_name  = var.storage_account_name
  name                  = each.value["name"]
  container_access_type = "private"
}
#Create data management policy for each container created above.

resource "azurerm_storage_management_policy" "storage_management_policy" {
  storage_account_id = azurerm_storage_account.storage_account_npd.id

  rule {
    name    = "landing-archive-after-30-days"
    enabled = true
    filters {
      prefix_match = ["landing/"]
      blob_types   = ["blockBlob"]
    }
    actions {
      base_blob {
        tier_to_archive_after_days_since_modification_greater_than = 30
      }
    }
  }
  rule {
    name    = "bronze-cool-after-30-days"
    enabled = true
    filters {
      prefix_match = ["bronze/"]
      blob_types   = ["blockBlob"]
    }
    actions {
      base_blob {
        tier_to_cool_after_days_since_modification_greater_than    = 30
      }
    }
  }
 rule {
    name    = "structured-delete-after-30-days"
    enabled = true
    filters {
      prefix_match = ["structured/"]
      blob_types   = ["blockBlob"]
    }
    actions {
      base_blob {
        delete_after_days_since_modification_greater_than          = 30
      }
    }
  } 
}