variable "tier" {
  type        = string
  description = "Specifies the pricing tier of Microsoft Defender for Cloud Plans"
}

variable "resourcetype-cspm" {
  type        = string
  description = "Resource Type of CSPM."
}

variable "resourcetype-vm" {
  type        = string
  description = "Resource Type of VM."
}

variable "resourcetype-appservice-db-api" {
  type        = list(string)
  description = "Resource Type of App Service, DB and API."
}

variable "resourcetype-db" {
  type        = list(string)
  description = "Resource Type of DBs."
}

variable "resourcetype-sa" {
  type        = string
  description = "Resource Type of Storage Accounts"
}

variable "resourcetype-containers" {
  type        = string
  description = "Resource Type of Containers"
}

variable "resourcetype-kv" {
  type        = string
  description = "Resource Type of KeyVaults"
}

variable "resourcetype-arm" {
  type        = string
  description = "Resource Type of ARM"
}