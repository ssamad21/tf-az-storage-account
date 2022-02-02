variable "tags" {
  type = map(string)
  description = "Tags needed for CPE garudrails deployment"
  default = {
    environment  = "npd"
    organisation = "cpe"
    platform     = "dap"
    supportteam  = "CPE"
    owner_email  = "ssyed7@kpmg.com.au"
    supporttier  = "8X5"
    project      = "Azure Accelerators"
    cost_centre  = "D0186N"
  }
}

#Mandatory variables for storage account 

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the storage account. Changing this forces a new resource to be created"
  default     = "npd_infra_resource_group"
}

variable "storage_account_name" {
  type        = string
  description = "The name of the storage account. Changing this forces a new resource to be created"
  default     = "stacinfranpdausteast"
}

variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created"
  default     = "Australia East"
}

variable "account_tier" {
  type        = string
  description = "Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid. Changing this forces a new resource to be created"
  default     = "Standard"
}

variable "account_replication_type" {
  type        = string
  description = "Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS"
  default     = "LRS"
}

#Optional variables for storage account 

variable "access_tier" {
  type        = string
  description = "Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot and Cool, defaults to Hot"
  default     = "Hot"
}

variable "account_kind" {
  type        = string
  description = "Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Changing this forces a new resource to be created. Defaults to StorageV2"
  default     = "StorageV2"
}

variable "enable_https_traffic_only" {
  type        = bool
  description = "Boolean flag which forces HTTPS if enabled, see here for more information. Defaults to true"
  default     = true
}

variable "min_tls_version" {
  type        = string
  description = "The minimum supported TLS version for the storage account. Possible values are TLS1_0, TLS1_1, and TLS1_2. Defaults to TLS1_0 for new storage accounts"
  default     = "TLS1_2"
}

variable "is_hns_enabled" {
  type        = bool
  description = "Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2 (see here for more information). Changing this forces a new resource to be created. Note: This can only be true when account_tier is Standard or when account_tier is Premium and account_kind is BlockBlobStorage"
  default     = true
}

variable "allow_blob_public_access" {
  type        = bool
  description = "Allow or disallow public access to all blobs or containers in the storage account. Defaults to false"
  default     = false
}

#Include all the containers you wish to create in this variable

variable "containers" {
  type = map(any)
  default = {
    container_1 = {
      name    = "landing"
    }
    container_2 = {
      name    = "bronze"
    }
    container_3 = {
      name    = "structured"
    }
  }
}